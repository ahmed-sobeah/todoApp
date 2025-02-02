import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/dialog/dialogs.dart';
import 'package:todo_app/core/utils/email_validation.dart';
import 'package:todo_app/core/utils/routes_manger.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';
import 'package:todo_app/presentation/screens/authcation/register/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> validationKey= GlobalKey();
  late TextEditingController fullNameController ;

  late TextEditingController userNameController ;

  late TextEditingController emailController ;

  late TextEditingController passwordController ;
  late TextEditingController rePasswordController ;
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Register',style: LightAppStyles.appbar,),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: validationKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Full Name',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                  CustomTextField(
                    validator: (input) {
                      if(input == null||input.trim().isEmpty){
                        return 'Please enter Valid Name';
                      }
                      return null;
                    },
                    controller: fullNameController,hintText: 'Enter Your Full Name',keyboardType: TextInputType.text,),
                  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                  Text('User Name',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                  CustomTextField(validator: (input) {
                    if(input == null||input.trim().isEmpty){
                      return 'Please enter Valid UserName';
                    }
                    return null;
                  },controller: userNameController,hintText: 'Enter Your UserName',keyboardType: TextInputType.text,),
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
                  Text('Re-Password',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                  CustomTextField(validator: (input) {
                    if(input == null||input.trim().isEmpty){
                      return 'Please enter Valid UserName';
                    }
                    if(input != passwordController.text){
                      return'Password Does not Match';
                    }
                    return null;
                  }
                      ,controller: rePasswordController,hintText: 'Re-Enter Your Password',keyboardType: TextInputType.visiblePassword,isSecureText: true,),
                  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
                  ElevatedButton(
              
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )),
                  onPressed: () {
                    register();
              
                  }, child: Text('Sign Up',style: GoogleFonts.roboto(fontWeight: FontWeight.w600,color: Colors.blue.shade900,fontSize: 18),)),
                  ElevatedButton(

                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context,RoutesManger.loginRoute);

                  }, child: Text('Already have an account?',style: GoogleFonts.roboto(fontWeight: FontWeight.w600,color: Colors.blue.shade900,fontSize: 18),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void register()async{
  if(validationKey.currentState?.validate() == false) return;
  try{
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
  addUserToFireStore(credential.user!.uid);

  }
  on FirebaseAuthException catch (authError) {

    if (authError.code == 'weak-password') {
    Dialogs.showMassage(context,title: 'weak Password',posActionTitle: 'ok');
    } else if (authError.code == 'email-already-in-use') {
      Dialogs.showMassage(context,title: 'Email already in use',posActionTitle: 'ok');
    }
    } catch (e) {
    print(e);
    }
  Navigator.pushReplacementNamed(context, RoutesManger.loginRoute);
  }
  void addUserToFireStore(String userid) async{
    UserDm userDm = UserDm(email: emailController.text, fullName: fullNameController.text, userName: userNameController.text, id: userid);
    CollectionReference userCollection = FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference documentReference = userCollection.doc(userid);
    await documentReference.set(userDm.toFireStore());
  }
}
