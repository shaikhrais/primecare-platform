import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

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
    return ArchitectureLayerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      componentsGoverned: json['componentsGoverned'] ?? 0,
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
    return C4Component(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      status: json['status'] ?? 'unknown',
      repoPath: json['repoPath'],
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
    return C4System(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      componentsCount: json['componentsCount'] ?? 0,
      components: componentsList.map((c) => C4Component.fromJson(c)).toList(),
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
    return C4Domain(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      systems: systemsList.map((s) => C4System.fromJson(s)).toList(),
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
    return MissingComponent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      screenName: json['screenName'] ?? '',
      route: json['route'] ?? '',
      justification: json['justification'] ?? '',
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
      dbLinkedLayers: layers.map((l) => ArchitectureLayerModel.fromJson(l)).toList(),
      c4Topology: topology.map((t) => C4Domain.fromJson(t)).toList(),
      flaggedFunctionsWithoutAPIs: layerStatus['flaggedFunctionsWithoutAPIs'] ?? 0,
      missingComponents: (layerStatus['missingComponents'] as List<dynamic>?)
              ?.map((m) => MissingComponent.fromJson(m))
              .toList() ??
          [],
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
    );
  }

  factory ArchitecturePlanningViewModel.assemble({bool isOffline = false}) {
    return ArchitecturePlanningViewModel(
      isOffline: isOffline,
      dbLinkedLayers: [],
      c4Topology: [],
      flaggedFunctionsWithoutAPIs: 0,
      missingComponents: [],
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}

// --- The Adapter ---
final architecturePlanningAdapterProvider =
    FutureProvider<Result<ArchitecturePlanningViewModel>>((ref) async {
  final telemetry = ref.read(executionGateProvider);
  final resilience = ref.read(resilienceServiceProvider);
  const cacheKey = 'architecture_planning_metrics';

  return Result.guardFuture<ArchitecturePlanningViewModel>(
    () async {
      return DataLogisticsHub.fetchAndAssemble<ArchitecturePlanningViewModel>(
        fetchCall: () async {
          const edgeUrl =
              'https://primecare-verification-service.itpro-mohammed.workers.dev';
          const endpoint = '/v1/verifications/purpose-report';

          telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Fetching Architecture Planning Metrics: \$edgeUrl\$endpoint',
          );

          final edgeDio = Dio(
            BaseOptions(
              baseUrl: edgeUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

          final response = await edgeDio.get(endpoint);

          if (response.statusCode == 200) {
            telemetry.passGate(
              ExecutionGateCategory.metricsLayer,
              'Architecture Planning Hydrated successfully',
            );

            final metrics = response.data as Map<String, dynamic>;
            final viewModel = ArchitecturePlanningViewModel.fromJson(metrics);

            unawaited(resilience.saveSnapshot(cacheKey, metrics));

            return viewModel;
          } else {
            telemetry.failGate(
              ExecutionGateCategory.metricsLayer,
              'Architecture Metrics Error: \${response.statusCode}',
              metadata: {'status': response.statusCode},
            );
            return ArchitecturePlanningViewModel.assemble(isOffline: true);
          }
        },
        fallbackBuilder: () {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Architecture Validation Fallback Triggered',
          );
          return ArchitecturePlanningViewModel.assemble(isOffline: true);
        },
      );
    },
    onError: (e, st) {
      telemetry.failGate(
        ExecutionGateCategory.metricsLayer,
        'Deterministic Failure in Architecture Planning Adapter',
        error: e,
        stackTrace: st,
      );

      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        telemetry.passGate(
          ExecutionGateCategory.resource,
          'Resilience: Restoring Architecture Planning from cache',
        );
        return ArchitecturePlanningViewModel.fromJson(snapshot as Map<String, dynamic>, isOffline: true);
      }
      return ArchitecturePlanningViewModel.assemble(isOffline: true);
    },
  );
});
