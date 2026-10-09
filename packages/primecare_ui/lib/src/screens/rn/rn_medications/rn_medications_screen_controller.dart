import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnMedicationsScreenState
    extends DashboardState<RnMedicationsScreenState> {
  RnMedicationsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnMedicationsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RnMedicationsScreenState(isLoading: isLoading, error: error, data: data);
}

class RnMedicationsScreenController
    extends BaseDashboardController<RnMedicationsScreenState> {
  RnMedicationsScreenController(Ref ref)
    : super(
        ref,
        initialState: RnMedicationsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/medications',
      );
}

final rn_medicationsControllerProvider =
    StateNotifierProvider<
      RnMedicationsScreenController,
      RnMedicationsScreenState
    >((ref) {
      return RnMedicationsScreenController(ref);
    });
