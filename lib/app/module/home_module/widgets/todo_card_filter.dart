
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_filter_enum.dart';
import 'package:todo_list_provider/app/model/total_task_model.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TotalTaskModel? totalTaskModel;
  final TaskFilterEnum taskFilterEnum;
  final bool selected;

  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.selected,
    required this.taskFilterEnum,
    required this.totalTaskModel
      }):super(key: key );

   double getPercentFinish(){
     final totalTask = totalTaskModel?.totalTask ?? 0.0;
     final totalCompletedTask = totalTaskModel?.totalTaskFinish ?? 0.1;
      
       if (totalTask == 0.0) {
        return 0.0;
     }
     

     final percent = (totalCompletedTask * 100) /totalTask; 
     return percent / 100;
    
   }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => context.read<HomeController>().findTasks(filter: taskFilterEnum),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150
        ),
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor :Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.8)
          ),
          borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${totalTaskModel?.totalTask ?? 0} TASK',
             style:context.textstyle.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.grey 
             ) ,
            ), 
               const SizedBox(height: 20,),
             Text(label,
             style:  TextStyle(
                 color: selected ? Colors.white : Colors.black,
                 fontSize: 20,
                 fontWeight: FontWeight.bold
             ),
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0,end:getPercentFinish()), 
              duration: const Duration(seconds: 1), 
              builder: (_,value,__){
                return LinearProgressIndicator(
              value: value,
             valueColor:  AlwaysStoppedAnimation<Color>(
                 selected ?  Colors.white : context.primaryColor),
              backgroundColor: selected ?context.primaryColorLight : Colors.grey.shade300,
            );
              }
              )
            
          ],
        ),
      ),
    );
  }
}