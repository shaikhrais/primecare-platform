import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ScheduleClinicalAuditFormViewModel {
  final bool isLoading;
  final dynamic data;
  ScheduleClinicalAuditFormViewModel({this.isLoading = false, this.data});
}

class ScheduleClinicalAuditFormAdapter extends Notifier<ScheduleClinicalAuditFormViewModel> {
  @override
  ScheduleClinicalAuditFormViewModel build() {
    return ScheduleClinicalAuditFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ScheduleClinicalAuditFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ScheduleClinicalAuditFormViewModel(isLoading: false, data: {});
  }
}

final scheduleClinicalAuditFormAdapterProvider = NotifierProvider<ScheduleClinicalAuditFormAdapter, ScheduleClinicalAuditFormViewModel>(() {
  return ScheduleClinicalAuditFormAdapter();
});
