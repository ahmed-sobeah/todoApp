import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/colors_manger.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/settings_tab/widgets/language_drop_down_button.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/settings_tab/widgets/theme_drop_down_button.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedTheme= 'Light';
  String? selectedLanguage= 'English';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child:Column(
        children: [
          ThemeDropDownButton(buildDropDownTheme: buildDropDownTheme, selectedTheme: selectedTheme!),
          LanguageDropDownButton(buildDropDownLanguage: buildDropDownLanguage, selectedLanguage: selectedLanguage!)
        ],
      ),
    );
  }

  Widget buildDropDownTheme ()=>
      DropdownButton<String>(underline: Container(),items: <String> ['Light','Dark'].map((String value){
    return DropdownMenuItem<String>(value: value,child: Text(value),

    );

      }).toList(),
    onChanged: (newTheme) {
    selectedTheme = newTheme;
    setState(() {

    });
},
  );
  Widget buildDropDownLanguage ()=>
      DropdownButton<String>(underline: Container(),items: <String> ['English','العربية'].map((String value){
    return DropdownMenuItem<String>(value: value,child: Text(value),

    );

      }).toList(),
    onChanged: (newTheme) {
    selectedLanguage = newTheme;
    setState(() {

    });
},
  );
}
