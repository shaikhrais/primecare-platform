import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernedState extends DashboardState<GovernedState> {
  GovernedState({required super.isLoading, super.error, required super.data});

  @override
  GovernedState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernedState(isLoading: isLoading, error: error, data: data);
}

class GovernedController extends BaseDashboardController<GovernedState> {
  GovernedController(Ref ref)
    : super(
        ref,
        initialState: GovernedState(isLoading: true, data: {}),
        endpoint: '/generated/governed',
      );
}

final governedControllerProvider =
    StateNotifierProvider<GovernedController, GovernedState>((ref) {
      return GovernedController(ref);
    });
