import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

typedef FutureCallback = Future Function();

class CustomAppBar extends StatelessWidget implements PreferredSize {
  @override
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.callback,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final FutureCallback callback;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonRoundWithShadow(
              size: 45,
              borderColor: woodSmoke,
              color: white,
              callback: callback,
              shadowColor: woodSmoke,
              iconPath: 'lib/assets/svg/arrow_back.svg'),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: woodSmoke,
                  fontSize: 25,
                  fontFamily: 'JosefinsSans',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
