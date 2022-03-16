import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequestedEvent>(_signIn);
    on<SignUpRequestedEvent>(_signUp);
    on<SignOutRequested>(_signOut);
    // on<VerificationEmailSent>(_verifyEmail);
  }

  bool isEmailVerified = false;
  bool canResendEmail = false;

  Future<void> _signIn(
      SignInRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepository.signIn(email: event.email, password: event.password);

      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> _signUp(
      SignUpRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepository.signUp(email: event.email, password: event.password);

      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message!));
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future _signOut(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await authRepository.signOut();
    emit(Unauthenticated());
  }

  Future<void> _verifyEmail(
      VerificationEmailReceived event, Emitter<AuthState> emit) async {
    try {
      final user = authRepository.firebaseAuth.currentUser!;
      await user.sendEmailVerification();
      canResendEmail = false;
      await Future.delayed(Duration(seconds: 5));
      canResendEmail = true;

      emit(VerificationEmailReceived());
      emit(Authenticated());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> checkEmailVerified() async {
    await authRepository.firebaseAuth.currentUser!.reload();
    isEmailVerified = authRepository.firebaseAuth.currentUser!.emailVerified;
  }
}
