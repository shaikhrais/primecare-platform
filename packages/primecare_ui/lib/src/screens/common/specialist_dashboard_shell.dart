import 'package:primecare_runtime/src/localization/live_screen_text.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../components/prime_status.dart';

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

  /// Presentation only: no request or retry is implied without a bound API.
  static Widget unavailable(String key) => Builder(
    builder: (context) => Center(
      key: ValueKey(key),
      child: Semantics(
        liveRegion: true,
        child: PrimeStatusText(
          liveScreenText(
            context,
            'workspace',
            Localizations.localeOf(context).languageCode,
            'unconnected',
            'workspace.unconnected'.tr(),
          ),
          tone: PrimeStatusTone.muted,
        ),
      ),
    ),
  );

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
