import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicAnalyticsScreenState
    extends DashboardState<ClinicAnalyticsScreenState> {
  ClinicAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicAnalyticsScreenController
    extends BaseDashboardController<ClinicAnalyticsScreenState> {
  ClinicAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/clinic-analytics',
      );
}

final clinic_analyticsControllerProvider =
    StateNotifierProvider<
      ClinicAnalyticsScreenController,
      ClinicAnalyticsScreenState
    >((ref) {
      return ClinicAnalyticsScreenController(ref);
    });
