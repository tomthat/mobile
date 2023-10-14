import 'package:flutter/material.dart';
import 'package:flutter_login/screen/bill_add.dart';
import 'package:flutter_login/services/bill_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:flutter_login/widget/bill_card.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BillListPage extends StatefulWidget {
  const BillListPage({super.key});

  @override
  State<BillListPage> createState() => _BillListPageState();
}

class _BillListPageState extends State<BillListPage> {
  bool isLoading = true;
  List items = [];
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";

  @override
  void initState() {
    super.initState();
    fetchTodo();
    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill list'),
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
                  final id = item['bill_id'] as String;
                  return Bill_Card(
                    index: index,
                    item: item,
                    deleteById: deleteById,
                    navigatePrint: navigatetedToPrint,
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: navigatetedToAdd, child: Icon(Icons.add)),
    );
  }

  Future<void> navigatetedToPrint(Map item) async {
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
    final isSuccess = await BillService.deleteById(id);
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
    final response = await BillService.fetchTodos();

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
