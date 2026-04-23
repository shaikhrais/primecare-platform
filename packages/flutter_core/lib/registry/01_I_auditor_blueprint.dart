// Layer: 01_INFRASTRUCTURE
import 'intents/01_I_app_screen_intent.dart';

/// Represents a programmatic component requirement for a screen.
/// Part of the "Auditor's Blueprint" initiative.
class BlueprintComponent {
  final String label;
  final String intent;
  final String importance; // 'critical', 'high', 'medium', 'low'

  const BlueprintComponent({
    required this.label,
    required this.intent,
    this.importance = 'high',
  });
}

/// The programmatic blueprint for a specific screen route.
/// This defines exactly what SHOULD be on the screen according to the Auditor.
class AuditorBlueprint {
  final String route;
  final String description;
  final String reasoning;
  final List<BlueprintComponent> requiredComponents;

  const AuditorBlueprint({
    required this.route,
    required this.description,
    required this.reasoning,
    required this.requiredComponents,
  });

  /// Compares this blueprint with the actual component labels from an [AppScreenIntent].
  BlueprintCompliance audit(List<String> actualLabels) {
    final missing = <String>[];
    final criticalMissing = <String>[];

    for (final req in requiredComponents) {
      if (!actualLabels.contains(req.label)) {
        missing.add(req.label);
        if (req.importance == 'critical') {
          criticalMissing.add(req.label);
        }
      }
    }

    return BlueprintCompliance(
      route: route,
      missingLabels: missing,
      criticalMismatches: criticalMissing,
      isCompliant: criticalMissing.isEmpty,
    );
  }
}

/// The result of a blueprint compliance check.
class BlueprintCompliance {
  final String route;
  final List<String> missingLabels;
  final List<String> criticalMismatches;
  final bool isCompliant;

  BlueprintCompliance({
    required this.route,
    required this.missingLabels,
    required this.criticalMismatches,
    required this.isCompliant,
  });

  @override
  String toString() {
    if (isCompliant && missingLabels.isEmpty) {
      return '[$route] Full Compliance (Blueprint Matched)';
    }
    if (isCompliant) {
      return '[$route] Partial Compliance. Missing: ${missingLabels.join(", ")}';
    }
    return '[$route] CRITICAL FAILURE. Missing: ${criticalMismatches.join(", ")}';
  }
}

/// Registry for all programmatic Auditor Blueprints.
class BlueprintRegistry {
  static final Map<String, AuditorBlueprint> _blueprints = {};

  static void register(AuditorBlueprint blueprint) {
    _blueprints[blueprint.route] = blueprint;
  }

  static AuditorBlueprint? getBlueprint(String route) {
    return _blueprints[route];
  }

  static List<AuditorBlueprint> getAll() => _blueprints.values.toList();
}
