import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceManagementScreenState
    extends DashboardState<InvoiceManagementScreenState> {
  InvoiceManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InvoiceManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InvoiceManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InvoiceManagementScreenController
    extends BaseDashboardController<InvoiceManagementScreenState> {
  InvoiceManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: InvoiceManagementScreenState(isLoading: true, data: {}),
        endpoint: '/staff/invoice-management',
      );
}

final invoice_managementControllerProvider =
    StateNotifierProvider<
      InvoiceManagementScreenController,
      InvoiceManagementScreenState
    >((ref) {
      return InvoiceManagementScreenController(ref);
    });
