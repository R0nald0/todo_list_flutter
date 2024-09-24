import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModules {
  final Map<String,WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings ;

  TodoListModules({
     List<SingleChildWidget>? bindings ,
   required Map<String,WidgetBuilder> routers   
  }) : _routers = routers,_bindings = bindings;

 Map<String,WidgetBuilder> get routers{
    return _routers.map((key, pageBuilder) => 
        MapEntry(
          key, 
          (_) => TodoListPage(
              binding: _bindings,
              page: pageBuilder
             )
          ));
 } 

 Widget getPage(String path ,BuildContext context){
   final widgetBuilder = routers[path];
   if (widgetBuilder != null) {
     return TodoListPage(
       page: widgetBuilder,
       binding: _bindings,
      );
   }
   throw Exception();
 }
}