

import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/repositories/task/task_repoitory_impl.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/services/task/task_service_impl.dart';
import 'package:todo_list_provider/app/services/task/task_servivce.dart';

import 'task_create_page.dart';

class TaskModuler extends TodoListModules {
  TaskModuler():super(
     bindings: [
      Provider<TaskRepository>(create: (context) =>TaskRepoitoryImpl(sqlLiteConnectionFactory: context.read())),
      Provider<TaskServivce>(create: (context)=> TaskServiceImpl(taskRepository: context.read())),
      ChangeNotifierProvider<TaskCreateController>(create: (context)=>TaskCreateController(taskServivce: context.read()))
     ],
     routers:{ 
       '/task/create' : (context) =>  TaskCreatePage(
                taskCreateController: context.read(),
              )
     }
    );
  
}