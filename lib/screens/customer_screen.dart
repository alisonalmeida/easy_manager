// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/screens/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late final Box _customerBox;

  @override
  void initState() {
    _customerBox = Hive.box(kCustomerBox);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dandelion,
        appBar: CustomAppBar(title: 'Clientes', backgroundColor: dandelion),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ValueListenableBuilder(
              valueListenable: _customerBox.listenable(),
              builder: (context, Box box, widget) {
                List<Customer> list = [];
                box.toMap().forEach((key, value) {
                  list.add(value);
                });
                if (box.isEmpty) {
                  return EmptyListWidget();
                } else {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CrudCustomerScreen(
                                    isUpdate: true,
                                    customerKey: list[index].cpf))),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: white,
                              border: Border.all(),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(3, 2), color: Colors.black)
                              ]),
                          child: ListTile(
                            leading: Text(index.toString()),
                            title: Text(list[index].name),
                            subtitle: Text(list[index].cpf),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrudCustomerScreen(isUpdate: false))),
            shadowColor: woodSmoke,
            iconPath: 'lib/assets/svg/plus.svg'));
  }
}

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(),
                boxShadow: const [
                  BoxShadow(offset: Offset(3, 2), color: Colors.black)
                ]),
            child: const Text(
              'Vazio',
              style: TextStyle(fontSize: 40),
            )));
  }
}
