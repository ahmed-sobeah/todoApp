import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class LightAppStyles{
  static TextStyle appbar = GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.w700,color: ColorsManger.white);
  static TextStyle themeLabel = GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black);
  static TextStyle selectedThemeLabel = GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black);
  static TextStyle AddTaskThemeLabel = GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black);
  static TextStyle TaskThemeLabel = GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20,color: ColorsManger.blue);

}