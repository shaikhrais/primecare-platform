import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class CreateCannedResponseFormViewModel {
  final bool isLoading;
  final dynamic data;
  CreateCannedResponseFormViewModel({this.isLoading = false, this.data});
}

class CreateCannedResponseFormAdapter
    extends Notifier<CreateCannedResponseFormViewModel> {
  @override
  CreateCannedResponseFormViewModel build() {
    return CreateCannedResponseFormViewModel();
  }

  Future<void> loadData() async {
        state = CreateCannedResponseFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/create-canned-response-form-adapter');
      state = CreateCannedResponseFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = CreateCannedResponseFormViewModel(isLoading: false, data: {});
    }
  }
}

final createCannedResponseFormAdapterProvider =
    NotifierProvider<
      CreateCannedResponseFormAdapter,
      CreateCannedResponseFormViewModel
    >(() {
      return CreateCannedResponseFormAdapter();
    });
