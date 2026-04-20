import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class LogInfectionControlFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogInfectionControlFormViewModel({this.isLoading = false, this.data});
}

class LogInfectionControlFormAdapter
    extends Notifier<LogInfectionControlFormViewModel> {
  @override
  LogInfectionControlFormViewModel build() {
    return LogInfectionControlFormViewModel();
  }

  Future<void> loadData() async {
        state = LogInfectionControlFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/log-infection-control-form-adapter');
      state = LogInfectionControlFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = LogInfectionControlFormViewModel(isLoading: false, data: {});
    }
  }
}

final logInfectionControlFormAdapterProvider =
    NotifierProvider<
      LogInfectionControlFormAdapter,
      LogInfectionControlFormViewModel
    >(() {
      return LogInfectionControlFormAdapter();
    });
