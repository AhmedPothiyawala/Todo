class Task {
  final int id;
  final String title;
  final bool completed;
  final String category;
  final DateTime? dueDate;
  Task({
    required this.id,
    required this.title,
    this.completed = false,
    this.category = '',
    this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as int,
        title: json['title'] as String,
        completed: json['completed'] as bool,
        category: json['category'] as String,
        dueDate:
            json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'category': category,
        'dueDate': dueDate?.toIso8601String(),
      };

  Task copyWith({
    int? id,
    String? title,
    bool? completed,
    String? category,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
