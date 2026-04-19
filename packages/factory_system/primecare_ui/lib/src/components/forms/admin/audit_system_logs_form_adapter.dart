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
    String? searchTerm,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await Result.guardFuture(() async {
      final client = ref.read(apiClientProvider);

      final queryParams = {
        if (action != null && action.isNotEmpty) 'action': action,
        if (resourceType != null && resourceType.isNotEmpty)
          'resourceType': resourceType,
        if (actorUserId != null && actorUserId.isNotEmpty)
          'actorUserId': actorUserId,
        if (searchTerm != null && searchTerm.isNotEmpty) 'q': searchTerm,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };

      final response = await client.get(
        '/v1/audit/logs',
        queryParameters: queryParams,
      );

      if (response != null && response['success'] == true) {
        return response['data'];
      }
      return false;
    });

    if (result.isSuccess) {
      final data = result.data;
      state = state.copyWith(
        isLoading: false,
        logs: data['logs'] ?? [],
        total: data['pagination']?['total'] ?? 0,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.error,
      );
    }
  }
}

final auditSystemLogsFormAdapterProvider =
    NotifierProvider<AuditSystemLogsFormAdapter, AuditSystemLogsFormViewModel>(
      () => AuditSystemLogsFormAdapter(),
    );
