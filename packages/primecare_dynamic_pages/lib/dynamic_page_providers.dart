// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/src/models/result.dart';
import 'package:primecare_execution_gate/src/resilience/execution_gate_service.dart';

Future<Result<List<dynamic>>> loadDynamicPage(
      Ref ref,
      String endpointKey,
      String? Function(String endpointKey) resolveEndpoint,
      Future<dynamic> Function(String path) read,
    ) async {
      final telemetry = ref.read<ExecutionGateService>(executionGateProvider);

      return Result.guardFuture<List<dynamic>>(
        () async {
          final path =
              resolveEndpoint(endpointKey) ??
              '/v1/primecare/office/$endpointKey';

          final parts = path.split('/').where((p) => p.isNotEmpty).toList();
          final dataKey = parts.last.replaceAll('-', '_');

          final json = await read(path);

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
    }
