import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAuditScreenState extends DashboardState<QualityAuditScreenState> {
  QualityAuditScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QualityAuditScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QualityAuditScreenState(isLoading: isLoading, error: error, data: data);
}

class QualityAuditScreenController
    extends BaseDashboardController<QualityAuditScreenState> {
  QualityAuditScreenController(Ref ref)
    : super(
        ref,
        initialState: QualityAuditScreenState(isLoading: true, data: {}),
        endpoint: '/staff/quality-audit',
      );
}

final quality_auditControllerProvider =
    StateNotifierProvider<
      QualityAuditScreenController,
      QualityAuditScreenState
    >((ref) {
      return QualityAuditScreenController(ref);
    });
