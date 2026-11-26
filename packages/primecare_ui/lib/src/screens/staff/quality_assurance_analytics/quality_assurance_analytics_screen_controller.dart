import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceAnalyticsScreenState
    extends DashboardState<QualityAssuranceAnalyticsScreenState> {
  QualityAssuranceAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QualityAssuranceAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QualityAssuranceAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class QualityAssuranceAnalyticsScreenController
    extends BaseDashboardController<QualityAssuranceAnalyticsScreenState> {
  QualityAssuranceAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: QualityAssuranceAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/quality-assurance-analytics',
      );
}

final quality_assurance_analyticsControllerProvider =
    StateNotifierProvider<
      QualityAssuranceAnalyticsScreenController,
      QualityAssuranceAnalyticsScreenState
    >((ref) {
      return QualityAssuranceAnalyticsScreenController(ref);
    });
