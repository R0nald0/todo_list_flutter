import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/image/logo.png",
           height: 200,
        ),
        Text("Todo List ",style:context.textTheme.headlineMedium,)
      ],
    );
  }
}