import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooComplianceScreenState
    extends DashboardState<CooComplianceScreenState> {
  CooComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CooComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class CooComplianceScreenController
    extends BaseDashboardController<CooComplianceScreenState> {
  CooComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CooComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/coo/compliance-view',
      );
}

final coo_complianceControllerProvider =
    StateNotifierProvider<
      CooComplianceScreenController,
      CooComplianceScreenState
    >((ref) {
      return CooComplianceScreenController(ref);
    });
