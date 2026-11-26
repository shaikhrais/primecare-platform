import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicationScreenState extends DashboardState<MedicationScreenState> {
  MedicationScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  MedicationScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MedicationScreenState(isLoading: isLoading, error: error, data: data);
}

class MedicationScreenController
    extends BaseDashboardController<MedicationScreenState> {
  MedicationScreenController(Ref ref)
    : super(
        ref,
        initialState: MedicationScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/medication',
      );
}

final medicationControllerProvider =
    StateNotifierProvider<MedicationScreenController, MedicationScreenState>((
      ref,
    ) {
      return MedicationScreenController(ref);
    });
