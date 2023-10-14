import 'package:flutter/material.dart';
import 'package:flutter_login/screen/memb_add.dart';
import 'package:flutter_login/services/memb_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:flutter_login/widget/memb_card.dart';

class MembListPage extends StatefulWidget {
  const MembListPage({super.key});

  @override
  State<MembListPage> createState() => _MembListPageState();
}

class _MembListPageState extends State<MembListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການແຈ້ງເຕືອນ'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Item to do',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  // ignore: unused_local_variable
                  final id = item['member_id'] as String;
                  return Memb_Card(
                    index: index,
                    item: item,
                    deleteById: deleteById,
                    navigateEdit: navigatetedToEdit,
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: navigatetedToAdd, child: Icon(Icons.add)),
    );
  }

  Future<void> navigatetedToEdit(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigatetedToAdd() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await MembService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
      showSuccessMessage(context, message: 'ລືບສຳເລັດແລ້ວ');
    } else {
      showErrorMessage(context, message: 'ລືບ ບໍ່ສຳເລັດແລ້ວ');
      // showErrorMessage('ລືບ ບໍ່ສຳເລັດແລ້ວ');
    }
  }

  Future<void> fetchTodo() async {
    final response = await MembService.fetchTodos();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Somthing went wrong');
    }
    setState(() {
      isLoading = false;
    });
  }
}
