import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_model.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 20,),
         Selector<HomeController,String>(
          selector:(context,controller) => controller.filterSelected.description,
          builder: (_,value,__){
            return Text('TASKS $value',
              style: context.textstyle,
            );
          }, 
          ),  
           Column(
            children: context.select<HomeController,List<TaskModel>>(
                (controller) => controller.filteredTasks
              ).map((t) => Task(taskModel: t,)).toList(),
          )
        ],
      ),
    );
  }
}