import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistComplianceScreenState
    extends DashboardState<PhysiotherapistComplianceScreenState> {
  PhysiotherapistComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistComplianceScreenController
    extends BaseDashboardController<PhysiotherapistComplianceScreenState> {
  PhysiotherapistComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/compliance',
      );
}

final physiotherapist_complianceControllerProvider =
    StateNotifierProvider<
      PhysiotherapistComplianceScreenController,
      PhysiotherapistComplianceScreenState
    >((ref) {
      return PhysiotherapistComplianceScreenController(ref);
    });
