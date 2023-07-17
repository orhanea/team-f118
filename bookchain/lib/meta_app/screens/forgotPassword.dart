import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();

}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  Authorizations auth = Authorizations();

  void _sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
    } catch (e) {
      // Handle errors when sending the password reset email
      print('Error sending password reset email: $e');
    }
  }

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
                height: size.height * 0.1,
              ),
              Image.asset(
                'assets/images/resim4.png',
                height: size.height * 0.40,
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.stringInstance.formForgotPass,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          Strings.stringInstance.doNotWorry,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            color: const Color(0xff808080),
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.stringInstance.emailOTP,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            RoundedInputField(
                                myController: auth.mail,
                              icon: Icons.mail,
                              hintText: 'Enter email',
                              onChanged: (value) {}
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        RoundedButton(
                          text: Strings.stringInstance.codeOTP,
                          press: () async {
                            _sendPasswordResetEmail(auth.mail.text.trim());
                          },
                          color: ColorSpecs.colorInstance.kPrimaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
