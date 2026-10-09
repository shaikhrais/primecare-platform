import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnMedicationsScreenState
    extends DashboardState<RpnMedicationsScreenState> {
  RpnMedicationsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnMedicationsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RpnMedicationsScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnMedicationsScreenController
    extends BaseDashboardController<RpnMedicationsScreenState> {
  RpnMedicationsScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnMedicationsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/medications',
      );
}

final rpn_medicationsControllerProvider =
    StateNotifierProvider<
      RpnMedicationsScreenController,
      RpnMedicationsScreenState
    >((ref) {
      return RpnMedicationsScreenController(ref);
    });
