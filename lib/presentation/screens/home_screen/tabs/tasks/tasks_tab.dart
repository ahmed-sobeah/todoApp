import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manger.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/database_manger/model/todo_dm.dart';
import 'package:todo_app/database_manger/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/tasks/task_item/todo_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});
  DateTime selectedDate = DateTime.now();


  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();
  List<TodoDm> todosList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          buildCalender(),
          Expanded(child: ListView.builder(itemBuilder: (context, index) => TodoItem(onDeletedTask: (){
            getTodosFromFireStore();
          },todo: todosList[index]) ,itemCount: todosList.length,))
        ],
      ),
    );
  }

  Widget buildCalender(){
     return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      focusDate: selectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
        itemBuilder: (context, date, isSelected, onTap) {
          return InkWell(onTap:
            () {
              selectedDate = date;
              getTodosFromFireStore();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2,color: isSelected? ColorsManger.blue: ColorsManger.scafold)
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Center(child: Text('${date.getDayName(date)}',style: isSelected ? LightAppStyles.taskThemeLabel: LightAppStyles.selectedThemeLabel ,)),
                      Text('${date.day}',style: isSelected ? LightAppStyles.taskThemeLabel: LightAppStyles.selectedThemeLabel ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
  getTodosFromFireStore() async{
    CollectionReference todoCollection = FirebaseFirestore.instance.collection(UserDm.collectionName).doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documentsSnapShot = querySnapshot.docs;
    todosList = documentsSnapShot.map((docSnapShot) {
   Map<String,dynamic> json = docSnapShot.data() as Map<String,dynamic>  ;
   TodoDm todo =TodoDm.fromFireStore(json);
   return todo;
  } ,).toList();
   todosList= todosList.where((todo) => todo.dateTime.month == selectedDate.month && todo.dateTime.day == selectedDate.day && todo.dateTime.year == selectedDate.year ,).toList();
   setState(() {

   });
  }
}

