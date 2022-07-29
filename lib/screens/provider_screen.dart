// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/screens/crud_provider_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({Key? key}) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  late Stream<List<ProductProvider>> streamProviders;

  @override
  void initState() {
    streamProviders = companyBox.getProviders();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: providerBackgroundColor,
        appBar: CustomAppBar(
            title: 'Fornecedores',
            backgroundColor: providerBackgroundColor,
            callback: () async => Navigator.pop(context),
            svgImage: kpathSvgFactory,
            heroAnimation: 'Fornecedores'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: StreamBuilder<List<ProductProvider>>(
                stream: streamProviders,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return EmptyWidget();
                  } else {
                    final providers = snapshot.data;
                    if (providers!.isEmpty) {
                      return EmptyWidget();
                    }

                    return ListView.builder(
                        itemCount: providers.length,
                        itemBuilder: (context, index) {
                          final provider = providers[index];
                          return CustomListTile(
                              deleteCallback: () => _showDeleteAlertDialog(
                                  context, provider.id, provider.name!),
                              editCallback: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CrudProviderScreen(
                                          productProviderKey: provider.id))),
                              title: provider.name!,
                              icon: Icons.person,
                              subtitle: provider.document!);
                        });
                  }
                },
              ),
            )),
        persistentFooterButtons: [
          ElevatedButton(onPressed: () {}, child: Text('Teste'))
        ],
        floatingActionButton: ButtonRoundWithShadow(
            size: 60,
            borderColor: woodSmoke,
            color: white,
            callback: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CrudProviderScreen())),
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
        companyBox.deleteProvider(index);
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
