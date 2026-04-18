import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuditSystemLogsFormViewModel {
  final bool isLoading;
  final dynamic data;
  AuditSystemLogsFormViewModel({this.isLoading = false, this.data});
}

class AuditSystemLogsFormAdapter
    extends Notifier<AuditSystemLogsFormViewModel> {
  @override
  AuditSystemLogsFormViewModel build() {
    return AuditSystemLogsFormViewModel();
  }

  Future<void> loadData() async {
        state = AuditSystemLogsFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/audit-system-logs-form-adapter');
      state = AuditSystemLogsFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AuditSystemLogsFormViewModel(isLoading: false, data: {});
    }
  }
}

final auditSystemLogsFormAdapterProvider =
    NotifierProvider<AuditSystemLogsFormAdapter, AuditSystemLogsFormViewModel>(
      () {
        return AuditSystemLogsFormAdapter();
      },
    );
