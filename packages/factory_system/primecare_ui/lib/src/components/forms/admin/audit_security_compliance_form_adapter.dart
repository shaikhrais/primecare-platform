import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AuditSecurityComplianceFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditSecurityComplianceFormViewModel({this.isLoading = false, this.data});
}

class AuditSecurityComplianceFormAdapter extends Notifier<AuditSecurityComplianceFormViewModel> {
  @override
  AuditSecurityComplianceFormViewModel build() {
    return AuditSecurityComplianceFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AuditSecurityComplianceFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AuditSecurityComplianceFormViewModel(isLoading: false, data: {});
  }
}

final auditSecurityComplianceFormAdapterProvider = NotifierProvider<AuditSecurityComplianceFormAdapter, AuditSecurityComplianceFormViewModel>(() {
  return AuditSecurityComplianceFormAdapter();
});
