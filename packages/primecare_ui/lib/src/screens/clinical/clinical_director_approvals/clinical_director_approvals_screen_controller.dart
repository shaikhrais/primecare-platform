import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorApprovalsScreenState
    extends DashboardState<ClinicalDirectorApprovalsScreenState> {
  ClinicalDirectorApprovalsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorApprovalsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorApprovalsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorApprovalsScreenController
    extends BaseDashboardController<ClinicalDirectorApprovalsScreenState> {
  ClinicalDirectorApprovalsScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorApprovalsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/approvals',
      );
}

final clinical_director_approvalsControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorApprovalsScreenController,
      ClinicalDirectorApprovalsScreenState
    >((ref) {
      return ClinicalDirectorApprovalsScreenController(ref);
    });
