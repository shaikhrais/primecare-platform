import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorDashboardScreenState
    extends DashboardState<ChiropractorDashboardScreenState> {
  ChiropractorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorDashboardScreenController
    extends BaseDashboardController<ChiropractorDashboardScreenState> {
  ChiropractorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/dashboard',
      );
}

final chiropractor_dashboardControllerProvider =
    StateNotifierProvider<
      ChiropractorDashboardScreenController,
      ChiropractorDashboardScreenState
    >((ref) {
      return ChiropractorDashboardScreenController(ref);
    });
