
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/defalut_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messasges.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/core/widgets/todo_text_field.dart';
import 'package:todo_list_provider/app/module/auth_module/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
 final _emailEC = TextEditingController();
 final _passwordEC = TextEditingController();
 final _formKey = GlobalKey<FormState>();
 final _emailFocosNode =FocusNode();

 
 @override
  void dispose() {
     _emailEC.dispose();
     _passwordEC.dispose();
        super.dispose();
  }

   @override
  void initState() {
    DefalutListenerNotifier(changeNotifier: context.read<LoginController>())
     .listener(
        context: context, 
        succesCallBack: (notifier,listener){
            print('Logado com sucesso!!!!!!!!!!!!');
      },
      infoCallback: (notifier, listenerNotifierIntance) {
        if (notifier is LoginController) {
             if (notifier.hasInfo) {
                 Messasges.of(context).showInfo(notifier.infoMessage ?? "teste" );
             }
        }
      },      
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (_, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxHeight),
            child:  IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20,),
                  const TodoListLogo(),
                   const SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                     child: Form(
                      key: _formKey,
                      child : Column(
                      children: [
                       TodoTextField(
                        focosNode: _emailFocosNode,
                        label: "Email",
                        controller: _emailEC ,
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo Email Obrigartorio'),
                          Validatorless.email("Email Inválido")
                        ]),
                        ),
                       const SizedBox(height: 10,),
                       TodoTextField(
                          controller: _passwordEC,
                          label: "Senha",
                          obscuretext: true,
                          validator: Validatorless.multiple([
                            Validatorless.required('Senha obrigatória'),
                            Validatorless.min(6, 'Senha inválida,minimo de  6 caracteres')
                          ]),
                          
                          ),
                        const SizedBox(height: 10,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){
                               if (_emailEC.text.isNotEmpty) {
                                    
                                   context.read<LoginController>().forgotPessword(_emailEC.text);
                               }else{
                                _emailFocosNode.requestFocus();
                                Messasges.of(context).showError("Insira o email para recuperar a senha");
                               }
                            }, child:
                               const Text("Esqueceu sua senha?",
                               ),),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),

                                )
                              ),
                              onPressed: (){
                                final isValid = _formKey.currentState?.validate() ?? false;
                          
                                 if (isValid) {
                                    final email =_emailEC.text;
                                    final password = _passwordEC.text;
                                    context.read<LoginController>().login(email, password);
                                 }
                              }, 
                              child: const Text("Login",
                                style: TextStyle(color: Colors.white),
                              ),)      
                        ],)
                      ],),),
                   ),
                   const SizedBox( height : 20),
                   Expanded(child: Container(
                    decoration:  BoxDecoration(
                      color: const Color(0xffFF3F7),
                      border: Border(
                        top: BorderSide(width: 2,
                        color: Colors.grey.withAlpha(50))
                      )
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height:30),
                        SignInButton(
                          Buttons.Google,
                          text: "Continue com o Google",
                          padding: const EdgeInsets.all(5),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none
                          )
                          , onPressed:(){
                            context.read<LoginController>().signInWithGoogle();
                          },
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            const Text("Não Tem conta?"),
                            TextButton(onPressed: (){
                              Navigator.of(context).pushNamed('/register');
                            }, child: const Text("Cadastre-se"))
                          ],)
                      ],
                    ),
                   ),), 

                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
