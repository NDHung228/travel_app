part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String? errorMsg;

  const SignUpFailure({this.errorMsg});

  @override
  List<Object> get props => [errorMsg!];
}

class SignUpProcess extends SignUpState {}
