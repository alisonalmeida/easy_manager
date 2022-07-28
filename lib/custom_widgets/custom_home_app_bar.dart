import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSize {
  @override
  const CustomHomeAppBar(
      {Key? key,
      required this.title,
      required this.callback,
      required this.controller,
      required this.lottie})
      : super(key: key);

  final String title;
  final VoidCallback callback;
  final AnimationController controller;
  final String lottie;
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AppBar(
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: Lottie.asset(
                    controller: controller, lottie, repeat: false)),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: woodSmoke,
                    fontSize: 35,
                    fontFamily: 'JosefinsSans',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
