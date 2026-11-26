import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorPerformanceScreenState
    extends DashboardState<ClinicalDirectorPerformanceScreenState> {
  ClinicalDirectorPerformanceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorPerformanceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorPerformanceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorPerformanceScreenController
    extends BaseDashboardController<ClinicalDirectorPerformanceScreenState> {
  ClinicalDirectorPerformanceScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorPerformanceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/performance',
      );
}

final clinical_director_performanceControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorPerformanceScreenController,
      ClinicalDirectorPerformanceScreenState
    >((ref) {
      return ClinicalDirectorPerformanceScreenController(ref);
    });
