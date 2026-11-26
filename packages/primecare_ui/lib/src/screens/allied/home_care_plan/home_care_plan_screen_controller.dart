import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeCarePlanScreenState extends DashboardState<HomeCarePlanScreenState> {
  HomeCarePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HomeCarePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HomeCarePlanScreenState(isLoading: isLoading, error: error, data: data);
}

class HomeCarePlanScreenController
    extends BaseDashboardController<HomeCarePlanScreenState> {
  HomeCarePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: HomeCarePlanScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/home-care-plan',
      );
}

final home_care_planControllerProvider =
    StateNotifierProvider<
      HomeCarePlanScreenController,
      HomeCarePlanScreenState
    >((ref) {
      return HomeCarePlanScreenController(ref);
    });
