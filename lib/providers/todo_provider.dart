import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoProvider() {
    // Listen to real-time updates
    _todosCollection.snapshots().listen((snapshot) {
      _todos = snapshot.docs.map((doc) {
        return Todo.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addTodo(String title) async {
    await _todosCollection.add({
      'title': title,
      'isDone': false,
    });
  }

  Future<void> toggleDone(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({
      'isDone': !currentStatus,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }
}
