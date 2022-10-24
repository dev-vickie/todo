// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:todo_app/models/model.dart';
import 'package:todo_app/utils/snackbar_helper.dart';

class AddTodo extends StatefulWidget {
  final Map? todo;
  const AddTodo({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    //Logic to switch between add todo and edit todo
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 60, 103),
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Title', hintStyle: GoogleFonts.chewy()),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'Description',
              hintStyle: GoogleFonts.chewy(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            //Initially isEdit = False
            onPressed: (isEdit ? updateData : submitData),
            child: Text(isEdit ? 'Update' : 'Submit'),
          )
        ],
      ),
    );
  }

//-------Services

  Future<void> updateData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    TodoItem body =
        TodoItem(title: title, description: description, isCompleted: false);
    final todo = widget.todo;

    final id = todo?['_id'];
    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      //toJson instead of jsonDecode-from Model
      body: body.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      showSuccessMessage('Creation Success');
    } else {
      showErrorMessage(context, message: "Creation Error");
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    TodoItem body =
        TodoItem(title: title, description: description, isCompleted: false);

    const url = 'http://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: body.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
    );

    if (response.statusCode == 201) {
      showSuccessMessage('Creation Success');
      titleController.text = '';
      descriptionController.text = ''; //Empty the controllers after submission
      //_navigateToHomePage();
    } else {
      showErrorMessage(context, message: 'Something went wrong');
    }
  }

//Success Message
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Future<void> _navigateToHomePage() async {
  //   final route = MaterialPageRoute(
  //     builder: (context) => const HomePage(),
  //   );
  //   await Navigator.of(context).push(route);
  // }
}
