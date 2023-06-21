import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class Authorizations {
  
  String? userName;
  String? email;
  String? password;
  String? errorMessage;

  TextEditingController mail = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController passwords = TextEditingController();

  Future<void> createUserAndCollection() async {
    if (userName != null && email != null && password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        if ( userCredential.user != null ) {
          await createUserCollection(
            userId: userCredential.user!.uid,
            username: userName!,
            email: email!,
            password: password!,
          );
        }
      } catch ( error ) {
        errorMessage = 'Failed to create user. Please try again.';
      }
    }
  }

  Future<void> createUserCollection( {
    required String userId,
    required String username,
    required String email,
    required String password,
  } ) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.doc(userId).set({
        'username': username,
        'email': email,
        'password': password,
      });
    } catch ( error ) {
      var errorMessage = "Failed to create user. Please try again.";
    }
  }
  
}
