import 'package:flutter/material.dart';

/// UI presentation parent. Domain rules belong in primecare_core.
abstract class BasePrimecareScreen extends StatelessWidget {
  const BasePrimecareScreen({super.key});
  String get title;
  Widget buildContent(BuildContext context);
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SafeArea(child: buildContent(context)),
  );
}
