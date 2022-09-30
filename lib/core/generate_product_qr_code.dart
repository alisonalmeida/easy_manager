// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:easy_manager/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateProductQrCode {
  GenerateProductQrCode({required this.barcode, required this.product});
  final Barcode barcode;
  final Product product;

  Future generateDocument() async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat(100, 100),
      build: (context) {
        return [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(product.nome!),
              SvgImage(
                svg: barcode.toSvg(
                    '''Código: ${product.codigo}, Nome: ${product.nome}, Valor: R\$ ${product.valorVenda}'''),
              ),
              Text('R\$ ${product.valorVenda}'),
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
    final finalDirectory = '${directory!.path}/QrCode-${product.codigo}.pdf'
        .replaceAll(RegExp(r'\s'), '-')
        .toLowerCase();
    final file = File(finalDirectory);
    await file.writeAsBytes(bytes);

    Platform.isWindows
        ? launchUrlString(finalDirectory)
        : Share.shareFiles([finalDirectory], mimeTypes: ['application/pdf']);
  }
}
