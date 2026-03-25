import 'package:flutter/material.dart';

class UniversalHomeScreen extends StatelessWidget {
  final String rolePrefix;
  const UniversalHomeScreen({super.key, required this.rolePrefix});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Home Screen')));
}
