import 'dart:convert';

class TodoItem {
  String title;
  String description;
  bool is_completed;
  TodoItem({
    required this.title,
    required this.description,
    required this.is_completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'is_completed': is_completed,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      title: map['title'] as String,
      description: map['description'] as String,
      is_completed: map['is_completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
