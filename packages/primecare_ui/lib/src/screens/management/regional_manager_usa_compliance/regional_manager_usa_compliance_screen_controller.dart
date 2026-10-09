import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaComplianceScreenState
    extends DashboardState<RegionalManagerUsaComplianceScreenState> {
  RegionalManagerUsaComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalManagerUsaComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalManagerUsaComplianceScreenController
    extends BaseDashboardController<RegionalManagerUsaComplianceScreenState> {
  RegionalManagerUsaComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalManagerUsaComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/regional-manager-usa-compliance',
      );
}

final regional_manager_usa_complianceControllerProvider =
    StateNotifierProvider<
      RegionalManagerUsaComplianceScreenController,
      RegionalManagerUsaComplianceScreenState
    >((ref) {
      return RegionalManagerUsaComplianceScreenController(ref);
    });
