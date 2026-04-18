import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
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
        state = LogPettyCashFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/log-petty-cash-form-adapter');
      state = LogPettyCashFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = LogPettyCashFormViewModel(isLoading: false, data: {});
    }
  }
}

final logPettyCashFormAdapterProvider =
    NotifierProvider<LogPettyCashFormAdapter, LogPettyCashFormViewModel>(() {
      return LogPettyCashFormAdapter();
    });
