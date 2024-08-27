import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task_model.dart';
import 'sub_task_model.dart';

Future<Database> openDataBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), "Task_database.db"),
    onCreate: (db, version) {
      db.execute("CREATE TABLE Tasks ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "name TEXT, "
          "due_date TEXT, "
          "due_time TEXT, "
          "description TEXT, "
          "is_completed INTEGER DEFAULT 0"
          ")");
      db.execute("CREATE TABLE SubTasks ("
          "id_subtask INTEGER PRIMARY KEY AUTOINCREMENT,"
          "judul TEXT NOT NULL,"
          "id_main_task INTEGER NOT NULL,"
          "is_completed INTEGER DEFAULT 0,"
          "FOREIGN KEY (id_main_task) REFERENCES Tasks(id)"
          ")");
    },
    version: 1,
  );
  return database;
}

// insert task to database
Future<void> insertTask(Task task) async {
  final Database database = await openDataBase();
  await database.insert(
    "Tasks",
    task.toMap(),
  );
}

// get all task
Future<List<Task>> readAllTasks() async {
  final Database database = await openDataBase();
  final List<Map<String, dynamic>> taskMaps =
      await database.rawQuery('SELECT * FROM Tasks');
  return List.generate(taskMaps.length, (index) {
    return Task(
      id: taskMaps[index]['id'],
      taskName: taskMaps[index]['name'],
      dueDate: taskMaps[index]["due_date"],
      dueTime: taskMaps[index]["due_time"],
      description: taskMaps[index]["description"],
      isCompleted: taskMaps[index]["is_completed"],
    );
  });
}

// delete task
Future<void> deleteTask(int id) async {
  final Database database = await openDataBase();
  await database.delete("Tasks", where: "id = ?", whereArgs: [id]);
}

// update the task
Future<void> updateTask(Task task) async {
  final Database database = await openDataBase();
  await database
      .update('Tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
}

// sub task function

// insert sub task
Future<void> insertSubTask(SubTask subTask) async {
  final Database database = await openDataBase();
  await database.insert(
    "SubTasks",
    subTask.toMap(),
  );
}

Future<List<SubTask>> readSubTasksByMainTask(int id) async {
  final Database database = await openDataBase();
  final List<Map<String, dynamic>> subTaskMaps = await database.rawQuery(
    'SELECT * FROM SubTasks WHERE id_main_task = ?',
    [id],
  );
  return List.generate(subTaskMaps.length, (index) {
    return SubTask(
      idSubtask: subTaskMaps[index]['id_subtask'],
      judul: subTaskMaps[index]['judul'],
      idMainTask: subTaskMaps[index]['id_main_task'],
      isCompleted: subTaskMaps[index]["is_completed"],
    );
  });
}

Future<void> updateSubTask(SubTask subTask) async {
  final Database database = await openDataBase();

  await database.update("SubTasks", subTask.toMap(), where: "id_subtask = ?", whereArgs:  [subTask.idSubtask]);

}
