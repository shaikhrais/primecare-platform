import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuditComplianceFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditComplianceFormViewModel({this.isLoading = false, this.data});
}

class AuditComplianceFormAdapter
    extends Notifier<AuditComplianceFormViewModel> {
  @override
  AuditComplianceFormViewModel build() {
    return AuditComplianceFormViewModel();
  }

  Future<void> loadData() async {
        state = AuditComplianceFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-compliance-form-adapter');
      state = AuditComplianceFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AuditComplianceFormViewModel(isLoading: false, data: {});
    }
  }
}

final auditComplianceFormAdapterProvider =
    NotifierProvider<AuditComplianceFormAdapter, AuditComplianceFormViewModel>(
      () {
        return AuditComplianceFormAdapter();
      },
    );
