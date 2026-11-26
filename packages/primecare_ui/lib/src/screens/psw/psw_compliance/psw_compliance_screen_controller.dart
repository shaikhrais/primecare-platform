import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswComplianceScreenState
    extends DashboardState<PswComplianceScreenState> {
  PswComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      PswComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class PswComplianceScreenController
    extends BaseDashboardController<PswComplianceScreenState> {
  PswComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: PswComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/help-support',
      );
}

final psw_complianceControllerProvider =
    StateNotifierProvider<
      PswComplianceScreenController,
      PswComplianceScreenState
    >((ref) {
      return PswComplianceScreenController(ref);
    });
