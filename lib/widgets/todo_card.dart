// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title']),
        subtitle: Text(item['description']),
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
                value: 'edit',
                child: Text(
                  'Edit',
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(
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
