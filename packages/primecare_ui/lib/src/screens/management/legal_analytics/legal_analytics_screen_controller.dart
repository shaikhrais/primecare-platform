import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalAnalyticsScreenState
    extends DashboardState<LegalAnalyticsScreenState> {
  LegalAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LegalAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      LegalAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class LegalAnalyticsScreenController
    extends BaseDashboardController<LegalAnalyticsScreenState> {
  LegalAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: LegalAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/legal-analytics',
      );
}

final legal_analyticsControllerProvider =
    StateNotifierProvider<
      LegalAnalyticsScreenController,
      LegalAnalyticsScreenState
    >((ref) {
      return LegalAnalyticsScreenController(ref);
    });
