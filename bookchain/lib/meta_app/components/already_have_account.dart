import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    super.key,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            " Register",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: ColorSpecs.colorInstance.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
