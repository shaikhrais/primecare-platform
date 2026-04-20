import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class LogInventorySpoilageFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogInventorySpoilageFormViewModel({this.isLoading = false, this.data});
}

class LogInventorySpoilageFormAdapter
    extends Notifier<LogInventorySpoilageFormViewModel> {
  @override
  LogInventorySpoilageFormViewModel build() {
    return LogInventorySpoilageFormViewModel();
  }

  Future<void> loadData() async {
        state = LogInventorySpoilageFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/log-inventory-spoilage-form-adapter');
      state = LogInventorySpoilageFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = LogInventorySpoilageFormViewModel(isLoading: false, data: {});
    }
  }
}

final logInventorySpoilageFormAdapterProvider =
    NotifierProvider<
      LogInventorySpoilageFormAdapter,
      LogInventorySpoilageFormViewModel
    >(() {
      return LogInventorySpoilageFormAdapter();
    });
