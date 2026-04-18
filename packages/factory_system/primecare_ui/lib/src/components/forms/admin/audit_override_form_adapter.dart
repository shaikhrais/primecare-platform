import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuditOverrideFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditOverrideFormViewModel({this.isLoading = false, this.data});
}

class AuditOverrideFormAdapter extends Notifier<AuditOverrideFormViewModel> {
  @override
  AuditOverrideFormViewModel build() {
    return AuditOverrideFormViewModel();
  }

  Future<void> loadData() async {
        state = AuditOverrideFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-override-form-adapter');
      state = AuditOverrideFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AuditOverrideFormViewModel(isLoading: false, data: {});
    }
  }
}

final auditOverrideFormAdapterProvider =
    NotifierProvider<AuditOverrideFormAdapter, AuditOverrideFormViewModel>(() {
      return AuditOverrideFormAdapter();
    });
