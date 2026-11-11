import 'package:flutter/material.dart';

/// Shared workspace shell using the active background and surface tokens.
/// Keeps the scaffold's key separate from the shared widget's identity.
class PrimeWorkspaceScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final Color backgroundColor;
  final Color headerColor;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? body;

  const PrimeWorkspaceScaffold({super.key, this.scaffoldKey,
    required this.backgroundColor, required this.headerColor,
    required this.title, required this.actions, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: headerColor, elevation: 0,
        title: title, actions: actions),
      body: body,
    );
  }
}
