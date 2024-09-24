
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list_provider/app/core/database/sql_lite_connection_factory.dart';
import 'package:todo_list_provider/app/repositories/user_repository.dart';
import 'package:todo_list_provider/app/repositories/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';
import 'package:todo_list_provider/app/services/userService/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
      
      return MultiProvider(
        providers: [
           Provider(create: (_)=> FirebaseAuth.instance) ,
           Provider(create: (_) => SqlLiteConnectionFactory(),
            lazy: false,
           ),
           Provider<UserRepository>(create: (context) => UserRepositoryImpl(firebaseAuth: context.read())),
           Provider<UserService>(create: (context) => UserServiceImpl(userRepository: context.read())),
           ChangeNotifierProvider(create: (context) => TodoListAuthProvider(
                userService: context.read(), 
                firebaseAuth:context.read()
                              )..loadListeners(),
                              lazy: false,
            )
        
        ],child: const AppWidget());
        
  }
}