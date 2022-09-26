import 'dart:io';

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateBudgetReport extends StatelessWidget {
  const GenerateBudgetReport(
      {super.key, required this.screenshotController, required this.budget});
  final ScreenshotController screenshotController;
  final Budget budget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: imageToShare(),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final DateTime now = DateTime.now();
        var dateFormattedForDocument =
            DateFormat('yyyy-MM-dd-hh-mm').format(now);
        Directory? directory;
        if (Platform.isWindows) {
          directory = await getDownloadsDirectory();
        } else {
          directory = await getApplicationSupportDirectory();
        }
        final bytes =
            await screenshotController.captureFromWidget(imageToShare());

        var file = File(
            '${directory!.path}/Orçamento-${budget.nomeCliente}-$dateFormattedForDocument.png');
        await file.writeAsBytes(bytes);

        Platform.isWindows
            ? launchUrlString(
                '${directory.path}/Orçamento-${budget.nomeCliente}-$dateFormattedForDocument.png')
            : Share.shareFiles([
                '${directory.path}/Orçamento-${budget.nomeCliente}-$dateFormattedForDocument.png'
              ], mimeTypes: [
                'application/pdf'
              ]);
      }),
    );
  }

  Widget imageToShare() {
    return Material(
        child: Column(
      children: [
        Row(
          children: [
            SizedBox(
                height: 100, width: 200, child: Image.asset(kpathMainLogo)),
          ],
        ),
        Divider(),
        Row(
          children: [
            Text('ORÇAMENTO: ${budget.nomeCliente}'),
          ],
        )
      ],
    ));
  }
}
