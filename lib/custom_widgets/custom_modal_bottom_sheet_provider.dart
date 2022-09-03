// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Future<String> showProviderChoiceDialog(BuildContext context) async {
  DraggableScrollableController controller = DraggableScrollableController();

  String returnedValue = '';
  await showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        controller: controller,
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    returnedValue = 'data';
                    Navigator.pop(context);
                  },
                  child: Text('data'))
            ],
          );
        },
      );
    },
  );
  return returnedValue;
}
