import 'package:flutter/material.dart';

class PrimeCareScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? color;
  final String? title;

  const PrimeCareScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? computedAppBar = appBar;
    if (computedAppBar == null && title != null) {
      computedAppBar = AppBar(title: Text(title!));
    }

    return Scaffold(backgroundColor: color, appBar: computedAppBar, body: body);
  }
}
