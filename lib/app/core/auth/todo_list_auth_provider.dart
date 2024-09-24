
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_provider/app/core/navigator/navigator_todo_list.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';

class TodoListAuthProvider  extends ChangeNotifier{
    final UserService _userService;   
    final FirebaseAuth  _firebaseAuth;
   
   TodoListAuthProvider({required UserService userService , required FirebaseAuth firebaseAuth}) 
   :  _userService = userService ,
      _firebaseAuth = firebaseAuth;


  Future<void> logout() async {
    _userService.logout();
  }   
  User? get user => _firebaseAuth.currentUser;

  void loadListeners(){
     _firebaseAuth.userChanges().listen((_) {
               notifyListeners();
      });

      _firebaseAuth.authStateChanges().listen((user) {
          if (user !=null) {
             NavigatorTodoList.to.pushNamedAndRemoveUntil('/home', (route) => false);
          } else {
            NavigatorTodoList.to.pushNamedAndRemoveUntil('/login', (route) => false);
          }
      });
  }

}