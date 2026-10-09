import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswAdlLoggerScreenState extends DashboardState<HswAdlLoggerScreenState> {
  HswAdlLoggerScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HswAdlLoggerScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HswAdlLoggerScreenState(isLoading: isLoading, error: error, data: data);
}

class HswAdlLoggerScreenController
    extends BaseDashboardController<HswAdlLoggerScreenState> {
  HswAdlLoggerScreenController(Ref ref)
    : super(
        ref,
        initialState: HswAdlLoggerScreenState(isLoading: true, data: {}),
        endpoint: '/clinical/hsw-adl-logger',
      );
}

final hsw_adl_loggerControllerProvider =
    StateNotifierProvider<
      HswAdlLoggerScreenController,
      HswAdlLoggerScreenState
    >((ref) {
      return HswAdlLoggerScreenController(ref);
    });
