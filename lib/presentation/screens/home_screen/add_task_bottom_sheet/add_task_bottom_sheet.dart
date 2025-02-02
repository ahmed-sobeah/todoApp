import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/database_manger/model/todo_dm.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/tasks/tasks_tab.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key,});


  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context){
  return showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) =>Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: AddTaskBottomSheet(),
  ));
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate =DateTime.now();
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
 GlobalKey<FormState> formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Container(
        height: MediaQuery.of(context).size.height *0.4,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add New Task',textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (input) {
                    if(input == null || input.trim().isEmpty){
                      return 'Please enter Task Title';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Task Title',
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                    validator: (input) {
                    if(input == null || input.trim().isEmpty){
                    return 'Please enter Task description';
                    }
                    return null;
                    },
                   controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Task Discrption',
                  ),
                             ),
               ),
               Text('Select Date',textAlign: TextAlign.start,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 20),),
              InkWell(onTap: () {
                showTaskDate(context);
              },child: Text(selectedDate.toFormattedDate,textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 20),)),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  addTaskToFireStore();
                }, child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add Task'),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showTaskDate(context)async{
    selectedDate = await
    showDatePicker(


        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
    ) ?? selectedDate;
    setState(() {

    });
  }
  void addTaskToFireStore(){
    if(formKey.currentState!.validate() == false) return;
    CollectionReference usersCollection =  FirebaseFirestore.instance.collection(UserDm.collectionName);
    CollectionReference todoCollection = usersCollection.doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
   DocumentReference documentReference = todoCollection.doc();
    TodoDm todo =TodoDm(title:titleController.text , id:documentReference.id, dateTime: selectedDate, description: descriptionController.text, isDone: false);
   documentReference.set(todo.toFireStore()).then((value) {
     if(context.mounted){
       Navigator.pop(context);
     }
   },).onError((error, stackTrace) {

   },).timeout(Duration(seconds:  4),
     onTimeout: () {


   },);
  }
}
