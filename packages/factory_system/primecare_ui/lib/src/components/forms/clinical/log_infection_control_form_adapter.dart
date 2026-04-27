// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class LogInfectionControlFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      final response = await client.get(
        '/api/v1/log-infection-control-form-adapter',
      );
      state = LogInfectionControlFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = LogInfectionControlFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
