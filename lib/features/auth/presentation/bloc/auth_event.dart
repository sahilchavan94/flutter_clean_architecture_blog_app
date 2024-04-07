part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthIsUserLoggedIn extends AuthEvent {}

class AuthSignup extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  AuthSignup({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthSignIn(
    this.email,
    this.password,
  );
}

class AuthSignOut extends AuthEvent {}
