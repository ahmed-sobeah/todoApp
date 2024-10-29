import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class ThemeDropDownButton extends StatelessWidget {
 ThemeDropDownButton({super.key,required this.buildDropDownTheme,required this.selectedTheme});
  String selectedTheme;
  Function buildDropDownTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [

        Text('Theme',style: Theme.of(context).textTheme.labelMedium,),
        SizedBox(height: 10,),
        Container(
          height: 42,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              border:  Border.all(width: 1,color: ColorsManger.blue)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedTheme,style: Theme.of(context).textTheme.labelSmall,),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: buildDropDownTheme(),
              )
            ],
          ),
        )
      ],),
    );
  }
}
