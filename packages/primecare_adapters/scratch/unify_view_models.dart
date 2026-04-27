import 'dart:io';

void main() {
  final directory = Directory('lib/src/models/roles');
  if (!directory.existsSync()) {
    print('Error: lib/src/models/roles not found.');
    return;
  }

  final files = directory.listSync().whereType<File>().where(
    (f) => f.path.endsWith('.dart'),
  );

  int patchedCount = 0;

  for (final file in files) {
    file.readAsStringSync(); // read to ensure file exists and is readable, though content is generated below
    final fileName = file.uri.pathSegments.last;
    final className = fileName
        .split('_')
        .map((s) => s[0].toUpperCase() + s.substring(1))
        .join('')
        .replaceAll('.dart', '');

    final newContent =
        """
import '../dashboard_view_model.dart';
import '../core/dashboard_models.dart';
import '../core/intelligence_insight.dart';
import '../core/ui_blueprint.dart';

class $className extends PrimeCareDashboardViewModel {
  $className({
    required super.metrics,
    required super.insights,
    super.blueprints,
  });

  factory $className.fromDashboardMetrics(DashboardMetrics metrics) {
    return $className(
      metrics: metrics,
      insights: [],
    );
  }

  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>? ?? {}),
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      blueprints: (json['blueprints'] as List<dynamic>?)
              ?.map((e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory $className.empty() {
    return $className(
      metrics: DashboardMetrics.empty(),
      insights: [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'blueprints': blueprints.map((b) => b.toJson()).toList(),
      };
}
""";

    file.writeAsStringSync(newContent);
    print('Patched $className ($fileName)');
    patchedCount++;
  }

  print(
    '\nSuccessfully unified $patchedCount role ViewModels in primecare_adapters.',
  );
}
