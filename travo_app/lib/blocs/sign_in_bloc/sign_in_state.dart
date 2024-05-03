part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

class SignInProcess extends SignInState {}

class SignInFailure extends SignInState {
  final String? errorMsg;

  const SignInFailure({this.errorMsg});
  @override
  List<Object> get props => [errorMsg!];
}

class SignInSuccess extends SignInState {}

class GetMyUser extends SignInState {
  final MyUser? myUser;

  const GetMyUser({this.myUser});
  @override
  List<Object> get props => [myUser!];
}
