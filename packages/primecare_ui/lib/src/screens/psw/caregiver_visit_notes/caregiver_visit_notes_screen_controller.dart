import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverVisitNotesScreenState
    extends DashboardState<CaregiverVisitNotesScreenState> {
  CaregiverVisitNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverVisitNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CaregiverVisitNotesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CaregiverVisitNotesScreenController
    extends BaseDashboardController<CaregiverVisitNotesScreenState> {
  CaregiverVisitNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverVisitNotesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/caregiver/visit-notes',
      );
}

final caregiver_visit_notesControllerProvider =
    StateNotifierProvider<
      CaregiverVisitNotesScreenController,
      CaregiverVisitNotesScreenState
    >((ref) {
      return CaregiverVisitNotesScreenController(ref);
    });
