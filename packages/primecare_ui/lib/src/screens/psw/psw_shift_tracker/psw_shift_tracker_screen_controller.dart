import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftTrackerScreenState extends DashboardState<ShiftTrackerScreenState> {
  ShiftTrackerScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShiftTrackerScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShiftTrackerScreenState(isLoading: isLoading, error: error, data: data);
}

class ShiftTrackerScreenController
    extends BaseDashboardController<ShiftTrackerScreenState> {
  ShiftTrackerScreenController(Ref ref)
    : super(
        ref,
        initialState: ShiftTrackerScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/schedule',
      );
}

final psw_shift_trackerControllerProvider =
    StateNotifierProvider<
      ShiftTrackerScreenController,
      ShiftTrackerScreenState
    >((ref) {
      return ShiftTrackerScreenController(ref);
    });
