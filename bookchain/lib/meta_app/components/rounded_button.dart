import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color textColor;
  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.textColor = Colors.white, required Color color,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: size.width * 0.8,
      height: size.height * 0.07,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorSpecs.colorInstance.kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: press,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
