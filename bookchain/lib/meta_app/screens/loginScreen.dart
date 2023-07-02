import 'package:bookchain/meta_app/components/rounded_button.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:bookchain/meta_app/screens/createNewGoal.dart';
import 'package:bookchain/meta_app/screens/forgotPassword.dart';
import 'package:bookchain/meta_app/screens/homePage.dart';
import 'package:bookchain/meta_app/screens/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookchain/services/auth_methods.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/already_have_account.dart';
import '../components/rounded_input_field.dart';
import '../components/rounded_password_field.dart';
import 'chainPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authorizations myAuth = Authorizations();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                    onChanged: (value) {},
                    myController: email,
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
                        onChanged: (value) {},
                        myController: password,
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
                  try {
                    await myAuth.signInUser(
                      email: email.text,
                      password: password.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChainPage(),
                      ),
                    );
                  } catch (error) {
                    // Handle any error that occurs during login, such as displaying an error message.
                  }
                },
                color: ColorSpecs.colorInstance.kPrimaryColor,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                    onPressed: () {},
                    child: Image.asset(
                      'assets/icons/googleicon.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.001,
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
