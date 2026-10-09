import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketManagementScreenState
    extends DashboardState<TicketManagementScreenState> {
  TicketManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TicketManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TicketManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TicketManagementScreenController
    extends BaseDashboardController<TicketManagementScreenState> {
  TicketManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: TicketManagementScreenState(isLoading: true, data: {}),
        endpoint: '/staff/ticket-management',
      );
}

final ticket_managementControllerProvider =
    StateNotifierProvider<
      TicketManagementScreenController,
      TicketManagementScreenState
    >((ref) {
      return TicketManagementScreenController(ref);
    });
