import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequestedEvent>(_signIn);
    on<SignUpRequestedEvent>(_signUp);
    on<SignOutRequested>(_signOut);
  }

  Future<void> _signIn(
      SignInRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authRepository.signIn(email: event.email, password: event.password);

      emit(Authenticated());
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
    } catch (e) {
      emit(AuthError(e.toString()));      emit(Unauthenticated());
    }
  }

  Future<void> _signOut(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await authRepository.signOut();
          emit(Unauthenticated());
  }
}
