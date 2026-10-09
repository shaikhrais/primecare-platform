import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyOperationsScreenState
    extends DashboardState<DailyOperationsScreenState> {
  DailyOperationsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DailyOperationsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => DailyOperationsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class DailyOperationsScreenController
    extends BaseDashboardController<DailyOperationsScreenState> {
  DailyOperationsScreenController(Ref ref)
    : super(
        ref,
        initialState: DailyOperationsScreenState(isLoading: true, data: {}),
        endpoint: '/management/daily-operations',
      );
}

final daily_operationsControllerProvider =
    StateNotifierProvider<
      DailyOperationsScreenController,
      DailyOperationsScreenState
    >((ref) {
      return DailyOperationsScreenController(ref);
    });
