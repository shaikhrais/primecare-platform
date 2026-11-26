import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoInvoicesScreenState extends DashboardState<CfoInvoicesScreenState> {
  CfoInvoicesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoInvoicesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoInvoicesScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoInvoicesScreenController
    extends BaseDashboardController<CfoInvoicesScreenState> {
  CfoInvoicesScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoInvoicesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cfo/invoices',
      );
}

final cfo_invoicesControllerProvider =
    StateNotifierProvider<CfoInvoicesScreenController, CfoInvoicesScreenState>((
      ref,
    ) {
      return CfoInvoicesScreenController(ref);
    });
