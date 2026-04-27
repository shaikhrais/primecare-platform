// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

// Prisma Load Adapter

class SubmitAdlChecklistFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      final response = await client.get(
        '/api/v1/submit-adl-checklist-form-adapter',
      );
      state = SubmitAdlChecklistFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = SubmitAdlChecklistFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
