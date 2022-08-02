import 'dart:io';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
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
  bool isFlashOn = false;

  @override
  void initState() {
    _onQRViewCreated;

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Produtos',
        heroAnimation: '',
        backgroundColor: productBackgroundColor,
        svgImage: kpathSvgProduct,
        callback: () async => Navigator.pop(context),
      ),
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
        Container(
          color: productBackgroundColor,
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                    onPressed: () async {
                      setState(() {
                        controller.toggleFlash();
                        isFlashOn = !isFlashOn;
                      });
                    },
                    icon: isFlashOn
                        ? const Icon(Icons.flash_on)
                        : const Icon(Icons.flash_off)),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () async {
                        await controller.flipCamera();
                      },
                      icon: const Icon(Icons.cameraswitch)))
            ],
          ),
        )
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      result = scanData;
      String? scannedQr = result!.code;
      if (result!.code!.isNotEmpty) {
        Navigator.of(context).pop(scannedQr);
      }
    });
  }
}
