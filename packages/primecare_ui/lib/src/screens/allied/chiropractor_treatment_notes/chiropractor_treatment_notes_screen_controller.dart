import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorTreatmentNotesScreenState
    extends DashboardState<ChiropractorTreatmentNotesScreenState> {
  ChiropractorTreatmentNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorTreatmentNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorTreatmentNotesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorTreatmentNotesScreenController
    extends BaseDashboardController<ChiropractorTreatmentNotesScreenState> {
  ChiropractorTreatmentNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorTreatmentNotesScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/treatment-notes',
      );
}

final chiropractor_treatment_notesControllerProvider =
    StateNotifierProvider<
      ChiropractorTreatmentNotesScreenController,
      ChiropractorTreatmentNotesScreenState
    >((ref) {
      return ChiropractorTreatmentNotesScreenController(ref);
    });
