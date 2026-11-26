import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmComplianceScreenState
    extends DashboardState<RegionalBdmComplianceScreenState> {
  RegionalBdmComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalBdmComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalBdmComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalBdmComplianceScreenController
    extends BaseDashboardController<RegionalBdmComplianceScreenState> {
  RegionalBdmComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalBdmComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/regional-bdm-compliance',
      );
}

final regional_bdm_complianceControllerProvider =
    StateNotifierProvider<
      RegionalBdmComplianceScreenController,
      RegionalBdmComplianceScreenState
    >((ref) {
      return RegionalBdmComplianceScreenController(ref);
    });
