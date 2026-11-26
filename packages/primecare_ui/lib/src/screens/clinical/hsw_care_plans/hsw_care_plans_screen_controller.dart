import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswCarePlansScreenState extends DashboardState<HswCarePlansScreenState> {
  HswCarePlansScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HswCarePlansScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HswCarePlansScreenState(isLoading: isLoading, error: error, data: data);
}

class HswCarePlansScreenController
    extends BaseDashboardController<HswCarePlansScreenState> {
  HswCarePlansScreenController(Ref ref)
    : super(
        ref,
        initialState: HswCarePlansScreenState(isLoading: true, data: {}),
        endpoint: '/clinical/hsw-care-plans',
      );
}

final hsw_care_plansControllerProvider =
    StateNotifierProvider<
      HswCarePlansScreenController,
      HswCarePlansScreenState
    >((ref) {
      return HswCarePlansScreenController(ref);
    });
