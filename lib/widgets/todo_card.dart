// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;

  final Function(Map) navigateEdit;
  final Function(String) deleteByID;
  const TodoCard({
    Key? key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteByID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      color: Colors.grey[300],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 204, 41, 90),
          child: Text(
            '${index + 1}',
            style: GoogleFonts.chewy(fontSize: 25),
          ),
        ),
        title: Text(
          item['title'],
          style: GoogleFonts.chewy(fontSize: 20, color: Colors.black),
        ),
        subtitle: Text(
          item['description'],
          style: GoogleFonts.chewy(),
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              //Open Edit page
              navigateEdit(item);
            } else if (value == 'delete') {
              //Delete and remove item
              deleteByID(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                textStyle: GoogleFonts.chewy(color: Colors.black),
                value: 'edit',
                child: const Text(
                  'Edit',
                ),
              ),
              PopupMenuItem(
                textStyle: GoogleFonts.chewy(color: Colors.black),
                value: 'delete',
                child: const Text(
                  'Delete',
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
