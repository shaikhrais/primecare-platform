import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenShiftScreenState extends DashboardState<OpenShiftScreenState> {
  OpenShiftScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OpenShiftScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OpenShiftScreenState(isLoading: isLoading, error: error, data: data);
}

class OpenShiftScreenController
    extends BaseDashboardController<OpenShiftScreenState> {
  OpenShiftScreenController(Ref ref)
    : super(
        ref,
        initialState: OpenShiftScreenState(isLoading: true, data: {}),
        endpoint: '/staff/open-shift',
      );
}

final open_shiftControllerProvider =
    StateNotifierProvider<OpenShiftScreenController, OpenShiftScreenState>((
      ref,
    ) {
      return OpenShiftScreenController(ref);
    });
