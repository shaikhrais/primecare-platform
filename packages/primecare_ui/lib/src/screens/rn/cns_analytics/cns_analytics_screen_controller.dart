import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalNurseSpecialistAnalyticsScreenState
    extends DashboardState<ClinicalNurseSpecialistAnalyticsScreenState> {
  ClinicalNurseSpecialistAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalNurseSpecialistAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalNurseSpecialistAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalNurseSpecialistAnalyticsScreenController
    extends
        BaseDashboardController<ClinicalNurseSpecialistAnalyticsScreenState> {
  ClinicalNurseSpecialistAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalNurseSpecialistAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/cns-analytics',
      );
}

final cns_analyticsControllerProvider =
    StateNotifierProvider<
      ClinicalNurseSpecialistAnalyticsScreenController,
      ClinicalNurseSpecialistAnalyticsScreenState
    >((ref) {
      return ClinicalNurseSpecialistAnalyticsScreenController(ref);
    });
