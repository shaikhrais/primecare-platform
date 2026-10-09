import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerStaffScreenState
    extends DashboardState<FranchiseOwnerStaffScreenState> {
  FranchiseOwnerStaffScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerStaffScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerStaffScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerStaffScreenController
    extends BaseDashboardController<FranchiseOwnerStaffScreenState> {
  FranchiseOwnerStaffScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerStaffScreenState(isLoading: true, data: {}),
        endpoint: '/offices/franchise/roles/franchise_owner/staff',
      );
}

final franchise_owner_staffControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerStaffScreenController,
      FranchiseOwnerStaffScreenState
    >((ref) {
      return FranchiseOwnerStaffScreenController(ref);
    });
