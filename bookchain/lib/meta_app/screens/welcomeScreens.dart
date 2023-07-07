import 'package:bookchain/meta_app/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/helpers/routers/constant_route.dart';
import '../components/rounded_button.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';

import 'homePage.dart';
import 'signupScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Image.asset(
              'assets/images/resim1.png',
              height: size.height * 0.4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo1.png',
                  height: size.height * 0.14,
                ),
                Text(
                  Strings.stringInstance.title,
                  style: GoogleFonts.bebasNeue(
                    fontWeight: FontWeight.w300,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 25, bottom: 30),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. Urna feugiat facilisis nec elementum. Faucibus tempus sapien congue facilisis erat et aliquet.',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            RoundedButton(
              text: Strings.stringInstance.loginSignIn,
              textColor: Colors.white,
              color: ColorSpecs.colorInstance.kPrimaryColor,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: size.width * 0.8,
              height: size.height * 0.07,
              child: ClipRRect(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 5,
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: Text(
                    Strings.stringInstance.signIn,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
