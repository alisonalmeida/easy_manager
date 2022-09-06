import 'package:easy_manager/consts.dart';
import 'package:easy_manager/custom_widgets/custom_app_bar.dart';
import 'package:easy_manager/helper/world_time.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class Configurations extends StatefulWidget {
  const Configurations({Key? key}) : super(key: key);
  static String name = 'Configurações';

  @override
  State<Configurations> createState() => _ConfigurationsState();
}

class _ConfigurationsState extends State<Configurations> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () async {
                  var v = await WorldTime.getDateFormatted();
                  print(v);
                },
                child: Center(child: Text('teste')))
          ],
        ));
  }
}
