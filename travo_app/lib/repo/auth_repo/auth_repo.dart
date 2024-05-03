import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/models/user_model.dart';

abstract class AuthRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> forgotPassword(String email);

  Future<void> signIn(String email, String password,bool isSavePass);

  Future<void> logOut();

  Future<void> saveUserData(MyUser user);
  
  Future<MyUser?> getUserData();
  Future<MyUser?> getUserByEmail(String email);

}
