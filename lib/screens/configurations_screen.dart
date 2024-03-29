import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Configurations extends ConsumerWidget {
  const Configurations({Key? key}) : super(key: key);
  static String name = 'Configurações';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CustomAppBar(
          callback: () async => Navigator.pop(context),
          title: Configurations.name,
          backgroundColor: selago,
          svgImage: kpathSvgSettings,
          heroAnimation: Configurations.name,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {},
                child: const Center(child: Text('teste')))
          ],
        ));
  }
}
