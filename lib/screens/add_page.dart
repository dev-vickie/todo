import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/model.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    TodoItem body =
        TodoItem(title: title, description: description, is_completed: false);

    const url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      //toJson instead of jsonDecode
      body: body.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
    );
    //Declare these before calling them
    void showSuccessMessage(String message) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void showErrorMessage(String message) {
      final snackBar = SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (response.statusCode == 201) {
      showSuccessMessage('Creation Success');
      titleController.text = '';
      descriptionController.text = '';
    } else {
      showErrorMessage("Creation Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submitData,
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
