
import '../../model/task_model.dart';
import '../../model/week_task_model.dart';

abstract class TaskServivce {
  Future<void> save(DateTime date , String description);

    Future<List<TaskModel>> getToday();
    Future<List<TaskModel>> getTomorrow();
    Future<WeekTaskModel> getWeek();

    Future<void> checckUncheck(TaskModel task);

    Future<void> delete(TaskModel taskModel); 
    Future<void> deleteAll();
}