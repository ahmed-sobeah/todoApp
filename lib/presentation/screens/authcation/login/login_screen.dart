import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/email_validation.dart';
import 'package:todo_app/core/utils/routes_manger.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';
import 'package:todo_app/presentation/screens/authcation/register/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> validationKey= GlobalKey();

  late TextEditingController emailController ;

  late TextEditingController passwordController ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Login',style: LightAppStyles.appbar,),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: validationKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                Text('Email Address',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                CustomTextField(validator: (input) {
                  if(input == null||input.trim().isEmpty){
                    return 'Please fill Your Email';
                  }
                  if(!isVaildEmail(input)){
                    return'Enter Valid Email';
                  }
                  return null;
                },controller: emailController,hintText: 'Enter Your Email',keyboardType: TextInputType.text,),
                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                Text('Password',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                CustomTextField(validator: (input) {
                  if(input == null||input.trim().isEmpty){
                  return 'Please enter Valid UserName';
                  }
                  return null;
                  }
                  ,controller: passwordController,hintText: 'Enter Your Password',keyboardType: TextInputType.visiblePassword,isSecureText: true,),


                SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                ElevatedButton(

                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )),
                onPressed: () {
                  login();

                }, child: Text('Login',style: GoogleFonts.roboto(fontWeight: FontWeight.w600,color: Colors.blue.shade900,fontSize: 18),))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login()async{
  if(validationKey.currentState?.validate() == false) return;
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text

    );
    UserDm.currentUser = await readUserFromFireStore(credential.user!.uid);
    Navigator.pushReplacementNamed(context, RoutesManger.homeRoute);

  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  }
 Future <UserDm> readUserFromFireStore(String userId) async{
  CollectionReference userCollection = FirebaseFirestore.instance.collection(UserDm.collectionName);
 DocumentReference userDocument = userCollection.doc(userId);
  DocumentSnapshot userDocSnapShot = await userDocument.get();
Map<String,dynamic> json = userDocSnapShot.data() as Map<String, dynamic>;
UserDm userDm= UserDm.fromFireStore(json);
return userDm;
}

}
