
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/defult_notifier.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/ui/messasges.dart';
class DefalutListenerNotifier {
   final DefultNotifier changeNotifier;
    DefalutListenerNotifier({
        required this.changeNotifier,
       
    });

 
 void listener({ 
  required BuildContext context, 
  required SuccessCallBack succesCallBack,
  ErrorCallBack? errorCalk,
  InfoCallBack? infoCallback
  }){
    
    changeNotifier.addListener(() {

        if(infoCallback != null){
             infoCallback(changeNotifier,this);
           }

       if (changeNotifier.loading) {
           Loader.show(context);
       }else{
            Loader.hide();
       }

       if (changeNotifier.hasError) {
           if (errorCalk != null) {
              errorCalk(changeNotifier,this);       
           }

          Messasges.of(context).showError(changeNotifier.error ?? 'Erro desconhecido');
       }else if(changeNotifier.isSuccess){
            succesCallBack(changeNotifier,this);
       }

    });
 }

}
void dispose(){

}
typedef SuccessCallBack = void Function(
  DefultNotifier notifier , 
  DefalutListenerNotifier listenerNotifierIntance );

typedef ErrorCallBack = void Function(
  DefultNotifier notifier , 
  DefalutListenerNotifier listenerNotifierIntance );


typedef InfoCallBack = void Function(
  DefultNotifier notifier , 
  DefalutListenerNotifier listenerNotifierIntance );  