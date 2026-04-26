// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class AuditRoyaltyPaymentFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  AuditRoyaltyPaymentFormViewModel({this.isLoading = false, this.data});
}

class AuditRoyaltyPaymentFormAdapter
    extends Notifier<AuditRoyaltyPaymentFormViewModel> {
  @override
  AuditRoyaltyPaymentFormViewModel build() {
    return AuditRoyaltyPaymentFormViewModel();
  }

  Future<void> loadData() async {
    state = AuditRoyaltyPaymentFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/audit-royalty-payment-form-adapter',
      );
      state = AuditRoyaltyPaymentFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = AuditRoyaltyPaymentFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final auditRoyaltyPaymentFormAdapterProvider =
    NotifierProvider<
      AuditRoyaltyPaymentFormAdapter,
      AuditRoyaltyPaymentFormViewModel
    >(() {
      return AuditRoyaltyPaymentFormAdapter();
    });
