import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/models/user_model.dart';
import 'package:travo_app/repo/auth_repo/auth_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _userRepository;

  SignUpBloc({required AuthRepository userRepo})
      : _userRepository = userRepo,
        super(SignUpInitial()) {
    on<SignUpRequired>(_onSignUpRequest);
  }

  void _onSignUpRequest(SignUpRequired event, Emitter<SignUpState> emit) async {
    emit(SignUpProcess());
    try {
      String phoneNumber = extractPhoneNumber(event.user.phone!);
      var user = event.user.copyWith(
        phone: phoneNumber,
      );

      MyUser userResult = await _userRepository.signUp(user, event.password);
      await _userRepository.saveUserData(userResult);
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignUpFailure(errorMsg: e.code));
    } catch (e) {
      emit(const SignUpFailure());
    }
  }

  String extractPhoneNumber(String phoneNumberWithPrefix) {
    List<String> parts = phoneNumberWithPrefix.split('|');
    if (parts.length == 2) {
      return parts[1].trim();
    }
    return phoneNumberWithPrefix;
  }
}
