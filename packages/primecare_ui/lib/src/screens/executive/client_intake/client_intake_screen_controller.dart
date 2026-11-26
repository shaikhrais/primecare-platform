import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientIntakeScreenState extends DashboardState<ClientIntakeScreenState> {
  ClientIntakeScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClientIntakeScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClientIntakeScreenState(isLoading: isLoading, error: error, data: data);
}

class ClientIntakeScreenController
    extends BaseDashboardController<ClientIntakeScreenState> {
  ClientIntakeScreenController(Ref ref)
    : super(
        ref,
        initialState: ClientIntakeScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/client-intake',
      );
}

final client_intakeControllerProvider =
    StateNotifierProvider<
      ClientIntakeScreenController,
      ClientIntakeScreenState
    >((ref) {
      return ClientIntakeScreenController(ref);
    });
