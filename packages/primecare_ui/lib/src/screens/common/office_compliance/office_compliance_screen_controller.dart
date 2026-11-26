import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeComplianceScreenState
    extends DashboardState<OfficeComplianceScreenState> {
  OfficeComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OfficeComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OfficeComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OfficeComplianceScreenController
    extends BaseDashboardController<OfficeComplianceScreenState> {
  OfficeComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: OfficeComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/office-compliance',
      );
}

final office_complianceControllerProvider =
    StateNotifierProvider<
      OfficeComplianceScreenController,
      OfficeComplianceScreenState
    >((ref) {
      return OfficeComplianceScreenController(ref);
    });
