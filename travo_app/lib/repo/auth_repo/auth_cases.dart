import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/user_model.dart';
import 'package:travo_app/repo/auth_repo/auth_repo.dart';

import 'dart:developer';

class AuthCases implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection =
      FirebaseFirestore.instance.collection(CollectionConstant.USER_COLLECTION);

  AuthCases({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password, bool isSavePass) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email!, password: password);

      myUser = myUser.copyWith(
        userId: user.user!.uid,
      );

      if (user.user != null) {
        await user.user!.sendEmailVerification();
      } else {}

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.userId).set(user.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser?> getUserData() async {
    try {
      User? user = _firebaseAuth.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await usersCollection.doc(user!.uid).get();
      if (userSnapshot.exists) {
        return MyUser.fromJson(userSnapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser?> getUserByEmail(String email) async {
    try {
      // DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      //     await usersCollection.doc(user!.uid).get();

      final userSnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.USER_COLLECTION)
          .where('email', isEqualTo: email)
          .get();

      print('demo correct ${userSnapshot.docs.first.data()}');
      if (userSnapshot.docs.isNotEmpty) {
        var promoData =
            userSnapshot.docs.first.data(); // Cast to the appropriate type
        return MyUser.fromJson(promoData);
      } else {
        // If no promo is found, return null
        return null;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
