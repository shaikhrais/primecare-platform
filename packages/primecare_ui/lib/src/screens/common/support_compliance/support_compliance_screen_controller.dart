import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportComplianceScreenState
    extends DashboardState<SupportComplianceScreenState> {
  SupportComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SupportComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SupportComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SupportComplianceScreenController
    extends BaseDashboardController<SupportComplianceScreenState> {
  SupportComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: SupportComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/support-compliance',
      );
}

final support_complianceControllerProvider =
    StateNotifierProvider<
      SupportComplianceScreenController,
      SupportComplianceScreenState
    >((ref) {
      return SupportComplianceScreenController(ref);
    });
