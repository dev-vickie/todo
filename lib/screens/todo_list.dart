import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/snackbar_helper.dart';
import 'package:todo_app/widgets/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 60, 103),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 204, 41, 90),
        centerTitle: true,
        title: Text('Todo App'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchApi,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "No todo item",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'];
                return TodoCard(
                    index: index,
                    item: item,
                    navigateEdit: _navigateToEditPage,
                    deleteByID: deleteById);
              },
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[300],
        onPressed: () {
          _navigateToAddPage();
        },
        label: Text(
          'Add Todo',
          style: GoogleFonts.chewy(color: Colors.pink[600]),
        ),
      ),
    );
  }

  Future<void> deleteById(id) async {
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      final newItems = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = newItems;
      });
    } else {
      showErrorMessage(context, message: "Unable to delete");
    }
  }

  Future<void> fetchApi() async {
    final response = await TodoService.fetchAPi();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Something Went Wrong');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodo(),
    );
    await Navigator.of(context).push(route);
    setState(() {
      isLoading = true;
    });
    fetchApi();
  }

  Future<void> _navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(todo: item),
    );
    await Navigator.of(context).push(route);
    setState(() {
      isLoading = true;
      fetchApi();
    });
  }
}
