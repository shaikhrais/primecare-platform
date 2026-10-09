import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowupScreenState extends DashboardState<FollowupScreenState> {
  FollowupScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FollowupScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FollowupScreenState(isLoading: isLoading, error: error, data: data);
}

class FollowupScreenController
    extends BaseDashboardController<FollowupScreenState> {
  FollowupScreenController(Ref ref)
    : super(
        ref,
        initialState: FollowupScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/intake_coordinator/followup',
      );
}

final followupControllerProvider =
    StateNotifierProvider<FollowupScreenController, FollowupScreenState>((ref) {
      return FollowupScreenController(ref);
    });
