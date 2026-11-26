import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerComplianceScreenState
    extends DashboardState<LocalMarketingManagerComplianceScreenState> {
  LocalMarketingManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LocalMarketingManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LocalMarketingManagerComplianceScreenController
    extends
        BaseDashboardController<LocalMarketingManagerComplianceScreenState> {
  LocalMarketingManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: LocalMarketingManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/local-marketing-manager-compliance',
      );
}

final local_marketing_manager_complianceControllerProvider =
    StateNotifierProvider<
      LocalMarketingManagerComplianceScreenController,
      LocalMarketingManagerComplianceScreenState
    >((ref) {
      return LocalMarketingManagerComplianceScreenController(ref);
    });
