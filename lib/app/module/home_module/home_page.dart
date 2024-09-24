

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list_provider/app/core/notifier/defalut_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messasges.dart';
import 'package:todo_list_provider/app/core/ui/theme.extension.dart';
import 'package:todo_list_provider/app/model/task_filter_enum.dart';
import 'package:todo_list_provider/app/module/auth_module/tasks/task_moduler.dart';
import 'package:todo_list_provider/app/module/home_module/home_controller.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/home_filters.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/home_header.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/module/home_module/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/services/userService/user_service.dart';

class HomePage extends StatefulWidget {
  
  final HomeController _homeController;
   HomePage({ required HomeController homeController}):_homeController = homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final valueVN = ValueNotifier<String>('');
 
 void _goToCreatePage(BuildContext context) async{
      await  Navigator.of(context).push(
         PageRouteBuilder(
          transitionDuration:const Duration(milliseconds: 400),
          
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
             animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
             return ScaleTransition(
              scale: animation,
              alignment: Alignment.bottomRight,
              child: child,
              );
          },
          pageBuilder:(context, animation, secondaryAnimation){
             return TaskModuler().getPage('/task/create',context);
          },)
        );
     
     widget._homeController.refreshPage();
  } 
   
   @override
  void initState() {
    
    super.initState();
    DefalutListenerNotifier(changeNotifier: widget._homeController).listener(
      context: context, 
      succesCallBack: (notifier, listenerNotifierIntance) {
        
      },);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
        widget._homeController.loadTotalTask();
        widget._homeController.findTasks(filter: TaskFilterEnum.today);
      });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [
         PopupMenuButton(
          onSelected: (value){
             widget._homeController.showHideFinalizedTask();
          },
          icon:  const FaIcon(FontAwesomeIcons.filter),
          itemBuilder: (_)=>[
              PopupMenuItem(
              value:true ,
              
              child: Text("${widget. _homeController.showFinishedTask ?'Esconder':'Mostrar'} Tarefas concluidas"),)
         ])
      ],),
      drawer: Drawer(
        child:ListView(
          children: [
            DrawerHeader(
               decoration: BoxDecoration(
                color: context.primaryColor.withAlpha(70)
               ),
               child: Row(children: [
                 Selector<TodoListAuthProvider,String>(selector: (context,authProvider){
                   return authProvider.user?.photoURL ?? 'Não informado';
                 },builder: (_,value,__){
                   return   CircleAvatar(
                      backgroundImage: NetworkImage(value) ,
                      radius: 30,
                      );
                 }),
                 Selector<TodoListAuthProvider,String>(selector: (context,authProvider){
                   return authProvider.user?.displayName ?? 'Não informado' ;
                 },builder: (_,value,__){
                   return   Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                       style: context.textTheme.bodyMedium,
                      ),
                    )
      
                    );
                 }),
               ],),
              ),
              ListTile(
                onTap: (){
                   showDialog(
                    context: context, 
                   builder: (_){
                    return AlertDialog(
                      title:const Text('Deseja alterar o nome'),
                      content: TextField(
                        
                        onChanged: (value){
                           valueVN.value = value;
                        },
                      ),
                      actions:  [
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child:const Text("Cancelar",style: TextStyle(color:Colors.red),)),
                        TextButton(onPressed: (){
                              final nameValue = valueVN.value;
                             if(nameValue.isEmpty || nameValue.length < 4){
                               Messasges.of(context).showError('Nome precisa ter pelo menos 4 caracteres');
                             }else{
                               context.read<UserService>().updateName(nameValue);
                             }
                        }, child:const Text("Atualizar")),
                      ],
                    );
                   }
                   );
                },
                title: const Text('Alterar Nome'),
              ),
              ListTile(
                onTap: (){
                  context.read<TodoListAuthProvider>().logout();
                  context.read<HomeController>().deleteAll();
                },
                textColor: Colors.red,
                title: const Text('Sair'),
              )
          ],
        ),
      ),
      
      body: LayoutBuilder(
        builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth
                ) ,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        HomeFilters(),
                        HomeWeekFilter(),
                        HomeTasks()
                      ],
                    ),
                    ),
                ),
                ),
            );
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _goToCreatePage(context);
        },
        backgroundColor: context.primaryColor,
        child: FaIcon(FontAwesomeIcons.plus,color: context.primaryColorLight,),
        ),
    );
  }
}