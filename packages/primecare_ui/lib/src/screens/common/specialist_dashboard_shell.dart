import 'package:flutter/material.dart';

/// Shared display shell; the caller owns dashboard state, actions and routing.
class PrimeSpecialistDashboardShell extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;

  const PrimeSpecialistDashboardShell({
    super.key,
    required this.title,
    required this.actions,
    required this.body,
  });

  static Widget syncAction(VoidCallback onPressed, {String? semanticLabel}) {
    final button = IconButton(
      icon: const Icon(Icons.sync),
      onPressed: onPressed,
    );
    if (semanticLabel == null) return button;
    return Semantics(label: semanticLabel, button: true, child: button);
  }

  static Widget loading(String key, {String? semanticLabel}) {
    final Widget indicator = semanticLabel == null
        ? CircularProgressIndicator()
        : Semantics(label: semanticLabel, child: CircularProgressIndicator());
    return Center(key: ValueKey(key), child: indicator);
  }

  static Widget error(Object? error) => Center(child: Text('Error: $error'));

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'screen-root',
    container: true,
    child: Scaffold(
      appBar: AppBar(
        title: Semantics(label: 'page-title', child: Text(title)),
        actions: actions,
      ),
      body: body,
    ),
  );
}
