import 'package:flutter/material.dart';

enum PlatformSubsystem { metrics, auraAI }

class GovernedWidget extends StatelessWidget {
  final PlatformSubsystem subsystem;
  final Widget child;

  const GovernedWidget({Key? key, required this.subsystem, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
