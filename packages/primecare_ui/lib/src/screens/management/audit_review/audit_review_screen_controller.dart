import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditReviewScreenState extends DashboardState<AuditReviewScreenState> {
  AuditReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AuditReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AuditReviewScreenState(isLoading: isLoading, error: error, data: data);
}

class AuditReviewScreenController
    extends BaseDashboardController<AuditReviewScreenState> {
  AuditReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: AuditReviewScreenState(isLoading: true, data: {}),
        endpoint: '/management/audit-review',
      );
}

final audit_reviewControllerProvider =
    StateNotifierProvider<AuditReviewScreenController, AuditReviewScreenState>((
      ref,
    ) {
      return AuditReviewScreenController(ref);
    });
