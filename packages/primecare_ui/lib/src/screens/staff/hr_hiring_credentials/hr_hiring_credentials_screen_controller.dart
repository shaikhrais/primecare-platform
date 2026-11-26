import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringCredentialsScreenState
    extends DashboardState<HrHiringCredentialsScreenState> {
  HrHiringCredentialsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringCredentialsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringCredentialsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringCredentialsScreenController
    extends BaseDashboardController<HrHiringCredentialsScreenState> {
  HrHiringCredentialsScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringCredentialsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/hr_hiring/credentials',
      );
}

final hr_hiring_credentialsControllerProvider =
    StateNotifierProvider<
      HrHiringCredentialsScreenController,
      HrHiringCredentialsScreenState
    >((ref) {
      return HrHiringCredentialsScreenController(ref);
    });
