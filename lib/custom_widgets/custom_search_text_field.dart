import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key,
       this.focusNode,
      required this.searchController,
      required this.clearField,
      });
  FocusNode? focusNode;
  TextEditingController searchController;
  VoidCallback clearField;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        
        focusNode: focusNode,
        controller: searchController,
        decoration: InputDecoration(
          fillColor: white,
          hintText: 'Pesquisar',
          prefixIcon: const Icon(
            Icons.search,
            color: black,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: clearField,
            icon: const Icon(
              Icons.cancel,
              color: black,
            ),
          ),
        ),
      ),
    );
  }
}
