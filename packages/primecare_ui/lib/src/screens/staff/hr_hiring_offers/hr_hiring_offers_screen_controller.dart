import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringOffersScreenState
    extends DashboardState<HrHiringOffersScreenState> {
  HrHiringOffersScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringOffersScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      HrHiringOffersScreenState(isLoading: isLoading, error: error, data: data);
}

class HrHiringOffersScreenController
    extends BaseDashboardController<HrHiringOffersScreenState> {
  HrHiringOffersScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringOffersScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/hr_hiring/offers',
      );
}

final hr_hiring_offersControllerProvider =
    StateNotifierProvider<
      HrHiringOffersScreenController,
      HrHiringOffersScreenState
    >((ref) {
      return HrHiringOffersScreenController(ref);
    });
