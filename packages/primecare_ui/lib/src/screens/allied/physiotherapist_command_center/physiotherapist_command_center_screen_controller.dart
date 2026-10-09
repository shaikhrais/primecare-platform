import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistCommandCenterScreenState
    extends DashboardState<PhysiotherapistCommandCenterScreenState> {
  PhysiotherapistCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistCommandCenterScreenController
    extends BaseDashboardController<PhysiotherapistCommandCenterScreenState> {
  PhysiotherapistCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/command-center',
      );
}

final physiotherapist_command_centerControllerProvider =
    StateNotifierProvider<
      PhysiotherapistCommandCenterScreenController,
      PhysiotherapistCommandCenterScreenState
    >((ref) {
      return PhysiotherapistCommandCenterScreenController(ref);
    });
