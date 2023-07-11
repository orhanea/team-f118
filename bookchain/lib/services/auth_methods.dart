import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookchain/meta_app/screens/chainPage.dart';

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
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        if (userCredential.user != null) {
          await createUserCollection(
            userId: userCredential.user!.uid,
            username: userName!,
            email: email!,
            password: password!,
          );
        }
      } catch (error) {
        errorMessage = 'Failed to create user. Please try again.';
      }
    }
  }

  Future<bool> signInUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user's password matches the provided password
      if (userCredential.user != null) {
        // Fetch the user document from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // Get the stored password from the user document
        String storedPassword = userDoc.get('password');

        // Check if the stored password matches the provided password
        if (storedPassword == password) {
          // Passwords match, proceed to the home page or desired screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChainPage(),
            ),
          );
          return true;
        } else {
          // Passwords don't match, display an error message
          errorMessage = 'Incorrect password. Please try again.';
          return false;
        }
      } else {
        errorMessage =
            'Failed to sign in. Please check your credentials and try again.';
        return false;
      }
    } catch (error) {
      errorMessage =
          'Failed to sign in. Please check your credentials and try again.';
      return false;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            // Do something if the user is new
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
  
  Future<void> createUserCollection({
    required String userId,
    required String username,
    required String email,
    required String password,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users.doc(userId).set({
        'username': username,
        'email': email,
        'password': password,
      });
    } catch (error) {
      errorMessage = "Failed to create user. Please try again.";
    }
  }
}
