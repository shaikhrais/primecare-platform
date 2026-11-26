import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientMessagesScreenState
    extends DashboardState<PatientMessagesScreenState> {
  PatientMessagesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientMessagesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientMessagesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientMessagesScreenController
    extends BaseDashboardController<PatientMessagesScreenState> {
  PatientMessagesScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientMessagesScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-messages',
      );
}

final patient_messagesControllerProvider =
    StateNotifierProvider<
      PatientMessagesScreenController,
      PatientMessagesScreenState
    >((ref) {
      return PatientMessagesScreenController(ref);
    });
