
import 'package:todo_list_provider/app/model/task_model.dart';


abstract class TaskRepository {
    Future<void> save(DateTime date ,String description);
    Future<List<TaskModel>> findTaskByPeridic(DateTime start ,DateTime end);
    Future<void> checkOrUncheck(TaskModel taskModel);   
    Future<void> delete(TaskModel taskModel);

    Future<void> deleteAll();
  
}