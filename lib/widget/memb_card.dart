import 'package:flutter/material.dart';

class Memb_Card extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  const Memb_Card({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['member_id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['fristname']),
        subtitle: Text(item['lastname'].toString()),
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
