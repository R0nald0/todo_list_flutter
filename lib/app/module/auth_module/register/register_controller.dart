

import 'package:todo_list_provider/app/core/exception/auth_exception.dart';
import 'package:todo_list_provider/app/core/notifier/defult_notifier.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';
class RegisterController extends DefultNotifier {
    final UserService _userService;
    
  RegisterController({required UserService userService}) : _userService = userService;
  
  Future<void> register(String email, String password) async{
     try {
         showLoadingAndResetState();
        notifyListeners();
        final user =  await _userService.register(email, password);
        if (user != null) {
             success();
        }else{
             setErro('Erro ao registrar usuario');
        }
       
     } on AuthException catch (e) {
       setErro( e.message);
       
     }finally{
      hideLoading();
      notifyListeners();
     }
  
  }         
}