import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorStaffQualityScreenState
    extends DashboardState<ClinicalDirectorStaffQualityScreenState> {
  ClinicalDirectorStaffQualityScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorStaffQualityScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorStaffQualityScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorStaffQualityScreenController
    extends BaseDashboardController<ClinicalDirectorStaffQualityScreenState> {
  ClinicalDirectorStaffQualityScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorStaffQualityScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/staff-quality',
      );
}

final clinical_director_staff_qualityControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorStaffQualityScreenController,
      ClinicalDirectorStaffQualityScreenState
    >((ref) {
      return ClinicalDirectorStaffQualityScreenController(ref);
    });
