// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/custom_button_add.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/customer_model.dart';
import 'package:easy_manager/screens/customer/crud_customer_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

Future<String> showCustomerChoiceDialog(BuildContext context) async {
  DraggableScrollableController controller = DraggableScrollableController();
  Future<List<Map<String, String>>>? listCustomers;
  listCustomers = gSheetDb.getCustomers();

  String returnedValue = '';
  await showModalBottomSheet(
    backgroundColor: customerBackgroundColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        controller: controller,
        initialChildSize: 0.9,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: black,
                  ),
                ),
                Flexible(
                    child: Text(
                  'Escolha um cliente ou adicione um novo',
                  style: TextStyle(
                      color: woodSmoke,
                      fontSize: 20,
                      fontFamily: 'JosefinsSans',
                      fontWeight: FontWeight.w700),
                )),
                CustomAddButton(
                    text: 'Adicionar Novo Cliente',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CrudCustomerScreen(),
                          ));
                    }),
                Expanded(
                  child: FutureBuilder(future: listCustomers,
                    builder: (context, snapshot) {
                    
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: black),
                        );
                      } else {
                        if (snapshot.hasData) {
                          List<Map<String, String>> mapList =
                              snapshot.data as List<Map<String, String>>;
                          mapList = mapList.reversed.toList();

                          return ListView.builder(
                              itemCount: mapList.toList().length,
                              itemBuilder: (context, index) {
                                Customer customer =
                                    Customer.fromMap(mapList[index]);

                                return Container(
                                  decoration: ShapeDecoration(shadows: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(
                                        3.0,
                                        4.0,
                                      ),
                                    )
                                  ], color: Colors.white, shape: Border.all()),
                                  child: ListTile(
                                      onTap: () {
                                        returnedValue = customer.nome!;
                                        Navigator.pop(context);
                                      },
                                      title: Text(customer.nome!),
                                      subtitle: Text(customer.documento!)),
                                );
                              });
                        } else {
                          return EmptyWidget();
                        }
                      }
                  },)
                  
                ),
              ],
            ),
          );
        },
      );
    },
  );
  return returnedValue;
}
