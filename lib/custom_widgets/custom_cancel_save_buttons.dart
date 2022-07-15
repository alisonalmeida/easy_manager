import 'package:easy_manager/custom_widgets/custom_button_cancel.dart';
import 'package:easy_manager/custom_widgets/custom_button_confirm.dart';
import 'package:flutter/material.dart';

class CustomCancelSaveButtons extends StatelessWidget {
  const CustomCancelSaveButtons(
      {Key? key, required this.saveCallback, required this.cancelCallback})
      : super(key: key);

  final VoidCallback saveCallback;
  final VoidCallback cancelCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 4,
            child: CustomButtonCancel(text: 'Cancelar', onTap: cancelCallback)),
        const Spacer(flex: 1),
        Expanded(
            flex: 4,
            child: CustomButtonConfirm(text: 'Salvar', onTap: saveCallback)),
      ],
    );
  }
}
