import 'package:flutter/foundation.dart';
import 'package:todo_list_provider/app/core/notifier/defult_notifier.dart';
import 'package:todo_list_provider/app/model/task_filter_enum.dart';
import 'package:todo_list_provider/app/model/task_model.dart';
import 'package:todo_list_provider/app/model/total_task_model.dart';
import 'package:todo_list_provider/app/model/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/task_servivce.dart';

class HomeController extends DefultNotifier {
  final TaskServivce _taskService;
  TotalTaskModel? todayTaskModel;
  TotalTaskModel? tmorrowTaskModel;
  TotalTaskModel? weekTaskModel;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initalWeekDate;
  DateTime? selectedDay;
  bool showFinishedTask = false;

  HomeController({required TaskServivce taskServivce})
      : _taskService = taskServivce;

  var filterSelected = TaskFilterEnum.today;

  Future<void> loadTotalTask() async {
    try {
      final allTasks = await Future.wait([
        _taskService.getToday(),
        _taskService.getTomorrow(),
        _taskService.getWeek()
      ]);

      final todatTasksModel = allTasks[0] as List<TaskModel>;
      final tommorowTasksModel = allTasks[1] as List<TaskModel>;
      final weekTasskModel = allTasks[2] as WeekTaskModel;

      todayTaskModel = TotalTaskModel(
          totalTask: todatTasksModel.length,
          totalTaskFinish:
              todatTasksModel.where((element) => element.finished == 1).length);

      tmorrowTaskModel = TotalTaskModel(
          totalTask: tommorowTasksModel.length,
          totalTaskFinish: tommorowTasksModel
              .where((element) => element.finished == 1)
              .length);

      weekTaskModel = TotalTaskModel(
          totalTask: weekTasskModel.tasks.length,
          totalTaskFinish: weekTasskModel.tasks
              .where((element) => element.finished == 1)
              .length);
    } on Exception catch (e) {
      print(e);
      setErro("erro ao buscar tasks");
    } finally {
      notifyListeners();
    }
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    try {
      filterSelected = filter;
      showLoading();
      notifyListeners();
      List<TaskModel> tasks;

      switch (filter) {
        case TaskFilterEnum.today:
          {
            tasks = await _taskService.getToday();
            break;
          }
        case TaskFilterEnum.tomorrow:
          {
            tasks = await _taskService.getTomorrow();
            break;
          }
        case TaskFilterEnum.week:
          {
            final week = await _taskService.getWeek();
            initalWeekDate = week.startDate;
            tasks = week.tasks;
            break;
          }
      }

      allTasks = tasks;
      filteredTasks = tasks;

      if (filter == TaskFilterEnum.week) {
        if (selectedDay != null) {
          filterByDay(selectedDay!);
        } else if (initalWeekDate != null) {
          filterByDay(initalWeekDate!);
        }
      } else {
        selectedDay = null;
      }

      if (!showFinishedTask) {
        filteredTasks =
            filteredTasks.where((element) => element.finished == 0).toList();
      }
    } catch (e) {
      setErro('$e');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) => task.dataTime == date).toList();
    notifyListeners();
  }

  void refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTask();

    notifyListeners();
  }

  Future<void> checkUnchek(TaskModel task) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final upadatedTask = task.copyWith(finished: task.finished == 1 ? 0 : 1);

      _taskService.checckUncheck(upadatedTask);
    } on Exception catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      setErro('Erro ao atualizar Task');
    } finally {
      hideLoading();
      refreshPage();
    }
  }

  Future<void> showHideFinalizedTask() async {
    showFinishedTask = !showFinishedTask;
    refreshPage();
  }

  Future<void> delete(TaskModel taskModel) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      await _taskService.delete(taskModel);
      refreshPage();
    } catch (e) {
      setErro('erro ao deletar task');
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteAll() async {
    await _taskService.deleteAll();
  }
}
