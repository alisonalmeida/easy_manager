// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/helper/objectbox_helper.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/screens/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../custom_widgets/custom_list_tile.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Stream<List<Customer>> streamCustomers;
  @override
  void initState() {
    streamCustomers = companyBox.getCustomers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customerBackgroundColor,
        appBar: CustomAppBar(
            heroAnimation: 'Clientes',
            svgImage: kpathSvgPerson,
            title: 'Clientes',
            backgroundColor: customerBackgroundColor,
            callback: () async => Navigator.pop(context)),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: StreamBuilder<List<Customer>>(
                stream: streamCustomers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final customers = snapshot.data;

                  if (customers!.isEmpty) {
                    return EmptyWidget();
                  }

                  return ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];
                      return CustomListTile(
                          deleteCallback: () => _showDeleteAlertDialog(
                              context, customer.id, customer.name!),
                          editCallback: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CrudCustomerScreen(
                                        customerId: customer.id,
                                      ))),
                          title: customer.name!,
                          icon: Icons.person,
                          subtitle: customer.cpf!);
                    },
                  );
                },
              ),
            )),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrudCustomerScreen()));
            },
            shadowColor: woodSmoke,
            iconPath: kpathSvgPlus));
  }

  _showDeleteAlertDialog(context, int index, String name) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirmar"),
      onPressed: () {
        companyBox.deleteCustomer(index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(name),
      content: Text("Confirma a exclusão do cadastro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  }
}
