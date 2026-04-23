// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

// --- View Model Definitions for the Adapter ---
class ArchitectureLayerModel {
  final String id;
  final String name;
  final int componentsGoverned;

  ArchitectureLayerModel({
    required this.id,
    required this.name,
    required this.componentsGoverned,
  });

  factory ArchitectureLayerModel.fromJson(Map<String, dynamic> json) {
    return ArchitectureLayerModel(id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      componentsGoverned: (json['componentsGoverned'] as num?)?.toInt() ?? 0,
    );
  }
}

class C4Component {
  final String id;
  final String name;
  final String status;
  final String? repoPath;

  C4Component({
    required this.id,
    required this.name,
    required this.status,
    this.repoPath,
  });

  factory C4Component.fromJson(Map<String, dynamic> json) {
    return C4Component(id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      status: (json['status'] as String?) ?? 'unknown',
      repoPath: (json['repoPath'] as String?),
    );
  }
}

class C4System {
  final String id;
  final String name;
  final int componentsCount;
  final List<C4Component> components;

  C4System({
    required this.id,
    required this.name,
    required this.componentsCount,
    required this.components,
  });

  factory C4System.fromJson(Map<String, dynamic> json) {
    final componentsList = json['components'] as List<dynamic>? ?? [];
    return C4System(id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      componentsCount: (json['componentsCount'] as num?)?.toInt() ?? 0,
      components: componentsList.map((c) => C4Component.fromJson(c as Map<String, dynamic>)).toList(),
    );
  }
}

class C4Domain {
  final String id;
  final String name;
  final String description;
  final List<C4System> systems;

  C4Domain({
    required this.id,
    required this.name,
    required this.description,
    required this.systems,
  });

  factory C4Domain.fromJson(Map<String, dynamic> json) {
    final systemsList = json['systems'] as List<dynamic>? ?? [];
    return C4Domain(id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      description: (json['description'] as String?) ?? '',
      systems: systemsList.map((s) => C4System.fromJson(s as Map<String, dynamic>)).toList(),
    );
  }
}

class MissingComponent {
  final String id;
  final String title;
  final String screenName;
  final String route;
  final String justification;

  MissingComponent({
    required this.id,
    required this.title,
    required this.screenName,
    required this.route,
    required this.justification,
  });

  factory MissingComponent.fromJson(Map<String, dynamic> json) {
    return MissingComponent(id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      screenName: (json['screenName'] as String?) ?? '',
      route: (json['route'] as String?) ?? '',
      justification: (json['justification'] as String?) ?? '',
    );
  }
}

class ArchitecturePlanningViewModel {
  final bool isOffline;
  final List<ArchitectureLayerModel> dbLinkedLayers;
  final List<C4Domain> c4Topology;
  final int flaggedFunctionsWithoutAPIs;
  final List<MissingComponent> missingComponents;
  final String timestamp;

  ArchitecturePlanningViewModel({
    required this.isOffline,
    required this.dbLinkedLayers,
    required this.c4Topology,
    required this.flaggedFunctionsWithoutAPIs,
    required this.missingComponents,
    required this.timestamp,
  });

  factory ArchitecturePlanningViewModel.fromJson(Map<String, dynamic> json, {bool isOffline = false}) {
    final layers = json['dbLinkedLayers'] as List<dynamic>? ?? [];
    final topology = json['c4Topology'] as List<dynamic>? ?? [];
    final layerStatus = json['layerStatus'] as Map<String, dynamic>? ?? {};

    return ArchitecturePlanningViewModel(
      isOffline: isOffline,
      dbLinkedLayers: layers.map((l) => ArchitectureLayerModel.fromJson(l as Map<String, dynamic>)).toList(),
      c4Topology: topology.map((t) => C4Domain.fromJson(t as Map<String, dynamic>)).toList(),
      flaggedFunctionsWithoutAPIs: (layerStatus['flaggedFunctionsWithoutAPIs'] as num?)?.toInt() ?? 0,
      missingComponents: (layerStatus['missingComponents'] as List<dynamic>?)
              ?.map((m) => MissingComponent.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      timestamp: (json['timestamp'] as String?) ?? DateTime.now().toIso8601String(),
    );
  }

  factory ArchitecturePlanningViewModel.empty({bool isOfflineFallback = false}) {
    return ArchitecturePlanningViewModel(
      isOffline: isOfflineFallback,
      dbLinkedLayers: [],
      c4Topology: [],
      flaggedFunctionsWithoutAPIs: 0,
      missingComponents: [],
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  DashboardMetrics get metrics => DashboardMetrics(
        kpis: [
          KpiMetric(
            title: 'Linked Layers',
            value: dbLinkedLayers.length.toString(),
            status: 'positive',
            trend: 'stable',
          ),
          KpiMetric(
            title: 'Flagged Functions',
            value: flaggedFunctionsWithoutAPIs.toString(),
            status: flaggedFunctionsWithoutAPIs > 0 ? 'warning' : 'positive',
            trend: flaggedFunctionsWithoutAPIs > 0 ? 'down' : 'stable',
          ),
          KpiMetric(
            title: 'Missing Screens',
            value: missingComponents.length.toString(),
            status: missingComponents.isNotEmpty ? 'critical' : 'positive',
            trend: missingComponents.isNotEmpty ? 'down' : 'stable',
          ),
        ],
        recentActivity: [],
        insights: [
          DashboardInsight(
            type: 'architecture_integrity',
            title: 'System Stability',
            description: flaggedFunctionsWithoutAPIs > 0 
              ? 'Warning: $flaggedFunctionsWithoutAPIs functions are missing API associations.'
              : 'Architecture integrity is within optimal parameters.',
            impact: flaggedFunctionsWithoutAPIs > 0 ? InsightImpact.caution : InsightImpact.positive,
          ),
        ],
      );
}

// --- The Adapter ---
final architecturePlanningAdapterProvider =
    FutureProvider<Result<ArchitecturePlanningViewModel>>((ref) async {
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
  const cacheKey = 'architecture_planning_metrics';

  // Watch the hardened infrastructure provider
  final result = await ref.watch(architecturePurposeProvider.future);

  return result.fold(
    (data) {
      final viewModel = ArchitecturePlanningViewModel.fromJson(data);
      // Persist LKG for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, data));
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'ArchitecturePlanning Metrics Logistics Fallback Triggered',
      );
      // Automatic Resilience: Revert to LKG if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(
          ArchitecturePlanningViewModel.fromJson(
            snapshot,
            isOffline: true,
          ),
        );
      }
      return Success(ArchitecturePlanningViewModel.empty(isOfflineFallback: true));
    },
  );
});

