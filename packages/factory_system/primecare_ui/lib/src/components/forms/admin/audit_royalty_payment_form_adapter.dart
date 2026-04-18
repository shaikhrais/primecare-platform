import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuditRoyaltyPaymentFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      final response = await client.get('/api/v1/audit-royalty-payment-form-adapter');
      state = AuditRoyaltyPaymentFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AuditRoyaltyPaymentFormViewModel(isLoading: false, data: {});
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
