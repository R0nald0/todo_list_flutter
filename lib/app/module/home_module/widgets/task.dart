import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_model.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat("dd/MM/y");

   Task({Key? key ,required this.taskModel}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow:const [ BoxShadow(
          color: Colors.grey
        )]
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child:ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: Checkbox(
            value: taskModel.finished == 1,
            onChanged: (value){
               context.read<HomeController>().checkUnchek(taskModel);
            },
          ),
          title:  Text(
              taskModel.description,
             style:  TextStyle(
              decoration: taskModel.finished == 1? TextDecoration.lineThrough : null
             ),
            ),
            subtitle:  Text(
              dateFormat.format(taskModel.dataTime),
            style:  TextStyle(
              decoration: taskModel.finished == 1? TextDecoration.lineThrough : null,
            ),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 2)
            ),
            trailing: IconButton(
              onPressed:() => context.read<HomeController>().delete(taskModel),
              icon:FaIcon(
                FontAwesomeIcons.trash,
                size: MediaQuery.of(context).size.height * 0.03,
                color: context.primaryColor,
                ),
            ),
            
        ) 
        ,),
    );
  }
}