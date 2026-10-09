import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceIssueScreenState extends DashboardState<ServiceIssueScreenState> {
  ServiceIssueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ServiceIssueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ServiceIssueScreenState(isLoading: isLoading, error: error, data: data);
}

class ServiceIssueScreenController
    extends BaseDashboardController<ServiceIssueScreenState> {
  ServiceIssueScreenController(Ref ref)
    : super(
        ref,
        initialState: ServiceIssueScreenState(isLoading: true, data: {}),
        endpoint: '/management/service-issue',
      );
}

final service_issueControllerProvider =
    StateNotifierProvider<
      ServiceIssueScreenController,
      ServiceIssueScreenState
    >((ref) {
      return ServiceIssueScreenController(ref);
    });
