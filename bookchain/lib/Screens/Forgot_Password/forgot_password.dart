import 'package:bookchain/Screens/Otp_Verification/password_verif.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
                          'Forgot Password ?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          """Don't worry it's occurs. Please enter the email address \nlinked with your account.""",
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
                              'Email',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            RoundedInputField(
                              icon: Icons.mail,
                              hintText: 'Enter email',
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        RoundedButton(
                          text: 'Send Code',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationScreen(),
                              ),
                            );
                          },
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
