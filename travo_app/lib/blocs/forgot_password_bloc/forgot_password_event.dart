part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequired extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordRequired({required this.email});
}
