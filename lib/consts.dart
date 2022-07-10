import 'package:flutter/material.dart';

const String kAddressBox = 'addressBox';
const String kCustomerBox = 'CustomerBox';
const String kProductBox = 'productBox';
const String kProductProviderBox = 'productProviderBox';

const String kpathSvgPlus = 'lib/assets/svg/plus.svg';
const String kpathSvgMinus = 'lib/assets/svg/minus.svg';
const String kpathSvgArrowBack = 'lib/assets/svg/arrow_back.svg';
const String kpathSvgRefresh = 'lib/assets/svg/refresh.svg';
const String kpathSvgPerson = 'lib/assets/svg/person.svg';

showGeneralDialogErrorMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
          content: Text(message),
        );
      });
}

showGeneralWaitingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: SizedBox(
              height: 50, width: 50, child: CircularProgressIndicator()),
        );
      });
}
