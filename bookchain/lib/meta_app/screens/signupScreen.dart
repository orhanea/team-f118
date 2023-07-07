import 'package:bookchain/meta_app/components/rounded_button.dart';
import 'package:bookchain/meta_app/components/rounded_input_field.dart';
import 'package:bookchain/meta_app/components/rounded_password_field.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:bookchain/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Authorizations myAuth = Authorizations();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                'assets/images/resim2.png',
                height: size.height * 0.38,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.stringInstance.userName,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  RoundedInputField(
                    myController: myAuth.username,
                    icon: Icons.person,
                    hintText: 'Enter your username',
                    onChanged: (value) {
                      setState(() {
                        myAuth.userName = value;
                      });
                    },
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
                    Strings.stringInstance.email,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  RoundedInputField(
                    myController: myAuth.mail,
                    icon: Icons.email,
                    hintText: 'Enter your email',
                    onChanged: (value) {
                      setState(() {
                        myAuth.email = value;
                      });
                    },
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
                  RoundedPasswordField(
                    myController: myAuth.passwords,
                    onChanged: (value) {
                      setState(() {
                        myAuth.password = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RoundedButton(
                text: Strings.stringInstance.signIn,
                press: () {
                  myAuth
                      .createUserAndCollection(); // Register the user when the button is pressed
                },
                color: ColorSpecs.colorInstance.kPrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  Strings.stringInstance.policyText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
