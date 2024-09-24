
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/module/auth_module/login/login_controller.dart';
import 'package:todo_list_provider/app/module/auth_module/login/login_page.dart';
import 'package:todo_list_provider/app/module/auth_module/register/register_controller.dart';
import 'package:todo_list_provider/app/module/auth_module/register/register_page.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';

class AuthModule  extends TodoListModules{
  AuthModule() :super(
    bindings: [
      ChangeNotifierProvider(create: (context) => LoginController( userService :context.read<UserService>())),
      ChangeNotifierProvider(create: (context) => RegisterController(userService: context.read<UserService>()))
    ],
    routers: {
      '/login' : (context)=> const LoginPage(),
      '/register':(context) => const RegisterPage(),
    }
    );
   
}