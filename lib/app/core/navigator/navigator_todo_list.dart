
import 'package:flutter/material.dart';

class NavigatorTodoList  {
  NavigatorTodoList._();

static  final navigatorTodoListGlobalKey = GlobalKey<NavigatorState>();
static NavigatorState get to => navigatorTodoListGlobalKey.currentState!;
}