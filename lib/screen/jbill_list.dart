import 'package:flutter/material.dart';
import 'package:flutter_login/screen/bill_list.dart';
// import 'package:flutter_login/screen/jbill_add.dart';
import 'package:flutter_login/screen/jbill_open.dart';
import 'package:flutter_login/screen/menu.dart';
import 'package:flutter_login/services/jbill_service.dart';
import 'package:flutter_login/utils/snackbar_helper.dart';
import 'package:flutter_login/widget/jbill_card.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class JbillListPage extends StatefulWidget {
  const JbillListPage({super.key});

  @override
  State<JbillListPage> createState() => _JbillListPageState();
}

class _JbillListPageState extends State<JbillListPage> {
  bool isLoading = true;
  List items = [];
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  int _selectedIndex = 2;

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
          title: Text('Jbill list'),
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
                    return Jbill_Card(
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
            // onPressed: navigatetedToAdd, child: Icon(Icons.add)
            onPressed: navigatetedOpenjbill,
            child: Icon(Icons.add)),
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
      builder: (context) => OpenTodoPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigatetedOpenjbill() async {
    final route = MaterialPageRoute(
      builder: (context) => OpenTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigatetedToAdd() async {
    final route = MaterialPageRoute(
      builder: (context) => OpenTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigatetedToEdit(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => OpenTodoPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await JbillService.deleteById(id);
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
    final response = await JbillService.fetchTodos();
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
}
