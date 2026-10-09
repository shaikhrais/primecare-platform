import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistReportsScreenState
    extends DashboardState<PhysiotherapistReportsScreenState> {
  PhysiotherapistReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistReportsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistReportsScreenController
    extends BaseDashboardController<PhysiotherapistReportsScreenState> {
  PhysiotherapistReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistReportsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/reports',
      );
}

final physiotherapist_reportsControllerProvider =
    StateNotifierProvider<
      PhysiotherapistReportsScreenController,
      PhysiotherapistReportsScreenState
    >((ref) {
      return PhysiotherapistReportsScreenController(ref);
    });
