import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sql_lite_admin_connection.dart';
import 'package:todo_list_provider/app/core/navigator/navigator_todo_list.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/module/auth_module/auth_module.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/task_moduler.dart';
import 'package:todo_list_provider/app/module/home_module/home_module.dart';
import 'package:todo_list_provider/app/module/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
   final sqlAdmin = SqlLiteAdminConnection();

   @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqlAdmin);
    super.initState();
  }

  @override
  void dispose() {
     WidgetsBinding.instance.removeObserver(sqlAdmin);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return  MaterialApp(
       debugShowCheckedModeBanner: false,
       title: "To do List Provider",
       navigatorKey: NavigatorTodoList.navigatorTodoListGlobalKey,
       theme: TodoListUiConfig.theme,
      
       
       routes: {
         ...AuthModule().routers,
         ...HomeModule().routers,
         ...TaskModuler().routers
       },
      home: const SplashPage(),
    );
  }
}