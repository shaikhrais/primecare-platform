import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalAnalyticsScreenState
    extends DashboardState<ClinicalAnalyticsScreenState> {
  ClinicalAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalAnalyticsScreenController
    extends BaseDashboardController<ClinicalAnalyticsScreenState> {
  ClinicalAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/analytics',
      );
}

final clinical_analyticsControllerProvider =
    StateNotifierProvider<
      ClinicalAnalyticsScreenController,
      ClinicalAnalyticsScreenState
    >((ref) {
      return ClinicalAnalyticsScreenController(ref);
    });
