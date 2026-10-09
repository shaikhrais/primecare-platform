import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalComplianceScreenState
    extends DashboardState<LegalComplianceScreenState> {
  LegalComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LegalComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LegalComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LegalComplianceScreenController
    extends BaseDashboardController<LegalComplianceScreenState> {
  LegalComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: LegalComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/legal-compliance',
      );
}

final legal_complianceControllerProvider =
    StateNotifierProvider<
      LegalComplianceScreenController,
      LegalComplianceScreenState
    >((ref) {
      return LegalComplianceScreenController(ref);
    });
