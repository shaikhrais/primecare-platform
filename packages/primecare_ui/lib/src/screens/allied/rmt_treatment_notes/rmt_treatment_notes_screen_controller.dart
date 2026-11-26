import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtTreatmentNotesScreenState
    extends DashboardState<RmtTreatmentNotesScreenState> {
  RmtTreatmentNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtTreatmentNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtTreatmentNotesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RmtTreatmentNotesScreenController
    extends BaseDashboardController<RmtTreatmentNotesScreenState> {
  RmtTreatmentNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtTreatmentNotesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/treatment-notes',
      );
}

final rmt_treatment_notesControllerProvider =
    StateNotifierProvider<
      RmtTreatmentNotesScreenController,
      RmtTreatmentNotesScreenState
    >((ref) {
      return RmtTreatmentNotesScreenController(ref);
    });
