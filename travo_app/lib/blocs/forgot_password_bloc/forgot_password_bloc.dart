import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/repo/auth_repo/auth_repo.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _userRepository;

  ForgotPasswordBloc({required AuthRepository userRepo})
      : _userRepository = userRepo,
        super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) {});

    on<ForgotPasswordRequired>(_onForgotPasswordRequest);
  }

  void _onForgotPasswordRequest(
      ForgotPasswordRequired event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordProcess());
    try {
      await _userRepository.forgotPassword(event.email);
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordFailure(errorMsg: e.code));
    } catch (e) {
      emit(const ForgotPasswordFailure());
    }
  }
}
