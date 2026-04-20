// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class SubmitAdlChecklistFormViewModel {
  final bool isLoading;
  final dynamic data;
  SubmitAdlChecklistFormViewModel({this.isLoading = false, this.data});
}

class SubmitAdlChecklistFormAdapter
    extends Notifier<SubmitAdlChecklistFormViewModel> {
  @override
  SubmitAdlChecklistFormViewModel build() {
    return SubmitAdlChecklistFormViewModel();
  }

  Future<void> loadData() async {
        state = SubmitAdlChecklistFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/submit-adl-checklist-form-adapter');
      state = SubmitAdlChecklistFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SubmitAdlChecklistFormViewModel(isLoading: false, data: {});
    }
  }
}

final submitAdlChecklistFormAdapterProvider =
    NotifierProvider<
      SubmitAdlChecklistFormAdapter,
      SubmitAdlChecklistFormViewModel
    >(() {
      return SubmitAdlChecklistFormAdapter();
    });
