import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = AuditGlobalEducationFormViewModel(
      isLoading: true,
      data: state.data,
    );
    // Simulate fetch
    state = AuditGlobalEducationFormViewModel(isLoading: false, data: {});
  }
}

final auditGlobalEducationFormAdapterProvider =
    NotifierProvider<
      AuditGlobalEducationFormAdapter,
      AuditGlobalEducationFormViewModel
    >(() {
      return AuditGlobalEducationFormAdapter();
    });
