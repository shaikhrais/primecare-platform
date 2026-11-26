import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderComplianceScreenState
    extends DashboardState<ShareholderComplianceScreenState> {
  ShareholderComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ShareholderComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ShareholderComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ShareholderComplianceScreenController
    extends BaseDashboardController<ShareholderComplianceScreenState> {
  ShareholderComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ShareholderComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/shareholder-compliance',
      );
}

final shareholder_complianceControllerProvider =
    StateNotifierProvider<
      ShareholderComplianceScreenController,
      ShareholderComplianceScreenState
    >((ref) {
      return ShareholderComplianceScreenController(ref);
    });
