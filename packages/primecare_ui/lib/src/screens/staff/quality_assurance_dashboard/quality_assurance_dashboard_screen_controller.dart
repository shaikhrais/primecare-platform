import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceDashboardScreenState
    extends DashboardState<QualityAssuranceDashboardScreenState> {
  QualityAssuranceDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QualityAssuranceDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QualityAssuranceDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class QualityAssuranceDashboardScreenController
    extends BaseDashboardController<QualityAssuranceDashboardScreenState> {
  QualityAssuranceDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: QualityAssuranceDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/quality-assurance-dashboard',
      );
}

final quality_assurance_dashboardControllerProvider =
    StateNotifierProvider<
      QualityAssuranceDashboardScreenController,
      QualityAssuranceDashboardScreenState
    >((ref) {
      return QualityAssuranceDashboardScreenController(ref);
    });
