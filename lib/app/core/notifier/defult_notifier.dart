
import 'package:flutter/material.dart';

class DefultNotifier extends ChangeNotifier {
    
    bool _loading = false;
    String? _erro;
    bool _success =false;

  
  bool get loading =>_loading;
  String? get error => _erro;
  bool get isSuccess=> _success;
  bool get hasError => error != null;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  
  void success() => _success = true;

  void setErro(String? error)=> _erro = error;

   void showLoadingAndResetState(){
     showLoading();
     resetState();
   }
  void  resetState(){
     setErro(null);
     _success = false;
  }
}