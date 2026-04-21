// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/theme/01_I_design_system.dart';

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
  final String? title;

  const PrimeCareScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.safeArea = true,
    this.floatingActionButtonLocation,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ds = PrimeCareDesignSystem.of(context);
    return Scaffold(
      backgroundColor: backgroundColor ?? PrimeCareDesignSystem.surfaceElevated,
      appBar: appBar ?? (title != null ? AppBar(
        title: Text(title!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: ds.typography.headingSmall.copyWith(
          color: ds.colors.textPrimary,
        ),
      ) : null),
      body: safeArea ? SafeArea(child: body) : body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
