import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';

class AuditSystemLogsFormViewModel {
  final bool isLoading;
  final List<dynamic> logs;
  final int total;
  final String? error;

  AuditSystemLogsFormViewModel({
    this.isLoading = false,
    this.logs = const [],
    this.total = 0,
    this.error,
  });

  AuditSystemLogsFormViewModel copyWith({
    bool? isLoading,
    List<dynamic>? logs,
    int? total,
    String? error,
  }) {
    return AuditSystemLogsFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      logs: logs ?? this.logs,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }
}

class AuditSystemLogsFormAdapter
    extends Notifier<AuditSystemLogsFormViewModel> {
  @override
  AuditSystemLogsFormViewModel build() {
    return AuditSystemLogsFormViewModel();
  }

  Future<void> loadLogs({
    String? action,
    String? resourceType,
    String? actorUserId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final client = ref.read(apiClientProvider);
      
      final queryParams = {
        if (action != null) 'action': action,
        if (resourceType != null) 'resourceType': resourceType,
        if (actorUserId != null) 'actorUserId': actorUserId,
      };

      final response = await client.get(
        '/v1/audit/logs',
        queryParameters: queryParams,
      );

      if (response != null && response['success'] == true) {
        final data = response['data'];
        state = state.copyWith(
          isLoading: false,
          logs: data['logs'] ?? [],
          total: data['pagination']?['total'] ?? 0,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response?['error'] ?? 'Failed to load logs',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final auditSystemLogsFormAdapterProvider =
    NotifierProvider<AuditSystemLogsFormAdapter, AuditSystemLogsFormViewModel>(
      () => AuditSystemLogsFormAdapter(),
    );
