import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientProgressScreenState
    extends DashboardState<ClientProgressScreenState> {
  ClientProgressScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClientProgressScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      ClientProgressScreenState(isLoading: isLoading, error: error, data: data);
}

class ClientProgressScreenController
    extends BaseDashboardController<ClientProgressScreenState> {
  ClientProgressScreenController(Ref ref)
    : super(
        ref,
        initialState: ClientProgressScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/client-progress',
      );
}

final client_progressControllerProvider =
    StateNotifierProvider<
      ClientProgressScreenController,
      ClientProgressScreenState
    >((ref) {
      return ClientProgressScreenController(ref);
    });
