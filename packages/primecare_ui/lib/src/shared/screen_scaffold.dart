import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final String screenCode;
  final String title;
  final Widget child;

  const ScreenScaffold({
    super.key,
    required this.screenCode,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
