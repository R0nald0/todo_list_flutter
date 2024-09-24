import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 
  veruficaAuth(){
     Future.delayed(const Duration(seconds: 12));
     Navigator.of(context).pushNamed('/login');
  }


   @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
    //    veruficaAuth();
    // });
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body:Center(
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TodoListLogo(),
              SizedBox(height: 30,),
              CircularProgressIndicator(),
              SizedBox(height: 15,),
              Text("Loading",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,letterSpacing: 3))
            ],
          ),
        ),
       ),
    );
  }
}