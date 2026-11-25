// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE A wrapper widget that allows the entire application tree to be destroyed and recreated with ...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

/// A wrapper widget that allows the entire application tree to be
/// destroyed and recreated with a new state.
class RestartWrapper extends StatefulWidget {
  final Widget child;

  const RestartWrapper({super.key, required this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWrapperState>()?.restartApp();
  }

  @override
  State<RestartWrapper> createState() => _RestartWrapperState();
}

class _RestartWrapperState extends State<RestartWrapper> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
