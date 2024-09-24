
class TaskModel {
   final int id;
   final String description;
   final DateTime dataTime;
   final int finished ;
  TaskModel({
    required this.id,
    required this.description,
    required this.dataTime,
    required this.finished,
  });


  factory TaskModel.loadFromDb(Map<String,dynamic> task) {
    return TaskModel(
      id: task['id'], 
      description: task['descricao'], 
      dataTime: DateTime.parse(task['data_hora']), 
      finished: task['finalizado'] ?? 1,
      );
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    int? finished
  }){
        return TaskModel(
          id: id ??this.id, 
          description: description ?? this.description, 
          dataTime: dataTime ?? this.dataTime, 
          finished: finished ?? this.finished
          );
  }
}
