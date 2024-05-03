part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;
  final bool isSavePass;

  const SignInRequired({required this.email, required this.password,required this.isSavePass});

  @override
  List<Object> get props => [email, password];
}

final class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}

final class GetMyUserRequired extends SignInEvent {
  const GetMyUserRequired();
}

final class GetUserByEmail extends SignInEvent {
  final String email;
  const GetUserByEmail(this.email);
}
