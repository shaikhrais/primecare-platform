import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritorySalesManagerComplianceScreenState
    extends DashboardState<TerritorySalesManagerComplianceScreenState> {
  TerritorySalesManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TerritorySalesManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TerritorySalesManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TerritorySalesManagerComplianceScreenController
    extends
        BaseDashboardController<TerritorySalesManagerComplianceScreenState> {
  TerritorySalesManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TerritorySalesManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/territory-sales-manager-compliance',
      );
}

final territory_sales_manager_complianceControllerProvider =
    StateNotifierProvider<
      TerritorySalesManagerComplianceScreenController,
      TerritorySalesManagerComplianceScreenState
    >((ref) {
      return TerritorySalesManagerComplianceScreenController(ref);
    });
