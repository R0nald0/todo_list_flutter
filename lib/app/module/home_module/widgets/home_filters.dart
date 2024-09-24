import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_filter_enum.dart';
import 'package:todo_list_provider/app/model/total_task_model.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTROS',
        style: context.textstyle,
        ),
        const SizedBox(height: 10,),
        
        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TodoCardFilter(
              label: 'Hoje',
              totalTaskModel: context.select<HomeController,TotalTaskModel?>((controller) => controller.todayTaskModel),
              taskFilterEnum: TaskFilterEnum.today,
              selected: context.select<HomeController,bool>((value) => value.filterSelected == TaskFilterEnum.today),
            ),
            TodoCardFilter(
              label: 'Amanhã',
              totalTaskModel: context.select<HomeController,TotalTaskModel?>((controller)=> controller.tmorrowTaskModel),
              taskFilterEnum: TaskFilterEnum.tomorrow,
              selected: context.select<HomeController,bool>((value) => value.filterSelected == TaskFilterEnum.tomorrow),
            ),
            TodoCardFilter(
              label: 'Semana',
              totalTaskModel: context.select<HomeController,TotalTaskModel?>((controller) => controller.weekTaskModel),
              taskFilterEnum: TaskFilterEnum.week,
               selected: context.select<HomeController,bool>((value) => value.filterSelected == TaskFilterEnum.week),
            ),
          ],
        )        )  
        
        
      ],
    );
  }
}