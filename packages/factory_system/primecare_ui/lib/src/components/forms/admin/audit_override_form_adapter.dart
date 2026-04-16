import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = AuditOverrideFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = AuditOverrideFormViewModel(isLoading: false, data: {});
  }
}

final auditOverrideFormAdapterProvider =
    NotifierProvider<AuditOverrideFormAdapter, AuditOverrideFormViewModel>(() {
      return AuditOverrideFormAdapter();
    });
