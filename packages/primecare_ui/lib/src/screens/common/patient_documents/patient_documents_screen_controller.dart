import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDocumentsScreenState
    extends DashboardState<PatientDocumentsScreenState> {
  PatientDocumentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientDocumentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientDocumentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientDocumentsScreenController
    extends BaseDashboardController<PatientDocumentsScreenState> {
  PatientDocumentsScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientDocumentsScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-documents',
      );
}

final patient_documentsControllerProvider =
    StateNotifierProvider<
      PatientDocumentsScreenController,
      PatientDocumentsScreenState
    >((ref) {
      return PatientDocumentsScreenController(ref);
    });
