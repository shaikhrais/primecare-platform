// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class LogClinicalIncidentFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogClinicalIncidentFormViewModel({this.isLoading = false, this.data});
}

class LogClinicalIncidentFormAdapter
    extends Notifier<LogClinicalIncidentFormViewModel> {
  @override
  LogClinicalIncidentFormViewModel build() {
    return LogClinicalIncidentFormViewModel();
  }

  Future<void> loadData() async {
        state = LogClinicalIncidentFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/log-clinical-incident-form-adapter');
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = LogClinicalIncidentFormViewModel(isLoading: false, data: {});
    }
  }
}

final logClinicalIncidentFormAdapterProvider =
    NotifierProvider<
      LogClinicalIncidentFormAdapter,
      LogClinicalIncidentFormViewModel
    >(() {
      return LogClinicalIncidentFormAdapter();
    });
