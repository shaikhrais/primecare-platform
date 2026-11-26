import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswScheduleScreenState extends DashboardState<HswScheduleScreenState> {
  HswScheduleScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HswScheduleScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HswScheduleScreenState(isLoading: isLoading, error: error, data: data);
}

class HswScheduleScreenController
    extends BaseDashboardController<HswScheduleScreenState> {
  HswScheduleScreenController(Ref ref)
    : super(
        ref,
        initialState: HswScheduleScreenState(isLoading: true, data: {}),
        endpoint: '/clinical/hsw-schedule',
      );
}

final hsw_scheduleControllerProvider =
    StateNotifierProvider<HswScheduleScreenController, HswScheduleScreenState>((
      ref,
    ) {
      return HswScheduleScreenController(ref);
    });
