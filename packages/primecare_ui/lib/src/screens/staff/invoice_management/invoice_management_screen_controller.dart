import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceManagementScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  InvoiceManagementScreenState({required this.isLoading, this.error, required this.data});

  InvoiceManagementScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return InvoiceManagementScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class InvoiceManagementScreenController extends StateNotifier<InvoiceManagementScreenState> {
  final Ref ref;
  InvoiceManagementScreenController(this.ref) : super(InvoiceManagementScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/invoice-management');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final invoice_managementControllerProvider = StateNotifierProvider<InvoiceManagementScreenController, InvoiceManagementScreenState>((ref) {
  return InvoiceManagementScreenController(ref);
});
