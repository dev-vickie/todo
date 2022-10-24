import 'dart:convert';

class TodoItem {
  String title;
  String description;
  bool isCompleted;
  TodoItem({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
