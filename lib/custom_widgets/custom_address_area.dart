import 'package:easy_manager/core/upper_case_text_formatter.dart';
import 'package:easy_manager/custom_widgets/button_round_with_shadow.dart';
import 'package:easy_manager/custom_widgets/custom_text_field.dart';
import 'package:easy_manager/utils/colors.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import '../core/filter_text.dart';

class CustomAddressArea extends StatelessWidget {
  const CustomAddressArea(
      {Key? key,
      required this.cepController,
      required this.callback,
      required this.ufController,
      required this.cityController,
      required this.streetController,
      required this.districtController,
      required this.numberController,
      required this.complementController,
      required this.focusNode})
      : super(key: key);
  final VoidCallback callback;
  final TextEditingController cepController;
  final TextEditingController ufController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController districtController;
  final TextEditingController numberController;
  final TextEditingController complementController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 3)),
      child: Column(
        children: [
          const Text('Endereço'),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      textInputType: TextInputType.number,
                      textInputFormatterList: [
                        TextInputMask(mask: '99999-999')
                      ],
                      controller: cepController,
                      name: 'CEP',
                      textInputAction: TextInputAction.done,
                      callback: callback)),
              ButtonRoundWithShadow(
                  borderColor: woodSmoke,
                  shadowColor: woodSmoke,
                  color: white,
                  iconPath: 'lib/assets/svg/refresh.svg',
                  size: 50,
                  callback: callback),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: black),
                      fillColor: white,
                      filled: true,
                      focusColor: white,
                      hoverColor: white,
                      hintText: 'UF',
                      labelText: 'UF',
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: black),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 4, color: black),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      filterOnlyChars
                    ],
                    maxLength: 2,
                    controller: ufController,
                    textInputAction: TextInputAction.next),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 8,
                child: CustomTextField(
                    textInputFormatterList: [UpperCaseTextFormatter()],
                    controller: cityController,
                    name: 'Cidade',
                    textInputAction: TextInputAction.next),
              )
            ],
          ),
          const SizedBox(height: 5),
          CustomTextField(
              textInputFormatterList: [UpperCaseTextFormatter()],
              controller: streetController,
              name: 'Rua',
              textInputAction: TextInputAction.next),
          const SizedBox(height: 5),
          CustomTextField(
              focusNode: focusNode,
              textInputFormatterList: [UpperCaseTextFormatter()],
              controller: numberController,
              name: 'Número',
              textInputAction: TextInputAction.next),
          const SizedBox(height: 5),
          CustomTextField(
              textInputFormatterList: [UpperCaseTextFormatter()],
              controller: districtController,
              name: 'Bairro',
              textInputAction: TextInputAction.next),
          const SizedBox(height: 5),
          CustomTextField(
              textInputFormatterList: [UpperCaseTextFormatter()],
              controller: complementController,
              name: 'Complemento',
              textInputAction: TextInputAction.next),
        ],
      ),
    );
  }
}
