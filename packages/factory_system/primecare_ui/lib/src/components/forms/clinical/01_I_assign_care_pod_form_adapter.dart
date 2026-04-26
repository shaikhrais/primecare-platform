// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class AssignCarePodFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  AssignCarePodFormViewModel({this.isLoading = false, this.data});
}

class AssignCarePodFormAdapter extends Notifier<AssignCarePodFormViewModel> {
  @override
  AssignCarePodFormViewModel build() {
    return AssignCarePodFormViewModel();
  }

  Future<void> loadData() async {
    state = AssignCarePodFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/assign-care-pod-form-adapter');
      state = AssignCarePodFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = AssignCarePodFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final assignCarePodFormAdapterProvider =
    NotifierProvider<AssignCarePodFormAdapter, AssignCarePodFormViewModel>(() {
      return AssignCarePodFormAdapter();
    });
