import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
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
        state = dynamic(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-security-compliance-form-adapter');
      state = dynamic(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = dynamic(isLoading: false, data: {});
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
