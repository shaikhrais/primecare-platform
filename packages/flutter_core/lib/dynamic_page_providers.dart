// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

final dynamicPageProvider =
    FutureProvider.family<Result<List<dynamic>>, String>((
      ref,
      endpointKey,
    ) async {
      final apiClient = ref.watch(apiClientProvider);
      final telemetry = ref.read<ExecutionGateService>(executionGateProvider);

      return Result.guardFuture<List<dynamic>>(
        () async {
          final path =
              ApiConfig.endpoints[endpointKey] ??
              '/v1/primecare/office/$endpointKey';

          final parts = path.split('/').where((p) => p.isNotEmpty).toList();
          final dataKey = parts.last.replaceAll('-', '_');

          final response = await apiClient.get(path);
          final json = response.data;

          List<dynamic> result;
          if (json is Map && json.containsKey(dataKey)) {
            result = json[dataKey] as List<dynamic>;
          } else {
            result = [];
          }

          telemetry.passGate(
            ExecutionGateCategory.domainApi,
            'Dynamic page hydrated: $endpointKey (${result.length} items)',
            metadata: {'endpointKey': endpointKey, 'path': path},
          );
          return result;
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.domainApi,
            'Dynamic page hydration failed: $endpointKey',
            error: e,
            stackTrace: st,
            metadata: {'endpointKey': endpointKey},
          );
          return <dynamic>[];
        },
      );
    });
