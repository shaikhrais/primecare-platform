// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
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
