import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagementScreenState
    extends DashboardState<PartnershipManagementScreenState> {
  PartnershipManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PartnershipManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PartnershipManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PartnershipManagementScreenController
    extends BaseDashboardController<PartnershipManagementScreenState> {
  PartnershipManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: PartnershipManagementScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/partnership-management',
      );
}

final partnership_managementControllerProvider =
    StateNotifierProvider<
      PartnershipManagementScreenController,
      PartnershipManagementScreenState
    >((ref) {
      return PartnershipManagementScreenController(ref);
    });
