import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AuditRoyaltyPaymentFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditRoyaltyPaymentFormViewModel({this.isLoading = false, this.data});
}

class AuditRoyaltyPaymentFormAdapter extends Notifier<AuditRoyaltyPaymentFormViewModel> {
  @override
  AuditRoyaltyPaymentFormViewModel build() {
    return AuditRoyaltyPaymentFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AuditRoyaltyPaymentFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AuditRoyaltyPaymentFormViewModel(isLoading: false, data: {});
  }
}

final auditRoyaltyPaymentFormAdapterProvider = NotifierProvider<AuditRoyaltyPaymentFormAdapter, AuditRoyaltyPaymentFormViewModel>(() {
  return AuditRoyaltyPaymentFormAdapter();
});
