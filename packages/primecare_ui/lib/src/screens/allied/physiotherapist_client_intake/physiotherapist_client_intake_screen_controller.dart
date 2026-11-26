import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistClientIntakeScreenState
    extends DashboardState<PhysiotherapistClientIntakeScreenState> {
  PhysiotherapistClientIntakeScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistClientIntakeScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistClientIntakeScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistClientIntakeScreenController
    extends BaseDashboardController<PhysiotherapistClientIntakeScreenState> {
  PhysiotherapistClientIntakeScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistClientIntakeScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/client-intake',
      );
}

final physiotherapist_client_intakeControllerProvider =
    StateNotifierProvider<
      PhysiotherapistClientIntakeScreenController,
      PhysiotherapistClientIntakeScreenState
    >((ref) {
      return PhysiotherapistClientIntakeScreenController(ref);
    });
