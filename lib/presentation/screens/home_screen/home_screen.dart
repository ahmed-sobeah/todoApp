import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manger.dart';
import 'package:todo_app/core/utils/strings_manger.dart';
import 'package:todo_app/presentation/screens/home_screen/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home_screen/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
 HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex =0;
  List<Widget> tabs=[

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs=[TasksTab(key:  tasksTabKey,),
    SettingsTab()
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsManger.appBarTitle),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: buildFab() ,
        bottomNavigationBar: buildBottomNavBar(),
        body: tabs[currentIndex],
      ),
    );
  }
  Widget buildFab () => FloatingActionButton(shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30), side:  BorderSide(color: ColorsManger.white)),
    onPressed: () async {
    await AddTaskBottomSheet.show(context);
    tasksTabKey.currentState?.getTodosFromFireStore();
  },child: Icon(Icons.add),);
  Widget buildBottomNavBar()=> BottomAppBar(
    notchMargin: 20,
    child: BottomNavigationBar(

      currentIndex:currentIndex,
      onTap: (tappedIndex) {
        currentIndex =tappedIndex;
        setState(() {

        });

      },
      items: const[

        BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: ''),
      ],),
  );
}
