import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(context){
  showModalBottomSheet(context: context, builder: (context) =>AddTaskBottomSheet());
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate =DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Container(
        height: MediaQuery.of(context).size.height *0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add New Task',textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelLarge,),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Your Task Title',
              ),
            ),
             TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Your Task Discrption',
              ),
            ),
             Text('Select Date',textAlign: TextAlign.start,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 20),),
            InkWell(onTap: () {
              showTaskDate(context);
            },child: Text(selectedDate.toFormattedDate,textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 20),)),
            const Spacer(),
            ElevatedButton(onPressed: () {

            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add Task'),
            ))
          ],
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
}
