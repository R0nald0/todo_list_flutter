import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFortmat = DateFormat('dd/MM/y');
  
   CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 10 * 365));
        final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: lastDate);

        context.read<TaskCreateController>().dateSelected = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.today,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Selector<TaskCreateController, DateTime?>(
                  selector: (context, controller) => controller.dateSelected,
                  builder: (_, selectedDate, __) {
                    return selectedDate != null
                        ? Text(
                            dateFortmat.format(selectedDate),
                            style: context.textstyle,
                          )
                        : Text(
                            'Selecionar Data',
                            style: context.textstyle,
                          );
                  },
                )
              ],
            ),
          )),
    );
  }
}
