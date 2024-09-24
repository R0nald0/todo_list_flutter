

import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';
import 'package:todo_list_provider/app/module/home_module/home_page.dart';
import 'package:todo_list_provider/app/repositories/task/task_repoitory_impl.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/services/task/task_service_impl.dart';
import 'package:todo_list_provider/app/services/task/task_servivce.dart';

class HomeModule  extends TodoListModules{
  HomeModule():super(
    routers: {
       '/home' : (context) => HomePage(homeController: context.read(),),
    },
    bindings: [
       Provider<TaskRepository>(create: (context)=>TaskRepoitoryImpl(sqlLiteConnectionFactory:context.read() )) ,
       Provider<TaskServivce>(create: (context)=> TaskServiceImpl(taskRepository: context.read())),
       ChangeNotifierProvider(create: (context)=>HomeController(taskServivce: context.read()))
    ] 
    );
  
}