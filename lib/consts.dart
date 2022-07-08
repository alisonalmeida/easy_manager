import 'package:flutter/material.dart';

const String kAddressBox = 'addressBox';
const String kCustomerBox = 'CustomerBox';
const String kProductBox = 'productBox';
const String kProductProviderBox = 'productProviderBox';

const String kpathSvgPlus = 'lib/assets/svg/plus.svg';
const String kpathSvgMinus = 'lib/assets/svg/minus.svg';

showGeneralDialogErrorMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
          content: Text(message),
        );
      });
}

showGeneralWaitingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CircularProgressIndicator(),
        );
      });
}
