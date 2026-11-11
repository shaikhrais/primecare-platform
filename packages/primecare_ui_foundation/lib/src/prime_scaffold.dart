import 'package:flutter/material.dart';

/// Shared Material page-frame delegate.
///
/// Only the reviewed constructor surface is exposed. Material continues to own
/// inherited defaults, keyboard insets, drawers, focus, semantics and state.
class PrimeScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;

  const PrimeScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        endDrawer: endDrawer,
        backgroundColor: backgroundColor,
      );
}
