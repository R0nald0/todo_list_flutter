import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/defalut_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/core/widgets/todo_text_field.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/calendar_button.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/task_create_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _taskController;

   const TaskCreatePage({super.key, required TaskCreateController taskCreateController})
   :_taskController = taskCreateController ,super(); 

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    DefalutListenerNotifier(
      changeNotifier: widget._taskController
    ).listener(
      context: context, 
      succesCallBack: (notifier, listenerNotifierIntance) {
          Navigator.of(context).pop();
      } ,);

    super.initState();
  }

  @override
  void dispose() {
     _descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body:Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Criar Atividate',
                style: context.textstyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TodoTextField(
              label: '',
              controller: _descriptionEC,
              validator: Validatorless.multiple([
                Validatorless.required('campo obrigátorio')
              ]),
              ),
            const SizedBox(
              height: 20,
            ),
             CalendarButton()
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
             final isValid = _formKey.currentState?.validate() ?? false;
             if (isValid) {
               widget._taskController.save(_descriptionEC.text);
             }
          },
          label: const Text(
            'Salvar Task',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
