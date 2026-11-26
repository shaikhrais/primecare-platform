import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalOperations4KScreenState
    extends DashboardState<ClinicalOperations4KScreenState> {
  ClinicalOperations4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalOperations4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalOperations4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalOperations4KScreenController
    extends BaseDashboardController<ClinicalOperations4KScreenState> {
  ClinicalOperations4KScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalOperations4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/operations4k',
      );
}

final clinical_operations4_kControllerProvider =
    StateNotifierProvider<
      ClinicalOperations4KScreenController,
      ClinicalOperations4KScreenState
    >((ref) {
      return ClinicalOperations4KScreenController(ref);
    });
