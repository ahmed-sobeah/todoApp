import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/core/utils/routes_manger.dart';
import 'package:todo_app/database_manger/model/todo_dm.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';

class UpdateTask extends StatefulWidget {
  UpdateTask({super.key,required this.todo});
  TodoDm todo;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  DateTime selectedDate =DateTime.now();

  TextEditingController titleController =TextEditingController();

  TextEditingController descriptionController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Update Your Task',textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelLarge,),
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
                updateUser(widget.todo);
              }, child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Edit Task'),
              )),
            )
          ],
        ),
      ),
    );
  }

  void showTaskDate(context)async{
    selectedDate = await
    showDatePicker(


      context: context,
      firstDate: widget.todo.dateTime,
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ) ?? selectedDate;
    setState(() {

    });
    print(selectedDate);
  }
  // void addTaskToFireStore(TodoDm todo1) async{
  //   CollectionReference usersCollection =  FirebaseFirestore.instance.collection(UserDm.collectionName);
  //   CollectionReference todoCollection = usersCollection.doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
  //   DocumentReference documentReference = todoCollection.doc(todo1.id);
  //   TodoDm todo =TodoDm(title:titleController.text , id:documentReference.id, dateTime: selectedDate, description: descriptionController.text, isDone: false);
  //
  //   print(todo.id);
  //   await documentReference.collection(TodoDm.collectionName).doc(todo.id).update(todo.toFireStore(),).then((value) {
  //     if(context.mounted){
  //       Navigator.pushReplacementNamed(context, RoutesManger.homeRoute);
  //     }
  //   },).onError((error, stackTrace) {
  //
  //   },).timeout(Duration(seconds:  4),
  //     onTimeout: () {
  //
  //
  //     },);
  // }

  Future<void> updateUser(TodoDm todo1) {
    CollectionReference usersCollection =  FirebaseFirestore.instance.collection(UserDm.collectionName);
    CollectionReference todoCollection = usersCollection.doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
    DocumentReference documentReference = todoCollection.doc(todo1.id);
    print(documentReference.id);
    return todoCollection
        .doc(documentReference.id)
        .update({'title': titleController.text,
                  'description':descriptionController.text,
                  'dateTime':selectedDate,
                  'IsDone': false})
        .then((value) {
      if(context.mounted){
               Navigator.pushReplacementNamed(context, RoutesManger.homeRoute);
             }
          },
        )
        .catchError((error) => print("Failed to update user: $error"))
    .timeout(Duration(seconds: 4));
  }

}
