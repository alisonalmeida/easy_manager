// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/models/product.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateProductQrCode {
  GenerateProductQrCode({required this.barcode, required this.product});
  final Barcode barcode;
  final Product product;

  Future generateDocument() async {
    final DateTime now = DateTime.now();
    var dateFormattedForDocument = DateFormat('yyyy-MM-dd-hh-mm').format(now);

    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) {
        return [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(product.nome!),
              Center(child: SvgImage(svg: barcode.toSvg('data')))
            ],
          )
        ];
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
