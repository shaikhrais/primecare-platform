import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceReviewScreenState
    extends DashboardState<ComplianceReviewScreenState> {
  ComplianceReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceReviewScreenController
    extends BaseDashboardController<ComplianceReviewScreenState> {
  ComplianceReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/compliance-review',
      );
}

final compliance_reviewControllerProvider =
    StateNotifierProvider<
      ComplianceReviewScreenController,
      ComplianceReviewScreenState
    >((ref) {
      return ComplianceReviewScreenController(ref);
    });
