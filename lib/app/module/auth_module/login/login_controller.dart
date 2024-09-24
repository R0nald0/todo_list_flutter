
import 'package:todo_list_provider/app/core/exception/auth_exception.dart';
import 'package:todo_list_provider/app/core/notifier/defult_notifier.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';

class LoginController  extends DefultNotifier{
   final UserService _userService;
    String? infoMessage;

   LoginController({required UserService userService}) : _userService = userService;
     
    //String? get infoMessage => _infoMessage;
    bool get hasInfo => infoMessage != null;

   Future<void> login(String email, String password) async{
     try {
          showLoadingAndResetState();
         infoMessage =null;
         notifyListeners();
         final user = await _userService.login(email, password);
         if (user != null) {
             success();
         }else{
          
          setErro('Erro ao logar o usuario,email ou senha inválido');
         }
     } on AuthException catch  (e) {
        
        setErro(e.message);
     }
     finally{
       hideLoading();
       notifyListeners();
     }

   }

   Future<void> forgotPessword(String email) async{
      try{
        showLoadingAndResetState();
        infoMessage = null;
        notifyListeners();

        await _userService.forgotPassword(email);
        infoMessage = "verique seu e-mail para resetar a senha";
         
      }on AuthException catch(e,s){
         print(e);
         print(s);
         setErro(e.message);
      }catch(e){
          setErro( 'erro ao resetar a senha');
      }finally{
        hideLoading();
        notifyListeners();
      }
   }

   Future<void> signInWithGoogle() async {
     try {
        showLoadingAndResetState();
       //  await _userService.logout();
        infoMessage = null;
        notifyListeners();
      final user  =  await _userService.signInWithGoogle();
       if (user !=null) {
          success();
       } else {
         _userService.logout();
         setErro("erro ao logar com o google no-user");
       }
     } on AuthException catch (e) {
       _userService.logout();
       setErro(e.message);
     }finally{
      hideLoading();
      notifyListeners();
     }
   }

   Future<void> updateName(String name) async {
  
       showLoadingAndResetState();
       infoMessage = null;
       notifyListeners();
       await _userService.updateName(name);

   }
}