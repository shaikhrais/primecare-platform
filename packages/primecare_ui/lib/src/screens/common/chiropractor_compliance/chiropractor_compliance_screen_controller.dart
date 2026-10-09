import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorComplianceScreenState
    extends DashboardState<ChiropractorComplianceScreenState> {
  ChiropractorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorComplianceScreenController
    extends BaseDashboardController<ChiropractorComplianceScreenState> {
  ChiropractorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/compliance',
      );
}

final chiropractor_complianceControllerProvider =
    StateNotifierProvider<
      ChiropractorComplianceScreenController,
      ChiropractorComplianceScreenState
    >((ref) {
      return ChiropractorComplianceScreenController(ref);
    });
