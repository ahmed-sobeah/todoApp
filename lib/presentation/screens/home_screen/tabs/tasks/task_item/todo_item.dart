import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manger.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/core/utils/routes_manger.dart';
import 'package:todo_app/database_manger/model/todo_dm.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home_screen/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home_screen/update_task_bottomSheet/update_task.dart';


class TodoItem extends StatefulWidget {
   TodoItem({super.key,required this.todo,required this.onDeletedTask});
  TodoDm todo;
  Function onDeletedTask;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool finished= false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          onPressed: (context)  {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTask(todo: widget.todo)));

          },
          backgroundColor: ColorsManger.blue,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),

      ]),
      startActionPane:ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          flex: 2,
          onPressed: (context)  {

          deleteTodoFromFireStore(widget.todo);
          widget.onDeletedTask();

          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),

      ]) ,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsManger.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                height: 62,
                width: 4,
                decoration: BoxDecoration(
                    color: widget.todo.isDone? ColorsManger.green: ColorsManger.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(width: 8,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.todo.title,style: widget.todo.isDone? LightAppStyles.doneLabel : LightAppStyles.taskThemeLabel,),

                Text(widget.todo.description,style: LightAppStyles.selectedThemeLabel,),

              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                isDone(widget.todo);

              },
              child: Container(padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),decoration: BoxDecoration(
                color: widget.todo.isDone? Colors.transparent : ColorsManger.blue,
                borderRadius: BorderRadius.circular(10),
              ),child: Icon(Icons.check,color: widget.todo.isDone? ColorsManger.green : ColorsManger.white),),
            )
          ],
        ),
      ),
    );
  }

toUpdate(){
  MaterialPageRoute(builder: (context) => UpdateTask(todo: widget.todo),)  ;
}


  void deleteTodoFromFireStore(TodoDm todo) async{
   CollectionReference todoReference = FirebaseFirestore.instance.collection(UserDm.collectionName).doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
   DocumentReference todoDoc = todoReference.doc(todo.id);
   await todoDoc.delete();


  }
    Future<void> isDone(TodoDm todo1) {
      CollectionReference usersCollection =  FirebaseFirestore.instance.collection(UserDm.collectionName);
      CollectionReference todoCollection = usersCollection.doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
      DocumentReference documentReference = todoCollection.doc(todo1.id);
      print(documentReference.id);
      return todoCollection
          .doc(documentReference.id)
          .update({'IsDone': true})
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



