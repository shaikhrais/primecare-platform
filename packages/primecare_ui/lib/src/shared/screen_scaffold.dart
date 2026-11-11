import 'package:flutter/material.dart';
import '../theme/prime_theme.dart';
import '../components/prime_text.dart';

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
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        foregroundColor: theme.colors.onSurface,
        title: PrimeText(title, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: theme.typography.bodyMedium.copyWith(
          color: theme.colors.onSurface,
          fontSize: theme.scaleFont(17),
          fontWeight: FontWeight.bold,
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
