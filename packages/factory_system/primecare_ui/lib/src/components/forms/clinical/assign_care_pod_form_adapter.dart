import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AssignCarePodFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = AssignCarePodFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AssignCarePodFormViewModel(isLoading: false, data: {});
    }
  }
}

final assignCarePodFormAdapterProvider =
    NotifierProvider<AssignCarePodFormAdapter, AssignCarePodFormViewModel>(() {
      return AssignCarePodFormAdapter();
    });
