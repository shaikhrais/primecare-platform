import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaxComplianceScreenState
    extends DashboardState<TaxComplianceScreenState> {
  TaxComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TaxComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      TaxComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class TaxComplianceScreenController
    extends BaseDashboardController<TaxComplianceScreenState> {
  TaxComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TaxComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/tax-compliance',
      );
}

final tax_complianceControllerProvider =
    StateNotifierProvider<
      TaxComplianceScreenController,
      TaxComplianceScreenState
    >((ref) {
      return TaxComplianceScreenController(ref);
    });
