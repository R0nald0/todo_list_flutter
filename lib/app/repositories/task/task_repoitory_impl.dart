
import 'package:flutter/foundation.dart';
import 'package:todo_list_provider/app/core/database/sql_lite_connection_factory.dart';
import 'package:todo_list_provider/app/model/task_model.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';

class TaskRepoitoryImpl  extends TaskRepository{
  final SqlLiteConnectionFactory _sqlLiteConnectionFactory;
  
  TaskRepoitoryImpl({required SqlLiteConnectionFactory sqlLiteConnectionFactory }):_sqlLiteConnectionFactory = sqlLiteConnectionFactory;
 
 
 @override
  Future<void> save(DateTime date, String description) async {
     final conn = await _sqlLiteConnectionFactory.openConnection();
      await conn?.insert('todo',{
         'id' : null,
         'descricao' :description,
         'data_hora' : date.toIso8601String(),
         'finalizado': 0
      });
  }

  @override
  Future<List<TaskModel>> findTaskByPeridic(DateTime start, DateTime end) async {
    try {
      final startFilter = DateTime(start.year,start.month,start.day,0,0,0);
    final endFilter = DateTime(end.year,end.month,end.day,23,59,59);
  
    final con = await _sqlLiteConnectionFactory.openConnection();

   final result = await con!.rawQuery('''SELECT * FROM todo WHERE data_hora BETWEEN ? AND ? ORDER BY data_hora   
         ''',[ startFilter.toIso8601String(),endFilter.toIso8601String()]
       );

       return result.map((e) => TaskModel.loadFromDb(e)).toList();
    }  on Exception catch (e,s) {
        if (kDebugMode) {
          print(e);
         print(s);
        }
        throw Exception ("erro ao buscar task por periodo");
    }
  }
  
  @override
  Future<void> checkOrUncheck(TaskModel taskModel)  async {
    final conn = await _sqlLiteConnectionFactory.openConnection();
    final finished = taskModel.finished == 1  ? 1:0;  
     conn!.rawUpdate('UPDATE todo SET finalizado = ? WHERE id = ?',[finished , taskModel.id]);
  
  }
  
  @override
  Future<void> delete(TaskModel taskModel) async {
   final conn = await _sqlLiteConnectionFactory.openConnection();
    conn!.rawDelete('DELETE FROM todo WHERE id =?',[taskModel.id]);
  }

  
  Future<void> deleteAll() async {
   final conn = await _sqlLiteConnectionFactory.openConnection();
    conn!.rawDelete('DELETE FROM todo');
  }

  
}