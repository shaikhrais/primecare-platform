import 'package:flutter/material.dart';

/// Shared basic page shell. Material resolves its active theme, navigation,
/// keyboard insets and inherited title styles exactly as for Scaffold/AppBar.
/// Complex shells continue to use their dedicated shared layout.
class PrimePageScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? body;

  const PrimePageScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: title),
    body: body,
  );
}
