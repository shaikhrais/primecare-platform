// Governance - Category: widget | Purpose: Core LocalizationScaffold widget that wraps and validates rendering components.
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart' as el;

/// A system-wide localization enforcer.
/// Guarantees that the wrapped [child] is never rendered without an active
/// and initialized EasyLocalization environment.
class LocalizationScaffold extends StatelessWidget {
  final Widget child;
  final List<String> translationKeys;

  const LocalizationScaffold({
    super.key,
    required this.child,
    this.translationKeys = const [],
  });

  @override
  Widget build(BuildContext context) {
    final hasLocalization = EasyLocalization.of(context) != null;
    
    // Assert strictly to fail test cases and alert developers during debug
    assert(
      hasLocalization,
      'Assertion Failed: You cannot render any component/screen without a LocalizationScaffold parent in the widget tree. Ensure EasyLocalization is initialized.',
    );

    if (!hasLocalization) {
      return const Material(
        child: Center(
          child: Text(
            'Missing Localization Context. Component cannot be rendered.',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // Verify key existence in debug mode
    assert(() {
      for (final key in translationKeys) {
        final exists = _keyExists(context, key);
        assert(
          exists,
          'Assertion Failed: Translation key "$key" is not registered in the active translation file.',
        );
      }
      return true;
    }());

    return child;
  }

  bool _keyExists(BuildContext context, String keyPath) {
    final loc = el.Localization.of(context);
    return loc != null && loc.exists(keyPath);
  }
}
