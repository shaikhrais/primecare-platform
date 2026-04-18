import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuditGlobalEducationFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditGlobalEducationFormViewModel({this.isLoading = false, this.data});
}

class AuditGlobalEducationFormAdapter
    extends Notifier<AuditGlobalEducationFormViewModel> {
  @override
  AuditGlobalEducationFormViewModel build() {
    return AuditGlobalEducationFormViewModel();
  }

  Future<void> loadData() async {
        state = dynamic(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-global-education-form-adapter');
      state = dynamic(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = dynamic(isLoading: false, data: {});
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
