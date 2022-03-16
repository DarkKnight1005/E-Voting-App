part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInRequestedEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
class VerificationEmailSent extends AuthEvent {
  
}

class SignUpRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequestedEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}
