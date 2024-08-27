class Task {
  int? id;
  String taskName;
  String dueDate;
  String dueTime;
  String description;
  int isCompleted; // Tambahkan properti isCompleted

  Task({
    this.id,
    required this.taskName,
    required this.dueDate,
    required this.dueTime,
    required this.description,
    required this.isCompleted, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': taskName,
      'due_date': dueDate,
      'due_time': dueTime,
      'description': description,
      'is_completed':isCompleted , 
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['name'],
      dueDate: map['due_date'],
      dueTime: map['due_time'],
      description: map['description'],
      isCompleted: map['is_completed'], 
    );
  }
}
