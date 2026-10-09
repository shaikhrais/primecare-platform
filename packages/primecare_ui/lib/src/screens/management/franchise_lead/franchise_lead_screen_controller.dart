import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseLeadScreenState
    extends DashboardState<FranchiseLeadScreenState> {
  FranchiseLeadScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseLeadScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      FranchiseLeadScreenState(isLoading: isLoading, error: error, data: data);
}

class FranchiseLeadScreenController
    extends BaseDashboardController<FranchiseLeadScreenState> {
  FranchiseLeadScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseLeadScreenState(isLoading: true, data: {}),
        endpoint: '/management/franchise-lead',
      );
}

final franchise_leadControllerProvider =
    StateNotifierProvider<
      FranchiseLeadScreenController,
      FranchiseLeadScreenState
    >((ref) {
      return FranchiseLeadScreenController(ref);
    });
