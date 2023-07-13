import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyles styleInstance = TextStyles._init();

  TextStyles._init();

  TextStyle large = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 36,
  );
  TextStyle title1 = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  TextStyle title2 = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  TextStyle largeMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
  TextStyle largeRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 17,
  );
  TextStyle smallMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
  TextStyle verySmallMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );
  TextStyle smallRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  TextStyle donationText = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );
}
