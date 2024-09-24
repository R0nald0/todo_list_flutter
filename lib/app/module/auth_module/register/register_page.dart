import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/defalut_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/core/widgets/todo_text_field.dart';
import 'package:todo_list_provider/app/module/auth_module/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';
class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _passwordConfirmEC =TextEditingController();
  @override
  void dispose() {
      _emailEC.dispose();
      _passwordConfirmEC.dispose();
      _passwordEC.dispose();
      super.dispose();
  }

  @override
  void initState() {
     final defaultListener =DefalutListenerNotifier(changeNotifier: context.read<RegisterController>());

     defaultListener.listener(
      context: context,
       succesCallBack: (notifier, listenerNotifierIntance) {
        //  Navigator.of(context).pop();
       },
      );
  
  //  context.read<RegisterController>().addListener(() {
  //        final controller =context.read<RegisterController>();
  //        if (controller.sucesso) {
  //      Navigator.of(context).pop();
  //   }else if(controller.erro != null){
      
  //   }
  //   });
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape:  Border(bottom: BorderSide(color: Colors.black.withAlpha(100))),
        title: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children :[
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10,color: context.primaryColor),
            ),
             Text(
              'Cadastro',
              style: TextStyle(fontSize: 15,color: context.primaryColor),
            )
          ]
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
  
        leading: IconButton(
          onPressed: ()=> Navigator.of(context).pop(),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            )
            ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width *.5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
           Padding(padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
            child: Form(
              key:formKey,
              child: Column(children: [
                TodoTextField(
                     label: 'Email',
                    controller:_emailEC ,
                    validator: Validatorless.multiple([
                      Validatorless.required("campo email é requerido"),
                      Validatorless.email('E-mail inválido')
                    ]),
                    ),
                const SizedBox(height: 20),
                TodoTextField(
                  label: 'Senha',
                  obscuretext: true, 
                  controller: _passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo Senha é obrigatorio'),
                    Validatorless.min(6, 'Senha precisa conter no minimo 6 caracteres')
                  ]),
                  ),
                const SizedBox(height: 20),
                TodoTextField(
                  label: 'Confirmar Senha',
                  obscuretext: true, 
                  controller:  _passwordConfirmEC,
                   validator: Validatorless.multiple([
                    Validatorless.required('confirmação de senha obrigatorio'),
                    Validators.compare(_passwordEC, 'As senhas não são compatíveis')
                   ]),
                ),
                const SizedBox(height: 10,),
                 Align(
                  alignment: Alignment.bottomRight,
                   child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                   
                                  )
                                ),
                                onPressed: (){
                                   final isValid = formKey.currentState?.validate() ?? false;
                                   if (isValid) {
                                       final email =_emailEC.text;
                                       final password = _passwordEC.text;
                                       context.read<RegisterController>().register(email, password);
                                   }
                                }, 
                                child: const Text("Salvar",
                                  style: TextStyle(
                                     color: Colors.white
                                  ),
                                ),
                                ),
                 ) 
              ]
              ,)
              ),
          )
        ],
      ),
    );
  }
}