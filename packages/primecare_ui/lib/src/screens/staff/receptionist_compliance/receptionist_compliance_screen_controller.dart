import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistComplianceScreenState
    extends DashboardState<ReceptionistComplianceScreenState> {
  ReceptionistComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReceptionistComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ReceptionistComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ReceptionistComplianceScreenController
    extends BaseDashboardController<ReceptionistComplianceScreenState> {
  ReceptionistComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ReceptionistComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/receptionist-compliance',
      );
}

final receptionist_complianceControllerProvider =
    StateNotifierProvider<
      ReceptionistComplianceScreenController,
      ReceptionistComplianceScreenState
    >((ref) {
      return ReceptionistComplianceScreenController(ref);
    });
