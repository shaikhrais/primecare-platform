import 'package:flutter/material.dart';

class PrimeCareAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final List<Widget>? actions;

  const PrimeCareAppBar({Key? key, required this.title, this.actions})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title is String ? Text(title as String) : title as Widget?,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
