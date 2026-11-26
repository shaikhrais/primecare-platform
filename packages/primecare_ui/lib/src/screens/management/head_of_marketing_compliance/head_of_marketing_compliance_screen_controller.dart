import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingComplianceScreenState
    extends DashboardState<HeadOfMarketingComplianceScreenState> {
  HeadOfMarketingComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfMarketingComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfMarketingComplianceScreenController
    extends BaseDashboardController<HeadOfMarketingComplianceScreenState> {
  HeadOfMarketingComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfMarketingComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-marketing-compliance',
      );
}

final head_of_marketing_complianceControllerProvider =
    StateNotifierProvider<
      HeadOfMarketingComplianceScreenController,
      HeadOfMarketingComplianceScreenState
    >((ref) {
      return HeadOfMarketingComplianceScreenController(ref);
    });
