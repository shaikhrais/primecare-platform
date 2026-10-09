import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalComplianceScreenState
    extends DashboardState<PortalComplianceScreenState> {
  PortalComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PortalComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PortalComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PortalComplianceScreenController
    extends BaseDashboardController<PortalComplianceScreenState> {
  PortalComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: PortalComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/portal-compliance',
      );
}

final portal_complianceControllerProvider =
    StateNotifierProvider<
      PortalComplianceScreenController,
      PortalComplianceScreenState
    >((ref) {
      return PortalComplianceScreenController(ref);
    });
