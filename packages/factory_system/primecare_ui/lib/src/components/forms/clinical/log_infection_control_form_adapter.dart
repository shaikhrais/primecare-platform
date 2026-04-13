import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class LogInfectionControlFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogInfectionControlFormViewModel({this.isLoading = false, this.data});
}

class LogInfectionControlFormAdapter extends Notifier<LogInfectionControlFormViewModel> {
  @override
  LogInfectionControlFormViewModel build() {
    return LogInfectionControlFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = LogInfectionControlFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = LogInfectionControlFormViewModel(isLoading: false, data: {});
  }
}

final logInfectionControlFormAdapterProvider = NotifierProvider<LogInfectionControlFormAdapter, LogInfectionControlFormViewModel>(() {
  return LogInfectionControlFormAdapter();
});
