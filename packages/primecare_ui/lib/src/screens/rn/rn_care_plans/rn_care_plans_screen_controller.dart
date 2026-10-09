import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCarePlansScreenState extends DashboardState<RnCarePlansScreenState> {
  RnCarePlansScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnCarePlansScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnCarePlansScreenState(isLoading: isLoading, error: error, data: data);
}

class RnCarePlansScreenController
    extends BaseDashboardController<RnCarePlansScreenState> {
  RnCarePlansScreenController(Ref ref)
    : super(
        ref,
        initialState: RnCarePlansScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-care-plans',
      );
}

final rn_care_plansControllerProvider =
    StateNotifierProvider<RnCarePlansScreenController, RnCarePlansScreenState>((
      ref,
    ) {
      return RnCarePlansScreenController(ref);
    });
