import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadAnalyticsScreenState
    extends DashboardState<LeadAnalyticsScreenState> {
  LeadAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LeadAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      LeadAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class LeadAnalyticsScreenController
    extends BaseDashboardController<LeadAnalyticsScreenState> {
  LeadAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: LeadAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/management/lead-analytics',
      );
}

final lead_analyticsControllerProvider =
    StateNotifierProvider<
      LeadAnalyticsScreenController,
      LeadAnalyticsScreenState
    >((ref) {
      return LeadAnalyticsScreenController(ref);
    });
