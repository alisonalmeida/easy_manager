import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

customModalBottomSheet(BuildContext context, String title, Widget items) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
                color: white,
                border: Border.all(),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 2,
                  width: 50,
                  color: Colors.grey,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: woodSmoke,
                      fontSize: 25,
                      fontFamily: 'JosefinsSans',
                      fontWeight: FontWeight.w700),
                ),
                items
              ],
            ));
      });
}
