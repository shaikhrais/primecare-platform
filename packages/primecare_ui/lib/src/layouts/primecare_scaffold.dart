import 'package:flutter/material.dart';
import '../theme/theme_extension.dart';

/// The Universal Application Shell.
/// Prevents local layout deviations by strictly enforcing SafeArea and Dark Mode surface boundaries
/// independently of individual developer configurations globally.
class PrimeCareScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool safeArea;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const PrimeCareScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeArea = true,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.pTheme.surfaceElevated,
      appBar: appBar,
      body: safeArea ? SafeArea(child: body) : body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
