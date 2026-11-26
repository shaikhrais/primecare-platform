import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentComplianceScreenState
    extends DashboardState<BusinessDevelopmentComplianceScreenState> {
  BusinessDevelopmentComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BusinessDevelopmentComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BusinessDevelopmentComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BusinessDevelopmentComplianceScreenController
    extends BaseDashboardController<BusinessDevelopmentComplianceScreenState> {
  BusinessDevelopmentComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: BusinessDevelopmentComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/business-development-compliance',
      );
}

final business_development_complianceControllerProvider =
    StateNotifierProvider<
      BusinessDevelopmentComplianceScreenController,
      BusinessDevelopmentComplianceScreenState
    >((ref) {
      return BusinessDevelopmentComplianceScreenController(ref);
    });
