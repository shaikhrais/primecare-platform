import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswClientProfileScreenState
    extends DashboardState<PswClientProfileScreenState> {
  PswClientProfileScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswClientProfileScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswClientProfileScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PswClientProfileScreenController
    extends BaseDashboardController<PswClientProfileScreenState> {
  PswClientProfileScreenController(Ref ref)
    : super(
        ref,
        initialState: PswClientProfileScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/profile',
      );
}

final psw_client_profileControllerProvider =
    StateNotifierProvider<
      PswClientProfileScreenController,
      PswClientProfileScreenState
    >((ref) {
      return PswClientProfileScreenController(ref);
    });
