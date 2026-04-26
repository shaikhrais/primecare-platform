// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class AuditSecurityComplianceFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  AuditSecurityComplianceFormViewModel({this.isLoading = false, this.data});
}

class AuditSecurityComplianceFormAdapter
    extends Notifier<AuditSecurityComplianceFormViewModel> {
  @override
  AuditSecurityComplianceFormViewModel build() {
    return AuditSecurityComplianceFormViewModel();
  }

  Future<void> loadData() async {
    state = AuditSecurityComplianceFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/audit-security-compliance-form-adapter',
      );
      state = AuditSecurityComplianceFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = AuditSecurityComplianceFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
