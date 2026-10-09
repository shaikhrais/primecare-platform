import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerClientsScreenState
    extends DashboardState<FranchiseOwnerClientsScreenState> {
  FranchiseOwnerClientsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerClientsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerClientsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerClientsScreenController
    extends BaseDashboardController<FranchiseOwnerClientsScreenState> {
  FranchiseOwnerClientsScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerClientsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/franchise/roles/franchise_owner/clients',
      );
}

final franchise_owner_clientsControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerClientsScreenController,
      FranchiseOwnerClientsScreenState
    >((ref) {
      return FranchiseOwnerClientsScreenController(ref);
    });
