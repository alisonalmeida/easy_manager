// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_list_tile_check.dart';
import 'package:easy_manager/custom_widgets/empty_widget.dart';
import 'package:easy_manager/models/product_provider_model.dart';
import 'package:easy_manager/utils/colors.dart';
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
          return Container();
        },
      );
    },
  );
  return returnedValue;
}
