

import 'package:todo_list_provider/app/core/notifier/defult_notifier.dart';
import 'package:todo_list_provider/app/services/task/task_servivce.dart';

class TaskCreateController extends DefultNotifier {
   final TaskServivce _taskServivce;
  DateTime? _dateSelected;
   
   TaskCreateController({required TaskServivce taskServivce}) :_taskServivce =taskServivce;

  set dateSelected(DateTime? date){
      resetState();
     _dateSelected =date;
     notifyListeners();
  }

 DateTime? get dateSelected => _dateSelected;

 Future<void> save( String description) async{
    try {
       showLoadingAndResetState();
       notifyListeners();
       if(dateSelected !=null){
         await _taskServivce.save(dateSelected!, description);
         success();
       }else{
         setErro('Data da task não selecionada');
       }
    } catch (e,s) {
       print(e);
       print(s);
       setErro('Error ao cadastrar task');
    }
    finally{
      hideLoading();
      notifyListeners();
    }
 }
}