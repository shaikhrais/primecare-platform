import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyShiftsScreenState extends DashboardState<PswMyShiftsScreenState> {
  PswMyShiftsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswMyShiftsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswMyShiftsScreenState(isLoading: isLoading, error: error, data: data);
}

class PswMyShiftsScreenController
    extends BaseDashboardController<PswMyShiftsScreenState> {
  PswMyShiftsScreenController(Ref ref)
    : super(
        ref,
        initialState: PswMyShiftsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/psw-my-shifts',
      );
}

final psw_my_shiftsControllerProvider =
    StateNotifierProvider<PswMyShiftsScreenController, PswMyShiftsScreenState>((
      ref,
    ) {
      return PswMyShiftsScreenController(ref);
    });
