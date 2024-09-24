
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(TextEditingController? valuEC,String menssage){
    return (value){
      final valueToCompare = valuEC?.text?? '';
      if(value == null || (value != null  &&  value != valueToCompare)){
           return menssage;
      }
      return null;
     
    };
  }
}