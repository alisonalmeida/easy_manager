// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateBudgetReport extends StatelessWidget {
  GenerateBudgetReport(
      {super.key, required this.screenshotController, required this.budget});
  final ScreenshotController screenshotController;
  final Budget budget;

  List<TableRow> itens = [];
  int quantidadeTotal = 0;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    var dateFormattedForDocument = DateFormat('dd-MM-yyyy').format(now);
    for (var element in budget.itens!) {
      quantidadeTotal = element.quantidade! + quantidadeTotal;
    }
    TableRow titleRow = TableRow(children: [
      Text('Produto',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('Quantidade',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text('Valor',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
    TableRow finalRow = TableRow(children: [
      Text('TOTAL',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      Text(quantidadeTotal.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      Text('R\$ ${budget.valorTotal}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    ]);
    itens.add(titleRow);
    itens.addAll(budget.itens!
        .map((element) => TableRow(children: [
              Text('  ${element.produtoNome!}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text(element.quantidade.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Text('  R\$ ${element.produtoValor}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ]))
        .toList());
    itens.add(finalRow);

    return Scaffold(
      appBar: CustomAppBar(
          backgroundColor: white,
          callback: () async {
            Navigator.pop(context);
          },
          heroAnimation: '',
          svgImage: kpathSvgBudgets,
          title: 'Orçamento'),
      body: imageToShare(dateFormattedForDocument),
      floatingActionButton: ButtonRoundWithShadow(
          borderColor: black,
          color: white,
          iconPath: kpathSvgShare,
          shadowColor: black,
          size: 50,
          callback: () async {
            Directory? directory;
            if (Platform.isWindows) {
              directory = await getDownloadsDirectory();
            } else {
              directory = await getApplicationSupportDirectory();
            }
            final bytes = await screenshotController
                .captureFromWidget(imageToShare(dateFormattedForDocument));

            var file = File(
                '${directory!.path}/Orçamento-${budget.nomeCliente}-$dateFormattedForDocument.png');
            await file.writeAsBytes(bytes);

            Platform.isWindows
                ? launchUrlString(directory.path)
                : Share.shareFiles([
                    '${directory.path}/Orçamento-${budget.nomeCliente}-$dateFormattedForDocument.png'
                  ], mimeTypes: [
                    'application/pdf'
                  ]);
          }),
    );
  }

  Widget imageToShare(String data) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(children: [
              SizedBox(
                  height: 100, width: 200, child: Image.asset(kpathMainLogo))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: []),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Cliente: ',
                        style: TextStyle(fontSize: 20, color: black)),
                    TextSpan(
                        text: '${budget.nomeCliente}',
                        style: TextStyle(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.bold))
                  ],
                )),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(),
                            left: BorderSide(),
                            top: BorderSide())),
                    child: Text(data,
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
            Column(
              children: [
                Table(
                  border: TableBorder.all(),
                  children: itens,
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(),
                          left: BorderSide(),
                          bottom: BorderSide())),
                  child:
                      Text(data, style: TextStyle(fontWeight: FontWeight.bold)))
            ]),
          ],
        ),
      ),
    );
  }
}
