import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnReportsScreenState extends DashboardState<RnReportsScreenState> {
  RnReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnReportsScreenState(isLoading: isLoading, error: error, data: data);
}

class RnReportsScreenController
    extends BaseDashboardController<RnReportsScreenState> {
  RnReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: RnReportsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-reports',
      );
}

final rn_reportsControllerProvider =
    StateNotifierProvider<RnReportsScreenController, RnReportsScreenState>((
      ref,
    ) {
      return RnReportsScreenController(ref);
    });
