import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/routes_manger.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: RoutesManger.router,
      initialRoute: RoutesManger.registerRoute,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

    );
  }
}