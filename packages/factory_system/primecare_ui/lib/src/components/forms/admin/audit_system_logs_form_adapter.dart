// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
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
        query: queryParams,
      );

      if (response.data != null && response.data['success'] == true) {
        return response.data['data'];
      }
      return false;
    });

    result.fold(
      (data) {
        state = state.copyWith(
          isLoading: false,
          logs: data['logs'] ?? [],
          total: data['pagination']?['total'] ?? 0,
        );
      },
      (error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }
}

final auditSystemLogsFormAdapterProvider =
    NotifierProvider<AuditSystemLogsFormAdapter, AuditSystemLogsFormViewModel>(
      () => AuditSystemLogsFormAdapter(),
    );
