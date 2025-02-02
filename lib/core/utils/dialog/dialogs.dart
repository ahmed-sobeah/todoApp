import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class Dialogs{
  static void showLoading(context,{String? loadingMessage,bool isDismissible =false} ){
    showDialog(barrierDismissible: isDismissible,context: context, builder: (context) => AlertDialog(
      content: Row(
        children: [
           Text(loadingMessage ?? ''),
          Spacer(),
          CircularProgressIndicator(color: ColorsManger.blue,),
        ],
      ),
    ),);

  }
  static void hide(context){

  }
  static void showMassage(context,{String? title , String? body,String? posActionTitle}){
    showDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: title != null? Text(title):null ,
        content:body != null? Text(body):null ,
        actions: [
          if(posActionTitle != null)
          TextButton(onPressed: () {
          Navigator.pop(context);
          }, child: Text(posActionTitle))
        ],
      );
    },);
  }
}