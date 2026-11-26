import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerComplianceScreenState
    extends DashboardState<PartnershipManagerComplianceScreenState> {
  PartnershipManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PartnershipManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PartnershipManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PartnershipManagerComplianceScreenController
    extends BaseDashboardController<PartnershipManagerComplianceScreenState> {
  PartnershipManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: PartnershipManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/partnership-manager-compliance',
      );
}

final partnership_manager_complianceControllerProvider =
    StateNotifierProvider<
      PartnershipManagerComplianceScreenController,
      PartnershipManagerComplianceScreenState
    >((ref) {
      return PartnershipManagerComplianceScreenController(ref);
    });
