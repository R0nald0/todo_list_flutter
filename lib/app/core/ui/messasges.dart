
import 'package:flutter/material.dart';
class Messasges {
   final BuildContext context;

   Messasges._(this.context);

   factory Messasges.of(BuildContext context){
     return Messasges._(context);
   }


   void showError(String message) => showMessage(message,Colors.red);
   void showInfo(String message) => showMessage(message,Colors.green);
   
   
showMessage(String message, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message ),
        backgroundColor:color,)
        );
}
}
