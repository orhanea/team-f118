import 'package:bookchain/meta_app/helpers/usage/toast_message.dart';
import 'package:bookchain/meta_app/screens/homePage.dart';
import 'package:bookchain/meta_app/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Authorizations {

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  //Email sign up
  void signUpWithEmail({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) =>
      {
        print("User is created.")
      });
      addUserDetails(
          userName,
          email,
          password,
      );
    } catch (e) {
      print(e);
    }
  }

  void signIn({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>
      {
        print("User is registered.")
      });
    } catch (e) {
      print(e);
    }
  }

  Future addUserDetails(String userName, String email, String password) async {
    await FirebaseFirestore.instance.collection("Users").add({
      'User name': userName,
      'Email': email,
      'Password': password,
    });
  }
}
