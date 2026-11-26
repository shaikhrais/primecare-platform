import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerComplianceScreenState
    extends DashboardState<GeneralManagerComplianceScreenState> {
  GeneralManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GeneralManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GeneralManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GeneralManagerComplianceScreenController
    extends BaseDashboardController<GeneralManagerComplianceScreenState> {
  GeneralManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: GeneralManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/general-manager-compliance',
      );
}

final general_manager_complianceControllerProvider =
    StateNotifierProvider<
      GeneralManagerComplianceScreenController,
      GeneralManagerComplianceScreenState
    >((ref) {
      return GeneralManagerComplianceScreenController(ref);
    });
