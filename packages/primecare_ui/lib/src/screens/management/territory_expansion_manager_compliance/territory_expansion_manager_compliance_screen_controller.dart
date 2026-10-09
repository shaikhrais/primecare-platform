import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerComplianceScreenState
    extends DashboardState<TerritoryExpansionManagerComplianceScreenState> {
  TerritoryExpansionManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritoryExpansionManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritoryExpansionManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritoryExpansionManagerComplianceScreenController
    extends
        BaseDashboardController<
          TerritoryExpansionManagerComplianceScreenState
        > {
  TerritoryExpansionManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritoryExpansionManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-expansion-manager-compliance',
      );
}

final territory_expansion_manager_complianceControllerProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerComplianceScreenController,
      TerritoryExpansionManagerComplianceScreenState
    >((ref) {
      return TerritoryExpansionManagerComplianceScreenController(ref);
    });
