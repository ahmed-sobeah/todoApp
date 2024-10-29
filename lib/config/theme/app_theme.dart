import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class AppTheme{
  static ThemeData light = ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManger.blue,
      titleTextStyle: LightAppStyles.appbar,
    ),
    textTheme: TextTheme(displayLarge: LightAppStyles.TaskThemeLabel,labelMedium: LightAppStyles.themeLabel,labelSmall: LightAppStyles.selectedThemeLabel,labelLarge: LightAppStyles.AddTaskThemeLabel),
    scaffoldBackgroundColor: ColorsManger.scafold,
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManger.white,
        selectedItemColor: ColorsManger.blue,
      unselectedItemColor: ColorsManger.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme:  IconThemeData(size: 33),
      unselectedIconTheme:   IconThemeData(size: 33),

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30), side:  BorderSide(color: ColorsManger.white,width: 4)

    ),
    backgroundColor: ColorsManger.blue,
    iconSize: 22,
      foregroundColor: ColorsManger.white,
    ),
bottomAppBarTheme: const BottomAppBarTheme(
  shape: CircularNotchedRectangle(),
),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorsManger.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        )
      )
    ),
    datePickerTheme: DatePickerThemeData(
      headerForegroundColor: ColorsManger.blue,

    )
  );
  static ThemeData dark = ThemeData();
}