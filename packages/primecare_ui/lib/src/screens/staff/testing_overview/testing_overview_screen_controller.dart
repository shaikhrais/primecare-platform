import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestingOverviewScreenState
    extends DashboardState<TestingOverviewScreenState> {
  TestingOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TestingOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TestingOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TestingOverviewScreenController
    extends BaseDashboardController<TestingOverviewScreenState> {
  TestingOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: TestingOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/staff/testing-overview',
      );
}

final testing_overviewControllerProvider =
    StateNotifierProvider<
      TestingOverviewScreenController,
      TestingOverviewScreenState
    >((ref) {
      return TestingOverviewScreenController(ref);
    });
