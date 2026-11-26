import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtReportsScreenState extends DashboardState<RmtReportsScreenState> {
  RmtReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RmtReportsScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtReportsScreenController
    extends BaseDashboardController<RmtReportsScreenState> {
  RmtReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtReportsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/reports',
      );
}

final rmt_reportsControllerProvider =
    StateNotifierProvider<RmtReportsScreenController, RmtReportsScreenState>((
      ref,
    ) {
      return RmtReportsScreenController(ref);
    });
