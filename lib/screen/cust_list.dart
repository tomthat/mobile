import 'package:flutter/material.dart';
import 'package:flutter_login/screen/cust_add.dart';
import 'package:flutter_login/services/cust_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:flutter_login/widget/cust_card.dart';

class CustListPage extends StatefulWidget {
  const CustListPage({super.key});

  @override
  State<CustListPage> createState() => _CustListPageState();
}

class _CustListPageState extends State<CustListPage> {
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
                  final id = item['idm'] as String;
                  return Cust_Card(
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
    final isSuccess = await CustService.deleteById(id);
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
    final response = await CustService.fetchTodos();

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
