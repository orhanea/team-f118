import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/components/rounded_button.dart';
import 'package:bookchain/meta_app/components/rounded_input_field.dart';
import 'package:bookchain/meta_app/components/rounded_password_field.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:bookchain/meta_app/components/loadingScreen.dart';
import 'package:bookchain/meta_app/screens/homePage.dart';
import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
  
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool googleLoading = false;
  String errorMessage = '';

  Future<void> signInUser() async {
    try {
      setState(() {
        loading = true;
        errorMessage = '';
      });

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = 'Please enter email and password';
          loading = false;
        });
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChainPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Invalid email or password';
        loading = false;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        googleLoading = true;
        errorMessage = '';
      });

      // Trigger the Google sign-in flow.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the authentication details from the Google user.
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential using the Google authentication details.
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential.
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          setState(() {
            googleLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to sign in with Google. Please try again.';
        googleLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? LoadingScreen()
        : Scaffold(
            body: SizedBox(
              height: size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Image.asset(
                      'assets/images/resim3.png',
                      height: size.height * 0.38,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.stringInstance.email,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        RoundedInputField(
                          icon: Icons.mail,
                          hintText: 'Enter your email',
                          onChanged: (value) {
                            emailController.text = value;
                          },
                          myController: emailController,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.stringInstance.formPassword,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RoundedPasswordField(
                              onChanged: (value) {
                                passwordController.text = value;
                              },
                              myController: passwordController,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                Strings.stringInstance.formForgotPass,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: const Color(0xff505967),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    RoundedButton(
                      text: Strings.stringInstance.signIn,
                      press: () async {
                        signInUser();
                      },
                      color: ColorSpecs.colorInstance.kPrimaryColor,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xffC7C7C7),
                              height: 1.5,
                              thickness: 1.5,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              Strings.stringInstance.loginTextOr,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff808080),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0xffC7C7C7),
                              height: 1.5,
                              thickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.008,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: size.width * 0.8,
                      height: size.height * 0.07,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                width: 3,
                                color: Color(0xffA7CAFF),
                              ),
                            ),
                          ),
                          onPressed: _signInWithGoogle,
                          child: Image.asset(
                            'assets/icons/googleicon.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.001,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
