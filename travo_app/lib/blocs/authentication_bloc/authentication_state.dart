part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final User? user;
  const Authenticated({this.user});

  @override
  List<Object> get props => [user!];
}

final class UnAuthenticated extends AuthenticationState {}

final class Unknown extends AuthenticationState {}
