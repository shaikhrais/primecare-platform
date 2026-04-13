import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AuditComplianceFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditComplianceFormViewModel({this.isLoading = false, this.data});
}

class AuditComplianceFormAdapter extends Notifier<AuditComplianceFormViewModel> {
  @override
  AuditComplianceFormViewModel build() {
    return AuditComplianceFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AuditComplianceFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AuditComplianceFormViewModel(isLoading: false, data: {});
  }
}

final auditComplianceFormAdapterProvider = NotifierProvider<AuditComplianceFormAdapter, AuditComplianceFormViewModel>(() {
  return AuditComplianceFormAdapter();
});
