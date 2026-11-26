import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenAuditScreenState extends DashboardState<ScreenAuditScreenState> {
  ScreenAuditScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ScreenAuditScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ScreenAuditScreenState(isLoading: isLoading, error: error, data: data);
}

class ScreenAuditScreenController
    extends BaseDashboardController<ScreenAuditScreenState> {
  ScreenAuditScreenController(Ref ref)
    : super(
        ref,
        initialState: ScreenAuditScreenState(isLoading: true, data: {}),
        endpoint: '/common/audit',
      );
}

final screen_auditControllerProvider =
    StateNotifierProvider<ScreenAuditScreenController, ScreenAuditScreenState>((
      ref,
    ) {
      return ScreenAuditScreenController(ref);
    });
