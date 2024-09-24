
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sql_lite_connection_factory.dart';

class SqlLiteAdminConnection  with WidgetsBindingObserver{
   final sqlConnection = SqlLiteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      switch (state) {

         
        case AppLifecycleState.resumed:
          break;
        case AppLifecycleState.inactive:
        case AppLifecycleState.hidden:
        case AppLifecycleState.paused:
        case AppLifecycleState.detached:
         sqlConnection.closeConnection();
         break;
      }
  }

 
  
}