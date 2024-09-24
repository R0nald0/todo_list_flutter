
import 'package:todo_list_provider/app/model/task_model.dart';
import 'package:todo_list_provider/app/model/week_task_model.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/services/task/task_servivce.dart';

class TaskServiceImpl implements TaskServivce{
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository}) : this._taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
     return _taskRepository.findTaskByPeridic(DateTime.now(),DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
     final tomorrowFilter = DateTime.now().add(const Duration(days: 1));
     return _taskRepository.findTaskByPeridic(tomorrowFilter, tomorrowFilter);
  }

  @override
  Future<WeekTaskModel> getWeek()  async{
    final today = DateTime.now();
        var startFilter = DateTime(today.year,today.month,today.day,0,0,0);
        DateTime endFilter;

        if (startFilter.weekday != DateTime.monday) {
         startFilter = startFilter.subtract(Duration(days: startFilter.weekday -1));
        }

        endFilter = startFilter.add(const Duration(days: 7));
        final tasks = await _taskRepository.findTaskByPeridic(startFilter, endFilter);
        return WeekTaskModel(
          startDate: startFilter, 
          endDate: endFilter, 
          tasks: tasks
          );
  }
  
  @override
  Future<void> checckUncheck(TaskModel task) => _taskRepository.checkOrUncheck(task);
  
  @override
  Future<void> delete(TaskModel taskModel)=> _taskRepository.delete(taskModel);
  
  @override
  Future<void> deleteAll() => _taskRepository.deleteAll();
}