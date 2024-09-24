import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_filter_enum.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: context.select<HomeController,bool>((value) => value.filterSelected == TaskFilterEnum.week ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const SizedBox(height: 20,),
        Text("DIA DA SEMANA",style: context.textstyle,),
        const SizedBox(height: 10,),
        SizedBox(
          height: 95,
          child:Selector<HomeController,DateTime>(
            selector: (context, controller) => controller.initalWeekDate ?? DateTime.now() ,
            builder: (context, value, child) {
               return DatePicker(
            value,
            locale: 'pt_BR',
            initialSelectedDate:value,
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle:const TextStyle(fontSize: 8) ,
            dayTextStyle: const TextStyle(fontSize: 13),
             dateTextStyle:const TextStyle(fontSize: 13) ,
            onDateChange: (date){
              context.read<HomeController>().filterByDay(date);
            },
          );
            },
          ) ,
        )
        ],
      ),
    );
  }
}