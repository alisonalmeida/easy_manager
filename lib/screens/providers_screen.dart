// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({Key? key}) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: carribeanGreen,
      appBar: CustomAppBar(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset('lib/assets/svg/factory.svg')),
                Row(
                  children: [
                    ButtonRoundWithShadow(
                        size: 48,
                        borderColor: woodSmoke,
                        color: white,
                        callback: () => Navigator.pop(context),
                        shadowColor: woodSmoke,
                        iconPath: 'lib/assets/svg/arrow_back.svg'),
                    const SizedBox(width: 50),
                    Text(
                      textAlign: TextAlign.center,
                      'Fornecedores',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'JosefinsSans',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: [
            CustomListTile(
              icon: Icons.add,
              text: 'Cadastrar',
              callback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrudProviderScreen(isUpdate: false),
                  )),
            ),
            CustomListTile(icon: Icons.list, text: 'Listar', callback: () {}),
          ],
        ),
      ),
    );
  }
}
