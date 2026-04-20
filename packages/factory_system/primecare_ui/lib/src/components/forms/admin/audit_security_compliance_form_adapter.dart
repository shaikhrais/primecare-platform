import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class AuditSecurityComplianceFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditSecurityComplianceFormViewModel({this.isLoading = false, this.data});
}

class AuditSecurityComplianceFormAdapter
    extends Notifier<AuditSecurityComplianceFormViewModel> {
  @override
  AuditSecurityComplianceFormViewModel build() {
    return AuditSecurityComplianceFormViewModel();
  }

  Future<void> loadData() async {
        state = AuditSecurityComplianceFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-security-compliance-form-adapter');
      state = AuditSecurityComplianceFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = AuditSecurityComplianceFormViewModel(isLoading: false, data: {});
    }
  }
}

final auditSecurityComplianceFormAdapterProvider =
    NotifierProvider<
      AuditSecurityComplianceFormAdapter,
      AuditSecurityComplianceFormViewModel
    >(() {
      return AuditSecurityComplianceFormAdapter();
    });
