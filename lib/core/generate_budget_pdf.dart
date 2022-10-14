// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateBudgetPdf {
  GenerateBudgetPdf({required this.budget});
  final Budget budget;

  Future generateDocument() async {
    final DateTime now = DateTime.now();
    var dateFormattedForDocument = DateFormat('yyyy-MM-dd-hh-mm').format(now);
    List<TableRow> itens = [];
    int quantidadeTotal = 0;
    for (var element in budget.itens!) {
      quantidadeTotal = element.quantidade! + quantidadeTotal;
    }
    TableRow titleRow = TableRow(children: [
      Text('Produto',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      Text('Quantidade',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      Text('Valor',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    ]);
    TableRow finalRow = TableRow(children: [
      Text('TOTAL',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      Text(quantidadeTotal.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      Text('R\$ ${budget.valorTotal}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    ]);
    itens.add(titleRow);
    itens.addAll(budget.itens!
        .map((element) => TableRow(children: [
              Text('  ${element.produtoNome!}'.replaceAll(RegExp('"'), ''),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(element.quantidade.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text('  R\$ ${element.produtoValor}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ]))
        .toList());
    itens.add(finalRow);
    final pdf = Document();
    final mainLogo =
        (await rootBundle.load(kpathMainLogo)).buffer.asUint8List();

    pdf.addPage(MultiPage(
      header: (context) {
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              width: 100, height: 100, child: Image(MemoryImage(mainLogo))),
        ]);
      },
      build: (context) {
        return [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Orçamento',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              budget.nomeCliente!.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Expanded(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Cliente: ',
                                    ),
                                    TextSpan(
                                      text: budget.nomeCliente,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                ),
                              )
                            ])
                          ]),
                    )
                  : Container(),
              Column(
                children: [
                  Table(
                    border: TableBorder.all(width: 0.1),
                    children: itens,
                  )
                ],
              ),
            ],
          )
        ];
      },
      footer: (context) {
        var dateFormattedForDocument =
            DateFormat('dd/MM/yyyy').format(DateTime.now().toLocal());
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'DATA: ',
                  ),
                  TextSpan(
                    text: dateFormattedForDocument,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
          ]),
          SizedBox(height: 5),
          SizedBox(height: 10),
          Column(children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image(
                MemoryImage(mainLogo),
              ),
            ),
          ])
        ]);
      },
    ));

    Directory? directory;
    if (Platform.isWindows) {
      directory = await getDownloadsDirectory();
    } else {
      directory = await getApplicationSupportDirectory();
    }
    final bytes = await pdf.save();
    final file = File(
        '${directory!.path}/CadastrosCompilados-$dateFormattedForDocument.pdf');
    await file.writeAsBytes(bytes);

    Platform.isWindows
        ? launchUrlString(
            '${directory.path}/CadastrosCompilados-$dateFormattedForDocument.pdf')
        : Share.shareFiles([
            '${directory.path}/CadastrosCompilados-$dateFormattedForDocument.pdf'
          ], mimeTypes: [
            'application/pdf'
          ]);
  }
}
