// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef FutureCallback = Future Function();

class CustomAppBar extends StatelessWidget implements PreferredSize {
  @override
  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.backgroundColor,
      required this.callback,
      required this.svgImage,
      required this.heroAnimation})
      : super(key: key);

  final String title;
  final Color backgroundColor;
  final FutureCallback callback;
  final String svgImage;
  final String heroAnimation;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 10,
      titleSpacing: 20,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: null,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonRoundWithShadow(
                  size: 45,
                  borderColor: woodSmoke,
                  color: white,
                  callback: callback,
                  shadowColor: woodSmoke,
                  iconPath: 'lib/assets/svg/arrow_back.svg'),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: woodSmoke,
                      fontSize: 20,
                      fontFamily: 'JosefinsSans',
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child:
                    Hero(tag: heroAnimation, child: SvgPicture.asset(svgImage)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
