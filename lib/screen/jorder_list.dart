import 'package:flutter/material.dart';
import 'package:flutter_login/screen/bill_list.dart';
import 'package:flutter_login/screen/jbill_list.dart';
import 'package:flutter_login/screen/jorder_add.dart';
import 'package:flutter_login/screen/menu.dart';
import 'package:flutter_login/services/jorder_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:flutter_login/widget/jorder_card.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class JOrderListPage extends StatefulWidget {
  const JOrderListPage({super.key, this.billCode});
  final String? billCode;

  @override
  State<JOrderListPage> createState() => _JOrderListPageState();
}

class _JOrderListPageState extends State<JOrderListPage> {
  bool isLoading = true;
  List items = [];
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  String getMaxBillCode = "";

  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await fetchmaxTodo();
      fetchTodo();
    });

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
          // title: Text("order list"),
          title: Text(getMaxBillCode),
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
                    final id = item['bill_id'].toString() as String;
                    return JOrder_Card(
                      index: index,
                      item: item,
                      deleteById: deleteById,
                      navigateEdit: navigatetedToEdit,
                      navigatePrint: navigatetedToPrint,
                    );
                  }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: navigatetedToAdd, child: Icon(Icons.add)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'ເມນູ',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'ຂາຍ',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              label: 'ລາຍງານ',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'ຕັ້ງຄ່າ',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(25, 2, 105, 1),
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return menuScreen();
        }));
      } else if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BillListPage();
        }));
      }else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return JbillListPage();
        }));
      }
    });
  }

  Future<void> navigatetedToPrint(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigatetedToAdd() async {
    final route = MaterialPageRoute(
      builder: (context) =>
          AddTodoPage(billCode: widget.billCode ?? getMaxBillCode),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });

    fetchTodo();
  }

  Future<void> navigatetedToEdit(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await JOrderService.deleteById(id);
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
    print('call data successfully');
    final response =
        await JOrderService.fetchTodos(widget.billCode ?? getMaxBillCode);
    // final response = await OrderService.fetchTodos();
    print('get fetchmaxbill');
    print(response);

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

  Future<void> fetchmaxTodo() async {
    print('call RRN get maxTodo');
    // final response = await OrderService.fetchTodos(widget.billCode);
    final response = await JOrderService.fetchmaxbill();
    print('get fetchmaxbill');
    print(response);
    if (response != null) {
      setState(() {
        getMaxBillCode = response[0]['bill_code'];
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
