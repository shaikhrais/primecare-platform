import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class LogClinicalIncidentFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class LogClinicalIncidentFormAdapter extends Notifier<LogClinicalIncidentFormViewModel> {
  @override
  LogClinicalIncidentFormViewModel build() {
    return LogClinicalIncidentFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = LogClinicalIncidentFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = LogClinicalIncidentFormViewModel(isLoading: false, data: {});
  }
}

final logClinicalIncidentFormAdapterProvider = NotifierProvider<LogClinicalIncidentFormAdapter, LogClinicalIncidentFormViewModel>(() {
  return LogClinicalIncidentFormAdapter();
});
