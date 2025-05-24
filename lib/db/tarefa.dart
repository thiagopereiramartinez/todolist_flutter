class Tarefa {
  final int? id;
  final String title;
  final String createdAt;
  bool completed;

  Tarefa({
    this.id,
    required this.title,
    required this.createdAt,
    this.completed = false,
  });

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'createdAt': createdAt,
      'completed': completed ? 1 : 0,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      createdAt: map['createdAt'] as String,
      completed: (map['completed'] ?? 0) == 1,
    );
  }

  @override
  String toString() {
    return 'Tarefa{id: $id, title: $title, createdAt: $createdAt, completed: $completed}';
  }
}
