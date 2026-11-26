import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationAdministrationScreenState
    extends DashboardState<MedicationAdministrationScreenState> {
  MedicationAdministrationScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  MedicationAdministrationScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MedicationAdministrationScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class MedicationAdministrationScreenController
    extends BaseDashboardController<MedicationAdministrationScreenState> {
  MedicationAdministrationScreenController(Ref ref)
    : super(
        ref,
        initialState: MedicationAdministrationScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/rn/medication-administration',
      );
}

final medication_administrationControllerProvider =
    StateNotifierProvider<
      MedicationAdministrationScreenController,
      MedicationAdministrationScreenState
    >((ref) {
      return MedicationAdministrationScreenController(ref);
    });
