import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = AuditSystemLogsFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = AuditSystemLogsFormViewModel(isLoading: false, data: {});
  }
}

final auditSystemLogsFormAdapterProvider =
    NotifierProvider<AuditSystemLogsFormAdapter, AuditSystemLogsFormViewModel>(
      () {
        return AuditSystemLogsFormAdapter();
      },
    );
