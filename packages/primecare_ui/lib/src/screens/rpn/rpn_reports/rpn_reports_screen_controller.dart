import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnReportsScreenState extends DashboardState<RpnReportsScreenState> {
  RpnReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnReportsScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnReportsScreenController
    extends BaseDashboardController<RpnReportsScreenState> {
  RpnReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnReportsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-reports',
      );
}

final rpn_reportsControllerProvider =
    StateNotifierProvider<RpnReportsScreenController, RpnReportsScreenState>((
      ref,
    ) {
      return RpnReportsScreenController(ref);
    });
