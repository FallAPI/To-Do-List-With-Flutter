class SubTask {
  int? idSubtask;
  final String judul;
  final int idMainTask;
  int isCompleted;

  SubTask({this.idSubtask, required this.judul, required this.idMainTask, required this.isCompleted});

  // Convert SubTask to Map for database insertion
  Map<String, dynamic> toMap() => {
        'id_subtask': idSubtask,
        'judul': judul,
        'id_main_task': idMainTask,
        'is_completed' : isCompleted
      };

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      idSubtask: map['id_subtask'],
      judul: map['judul'],
      idMainTask: map['id_main_task'], 
      isCompleted: map['is_completed'],
    );
  }
}
