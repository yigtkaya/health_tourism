import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.isAuth, this.email, this.password, this.error);

  final bool isAuth;
  final String? email;
  final String? password;
  final String? error;



  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}


