import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manger.dart';

class LanguageDropDownButton extends StatelessWidget {
  LanguageDropDownButton({super.key,required this.buildDropDownLanguage,required this.selectedLanguage});
  String selectedLanguage;
  Function buildDropDownLanguage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [

        Text('Language',style: Theme.of(context).textTheme.labelMedium,),
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
              Text(selectedLanguage,style: Theme.of(context).textTheme.labelSmall,),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: buildDropDownLanguage(),
              )
            ],
          ),
        )
      ],),
    ); ;
  }
}
