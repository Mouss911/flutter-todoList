class Todo {
  String id;
  String title;
  bool isDone;

  Todo({this.id = '', required this.title, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map, String id) {
    return Todo(
      id: id,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}
