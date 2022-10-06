import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle headline = GoogleFonts.montserrat(
    fontSize: 32.sp,
    color: Colors.white,
  );

  static TextStyle title0 = GoogleFonts.montserrat(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static TextStyle title1 = GoogleFonts.montserrat(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle categoryName = GoogleFonts.montserrat(
    fontSize: 48.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle label = GoogleFonts.montserrat(
    fontSize: 16.sp,
    color: Colors.white,
  );

  static TextStyle appBarTitle = GoogleFonts.montserrat(
    fontSize: 24.sp,
    color: Colors.white,
  );

  static TextStyle smallestText = GoogleFonts.montserrat(
    fontSize: 12.sp,
    color: Colors.white,
  );
}
