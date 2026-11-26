import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnVitalsScreenState extends DashboardState<RnVitalsScreenState> {
  RnVitalsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnVitalsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnVitalsScreenState(isLoading: isLoading, error: error, data: data);
}

class RnVitalsScreenController
    extends BaseDashboardController<RnVitalsScreenState> {
  RnVitalsScreenController(Ref ref)
    : super(
        ref,
        initialState: RnVitalsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/vitals',
      );
}

final rn_vitalsControllerProvider =
    StateNotifierProvider<RnVitalsScreenController, RnVitalsScreenState>((ref) {
      return RnVitalsScreenController(ref);
    });
