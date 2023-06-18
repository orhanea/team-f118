import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';
import 'package:bookchain/meta_app/helpers/routers/constant_route.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/rounded_button.dart';

class VerificationScreen extends StatefulWidget {

  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();

}

class _VerificationScreenState extends State<VerificationScreen> {

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
                'assets/images/resim5.png',
                height: size.height * 0.40,
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              //Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.stringInstance.otp,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          Strings.stringInstance.forgotPassLabel,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            color: const Color(0xff808080),
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.06),
              //OTP input alanları
              OtpTextField(focusedBorderColor: ColorSpecs.colorInstance.kPrimaryColor),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: Strings.stringInstance.codeOTP,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerificationScreen()));
                }, color: ColorSpecs.colorInstance.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

}



