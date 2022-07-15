// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/models/db_model.dart';
import 'package:easy_manager/objectbox.g.dart';

import 'package:easy_manager/screens/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late Box<CustomerModel>? _customerBox;

  @override
  void initState() {
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
        /**appBar: CustomAppBar(title: 'Clientes', backgroundColor: dandelion), */
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Text('data'),
            )),
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {
                //       customerBox.clearAllCustomers();
              },
              child: Text('teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrudCustomerScreen(
                            isUpdate: false,
                            customerBox: _customerBox!,
                          )));
            },
            shadowColor: woodSmoke,
            iconPath: 'lib/assets/svg/plus.svg'));
  }
}
