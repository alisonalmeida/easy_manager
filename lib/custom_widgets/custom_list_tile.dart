import 'package:easy_manager/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.deleteCallback,
      required this.editCallback,
      required this.title,
      required this.icon,
      required this.subtitle})
      : super(key: key);

  final VoidCallback editCallback;
  final VoidCallback deleteCallback;
  final String title;
  final IconData icon;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(shadows: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(
            3.0,
            4.0,
          ),
        )
      ], color: Colors.white, shape: Border.all()),
      child: ListTile(
        trailing: Wrap(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.mode_edit_outline_outlined,
                  color: black,
                ),
                onPressed: editCallback),
            const VerticalDivider(),
            IconButton(
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  color: black,
                ),
                onPressed: deleteCallback),
          ],
        ),
        leading: Icon(icon, color: Colors.black),
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'JosefinsSans', fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
