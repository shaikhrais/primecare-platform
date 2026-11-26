import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistTreatmentNotesScreenState
    extends DashboardState<PhysiotherapistTreatmentNotesScreenState> {
  PhysiotherapistTreatmentNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistTreatmentNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistTreatmentNotesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistTreatmentNotesScreenController
    extends BaseDashboardController<PhysiotherapistTreatmentNotesScreenState> {
  PhysiotherapistTreatmentNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistTreatmentNotesScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/treatment-notes',
      );
}

final physiotherapist_treatment_notesControllerProvider =
    StateNotifierProvider<
      PhysiotherapistTreatmentNotesScreenController,
      PhysiotherapistTreatmentNotesScreenState
    >((ref) {
      return PhysiotherapistTreatmentNotesScreenController(ref);
    });
