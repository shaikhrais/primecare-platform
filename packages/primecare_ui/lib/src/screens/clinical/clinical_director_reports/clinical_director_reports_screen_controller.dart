import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorReportsScreenState
    extends DashboardState<ClinicalDirectorReportsScreenState> {
  ClinicalDirectorReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorReportsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorReportsScreenController
    extends BaseDashboardController<ClinicalDirectorReportsScreenState> {
  ClinicalDirectorReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorReportsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/reports',
      );
}

final clinical_director_reportsControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorReportsScreenController,
      ClinicalDirectorReportsScreenState
    >((ref) {
      return ClinicalDirectorReportsScreenController(ref);
    });
