import os
import glob
import re

files_to_refactor = [
    "apps/primecare_clinic/lib/features/clinic_operations/clinic_operations_controller.dart",
    "apps/primecare_marketing/lib/features/marketing_operations/marketing_operations_controller.dart",
    "apps/primecare_support/lib/features/support_operations/support_operations_controller.dart",
    "apps/primecare_client/lib/features/client_operations/client_operations_controller.dart",
    "apps/primecare_business_development/lib/features/bizdev_operations/bizdev_operations_controller.dart"
]

def refactor_controller(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    # Determine the model name, route, etc
    model_name_match = re.search(r'FutureProvider<Result<([^>]+)>>', content)
    model_name = model_name_match.group(1) if model_name_match else None
    
    route_match = re.search(r"const route = '([^']+)';", content)
    route_val = route_match.group(1) if route_match else None

    cache_match = re.search(r"const cacheKey = '([^']+)';", content)
    cache_val = cache_match.group(1) if cache_match else None

    controller_name_match = re.search(r'final (\w+) =', content)
    controller_name = controller_name_match.group(1) if controller_name_match else None

    if not model_name or not route_val or not cache_val or not controller_name:
        print(f"Skipping {filepath} due to regex match failure")
        return

    new_content = f"""import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import '{model_name_match.group(1).replace('Model', '').lower()}_model.dart';

final {controller_name} =
    FutureProvider<Result<{model_name}>>((ref) async {{
  const route = '{route_val}';
  const cacheKey = '{cache_val}';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  try {{
    final response = await ref.read(apiClientProvider).get(
      '/dashboard-metrics',
      query: {{'role': route}},
    );
    final data = response.data as Map<String, dynamic>;

    final metricsRaw = data['metrics'] ?? data['kpis'] ?? <dynamic>[];
    final insightsRaw = data['insights'] ?? <dynamic>[];
    final timelineRaw = data['timeline'] ?? data['recentActivity'] ?? <dynamic>[];
    final trendsRaw = data['trends'] ?? data['charts'] ?? <dynamic>[];
    final isFallback = data['isOfflineFallback'] ?? false;

    final intlModel = IntelligenceDashboardModel.fromJson({{
      'metrics': metricsRaw,
      'insights': insightsRaw,
      'timeline': timelineRaw,
      'trends': trendsRaw,
      'isOfflineFallback': isFallback,
      'lastUpdated': DateTime.now().toIso8601String(),
    }});

    final dashboardMetrics = DashboardMetrics(
      kpis: intlModel.metrics,
      recentActivity: intlModel.timeline,
      charts: intlModel.trends,
      insights: intlModel.insights,
      isOfflineFallback: intlModel.isFromCache,
    );

    final mappedInsights = intlModel.insights
        .map((e) => IntelligenceInsight.fromDashboardInsight(e))
        .toList();

    final model = {model_name}(
      metrics: dashboardMetrics,
      insights: mappedInsights,
    );

    unawaited(resilience.saveSnapshot(cacheKey, model.toJson()));
    return Success(model);
  }} catch (e) {{
    return _handleFallback(resilience, cacheKey, telemetry, e);
  }}
}});

Result<{model_name}> _handleFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
  dynamic error,
) {{
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {{
    return Success({model_name}.fromJson(snapshot));
  }}
  return Success({model_name}.empty(isOfflineFallback: true));
}}
"""

    # For the import, the generated import might be wrong if it uses .lower() direct map.
    # We can just extract all imports from original file.
    imports = re.findall(r"import '([^']+)';", content)
    import_statements = "\n".join([f"import '{imp}';" for imp in imports])
    
    new_content = new_content.replace(f"import '{model_name_match.group(1).replace('Model', '').lower()}_model.dart';", "")
    new_content = import_statements + "\n\n" + new_content.replace("import 'dart:async';\nimport 'package:primecare_ui/primecare_ui.dart';\n\n", "")

    with open(filepath, 'w') as f:
        f.write(new_content)
    print(f"Refactored {filepath}")

for fp in files_to_refactor:
    refactor_controller(fp)
