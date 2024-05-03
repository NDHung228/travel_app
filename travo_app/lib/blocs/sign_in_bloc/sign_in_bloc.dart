import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/models/user_model.dart';
import 'package:travo_app/repo/auth_repo/auth_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _userRepository;
  SignInBloc({required AuthRepository userRepo})
      : _userRepository = userRepo,
        super(SignInInitial()) {
    on<SignInRequired>(_onSignInRequest);

    on<SignOutRequired>(_onSignOutRequest);

    on<GetMyUserRequired>(_onGetMyUser);
    on<GetUserByEmail>(_onGetMyUserByEmail);

  }

  void _onSignInRequest(SignInRequired event, Emitter<SignInState> emit) async {
    emit(SignInProcess());
    try {
      await _userRepository.signIn(event.email, event.password,event.isSavePass);
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(errorMsg: e.code));
    } catch (e) {
      emit(const SignInFailure());
    }
  }

  void _onSignOutRequest(
      SignOutRequired event, Emitter<SignInState> emit) async {
    await _userRepository.logOut();
  }

  void _onGetMyUser(GetMyUserRequired event, Emitter<SignInState> emit) async {
    
    emit(SignInProcess());
    try {
      MyUser? myUser = await _userRepository.getUserData();
      print('check user ${myUser}');
      emit(GetMyUser(myUser: myUser));
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(errorMsg: e.code));
    } catch (e) {
      emit(const SignInFailure());
    }
  }

    void _onGetMyUserByEmail(GetUserByEmail event, Emitter<SignInState> emit) async {
    
    emit(SignInProcess());
    try {
      MyUser? myUser = await _userRepository.getUserByEmail(event.email);
      print('check user by email ${myUser}'); 
      emit(GetMyUser(myUser: myUser));
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(errorMsg: e.code));
    } catch (e) {
      emit(const SignInFailure());
    }
  } 
}
