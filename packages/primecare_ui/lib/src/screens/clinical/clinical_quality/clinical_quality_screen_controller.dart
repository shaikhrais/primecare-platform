import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalQualityScreenState
    extends DashboardState<ClinicalQualityScreenState> {
  ClinicalQualityScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalQualityScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalQualityScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalQualityScreenController
    extends BaseDashboardController<ClinicalQualityScreenState> {
  ClinicalQualityScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalQualityScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/quality',
      );
}

final clinical_qualityControllerProvider =
    StateNotifierProvider<
      ClinicalQualityScreenController,
      ClinicalQualityScreenState
    >((ref) {
      return ClinicalQualityScreenController(ref);
    });
