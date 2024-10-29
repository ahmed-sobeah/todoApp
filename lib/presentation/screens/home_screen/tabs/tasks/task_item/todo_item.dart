import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          onPressed: (context) {

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
          onPressed: (context) {

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
                    color: ColorsManger.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(width: 8,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Task Title',style: LightAppStyles.TaskThemeLabel,),

                Text('Task Description',style: LightAppStyles.selectedThemeLabel,),

              ],
            ),
            Spacer(),
            Container(padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),decoration: BoxDecoration(
              color: ColorsManger.blue,
              borderRadius: BorderRadius.circular(10),
            ),child: Icon(Icons.check,color: ColorsManger.white,))
          ],
        ),
      ),
    );
  }
}
