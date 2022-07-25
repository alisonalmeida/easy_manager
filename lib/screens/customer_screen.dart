// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/company_model.dart';
import 'package:easy_manager/screens/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../helper/objectbox_helper.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Stream<List<Customer>> streamCustomers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dandelion,
        appBar: CustomAppBar(
            heroAnimation: 'Clientes',
            svgImage: kpathSvgPerson,
            title: 'Clientes',
            backgroundColor: dandelion,
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
                        return CustomListTile(
                            deleteCallback: () => _showDeleteAlertDialog(
                                context,
                                customers[index].id,
                                customers[index].name!),
                            editCallback: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CrudCustomerScreen(
                                    customerKey: customers[index].id,
                                  );
                                },
                              ));
                            },
                            title: customers[index].name!,
                            icon: Icons.person,
                            subtitle: customers[index].cpf!);
                      },
                    );
                  }),
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
            iconPath: 'lib/assets/svg/plus.svg'));
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
        //companyDB.deleteCustomer(index);
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
