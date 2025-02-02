

import 'package:flutter/material.dart';
import 'package:todo_app/database_manger/model/todo_dm.dart';
import 'package:todo_app/presentation/screens/authcation/login/login_screen.dart';
import 'package:todo_app/presentation/screens/authcation/register/register_screen.dart';
import 'package:todo_app/presentation/screens/home_screen/home_screen.dart';

class RoutesManger{
  static const String homeRoute ='/home';
  static const String splashRoute ='/home';
  static const String registerRoute ='/register';
  static const String loginRoute ='/login';
  static const String editRoute ='/edit';
  static Route? router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen(),);
      case registerRoute:
        return MaterialPageRoute(builder: (context) => RegisterScreen(),);
      case loginRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen(),);
    }
  }
}