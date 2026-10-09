import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultNotImplementedScreenState
    extends DashboardState<DefaultNotImplementedScreenState> {
  DefaultNotImplementedScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DefaultNotImplementedScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DefaultNotImplementedScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class DefaultNotImplementedScreenController
    extends BaseDashboardController<DefaultNotImplementedScreenState> {
  DefaultNotImplementedScreenController(Ref ref)
    : super(
        ref,
        initialState: DefaultNotImplementedScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/generated/default-not-implemented',
      );
}

final default_not_implementedControllerProvider =
    StateNotifierProvider<
      DefaultNotImplementedScreenController,
      DefaultNotImplementedScreenState
    >((ref) {
      return DefaultNotImplementedScreenController(ref);
    });
