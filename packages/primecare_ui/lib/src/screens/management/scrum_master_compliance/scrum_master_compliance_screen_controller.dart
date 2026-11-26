import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterComplianceScreenState
    extends DashboardState<ScrumMasterComplianceScreenState> {
  ScrumMasterComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ScrumMasterComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ScrumMasterComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ScrumMasterComplianceScreenController
    extends BaseDashboardController<ScrumMasterComplianceScreenState> {
  ScrumMasterComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ScrumMasterComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/scrum-master-compliance',
      );
}

final scrum_master_complianceControllerProvider =
    StateNotifierProvider<
      ScrumMasterComplianceScreenController,
      ScrumMasterComplianceScreenState
    >((ref) {
      return ScrumMasterComplianceScreenController(ref);
    });
