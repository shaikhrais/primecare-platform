// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';

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
