import 'package:flutter/material.dart';

class Cust_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  const Cust_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['idm'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['fullname']),
        subtitle: Text(item['phone'].toString()),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              navigateEdit(item);
            } else if (value == 'delete') {
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('ແກ້ໄຂ'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('ລືບ'),
                value: 'delete',
              ),
            ];
          },
        ),
      ),
    );
  }
}
