import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnVitalsScreenState extends DashboardState<RpnVitalsScreenState> {
  RpnVitalsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnVitalsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnVitalsScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnVitalsScreenController
    extends BaseDashboardController<RpnVitalsScreenState> {
  RpnVitalsScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnVitalsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/vitals',
      );
}

final rpn_vitalsControllerProvider =
    StateNotifierProvider<RpnVitalsScreenController, RpnVitalsScreenState>((
      ref,
    ) {
      return RpnVitalsScreenController(ref);
    });
