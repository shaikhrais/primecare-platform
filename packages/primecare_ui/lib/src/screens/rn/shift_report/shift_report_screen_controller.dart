import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftReportScreenState extends DashboardState<ShiftReportScreenState> {
  ShiftReportScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShiftReportScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShiftReportScreenState(isLoading: isLoading, error: error, data: data);
}

class ShiftReportScreenController
    extends BaseDashboardController<ShiftReportScreenState> {
  ShiftReportScreenController(Ref ref)
    : super(
        ref,
        initialState: ShiftReportScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/shift-report',
      );
}

final shift_reportControllerProvider =
    StateNotifierProvider<ShiftReportScreenController, ShiftReportScreenState>((
      ref,
    ) {
      return ShiftReportScreenController(ref);
    });
