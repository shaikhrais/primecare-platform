import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaDashboardScreenState
    extends DashboardState<RegionalManagerUsaDashboardScreenState> {
  RegionalManagerUsaDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RegionalManagerUsaDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RegionalManagerUsaDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RegionalManagerUsaDashboardScreenController
    extends BaseDashboardController<RegionalManagerUsaDashboardScreenState> {
  RegionalManagerUsaDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: RegionalManagerUsaDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/business_development/roles/regional_manager_usa/dashboard',
      );
}

final regional_manager_usa_dashboardControllerProvider =
    StateNotifierProvider<
      RegionalManagerUsaDashboardScreenController,
      RegionalManagerUsaDashboardScreenState
    >((ref) {
      return RegionalManagerUsaDashboardScreenController(ref);
    });
