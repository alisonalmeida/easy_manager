// ignore_for_file: prefer_const_constructors

import 'package:barcode/barcode.dart';
import 'package:easy_manager/consts.dart';
import 'package:easy_manager/core/generate_product_qr_code.dart';
import 'package:easy_manager/main.dart';
import 'package:easy_manager/models/product.dart';
import 'package:easy_manager/screens/product/crud_product_screen.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.value,
      required this.listOptions})
      : super(key: key);

  final String title;
  final IconData icon;
  final String value;
  final Widget listOptions;

  @override
  Widget build(BuildContext context) {
    MagicMask mask = MagicMask.buildMask('R!\$! 9+,99');
    return Container(
      decoration: ShapeDecoration(shadows: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(
            3.0,
            4.0,
          ),
        )
      ], color: Colors.white, shape: Border.all()),
      child: ListTile(
          trailing: listOptions,
          leading: Icon(icon, color: Colors.black),
          title: Text(title,
              style: const TextStyle(
                  fontFamily: 'JosefinsSans', fontWeight: FontWeight.bold)),
          subtitle: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: value.length.toDouble()),
            child: Text(
              ' ${mask.getMaskedString(value)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
