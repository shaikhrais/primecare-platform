import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityAuditScreenState
    extends DashboardState<SecurityAuditScreenState> {
  SecurityAuditScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SecurityAuditScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      SecurityAuditScreenState(isLoading: isLoading, error: error, data: data);
}

class SecurityAuditScreenController
    extends BaseDashboardController<SecurityAuditScreenState> {
  SecurityAuditScreenController(Ref ref)
    : super(
        ref,
        initialState: SecurityAuditScreenState(isLoading: true, data: {}),
        endpoint: '/executive/security-audit',
      );
}

final security_auditControllerProvider =
    StateNotifierProvider<
      SecurityAuditScreenController,
      SecurityAuditScreenState
    >((ref) {
      return SecurityAuditScreenController(ref);
    });
