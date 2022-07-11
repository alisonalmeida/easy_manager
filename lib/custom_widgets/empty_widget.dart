import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(),
                boxShadow: const [
                  BoxShadow(offset: Offset(3, 2), color: Colors.black)
                ]),
            child: const Text(
              'Vazio',
              style: TextStyle(fontSize: 40),
            )));
  }
}
