// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class AuditGlobalEducationFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  AuditGlobalEducationFormViewModel({this.isLoading = false, this.data});
}

class AuditGlobalEducationFormAdapter
    extends Notifier<AuditGlobalEducationFormViewModel> {
  @override
  AuditGlobalEducationFormViewModel build() {
    return AuditGlobalEducationFormViewModel();
  }

  Future<void> loadData() async {
        state = AuditGlobalEducationFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-global-education-form-adapter');
      state = AuditGlobalEducationFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = AuditGlobalEducationFormViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final auditGlobalEducationFormAdapterProvider =
    NotifierProvider<
      AuditGlobalEducationFormAdapter,
      AuditGlobalEducationFormViewModel
    >(() {
      return AuditGlobalEducationFormAdapter();
    });
