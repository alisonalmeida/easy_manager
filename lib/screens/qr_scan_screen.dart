import 'dart:io';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({Key? key}) : super(key: key);

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late final QRViewController controller;

/**
 *   @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
    super.reassemble();
  }
 */

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _buildQrView(context)),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: productBackgroundColor,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    print(controller.hasPermissions);
                  },
                  icon: Icon(Icons.flash_on)),
            ),
          ],
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
