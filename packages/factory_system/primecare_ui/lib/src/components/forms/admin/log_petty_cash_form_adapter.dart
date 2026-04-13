import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class LogPettyCashFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogPettyCashFormViewModel({this.isLoading = false, this.data});
}

class LogPettyCashFormAdapter extends Notifier<LogPettyCashFormViewModel> {
  @override
  LogPettyCashFormViewModel build() {
    return LogPettyCashFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = LogPettyCashFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = LogPettyCashFormViewModel(isLoading: false, data: {});
  }
}

final logPettyCashFormAdapterProvider = NotifierProvider<LogPettyCashFormAdapter, LogPettyCashFormViewModel>(() {
  return LogPettyCashFormAdapter();
});
