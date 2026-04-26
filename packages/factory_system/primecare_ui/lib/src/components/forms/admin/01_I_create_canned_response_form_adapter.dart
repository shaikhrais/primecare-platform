// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class CreateCannedResponseFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  CreateCannedResponseFormViewModel({this.isLoading = false, this.data});
}

class CreateCannedResponseFormAdapter
    extends Notifier<CreateCannedResponseFormViewModel> {
  @override
  CreateCannedResponseFormViewModel build() {
    return CreateCannedResponseFormViewModel();
  }

  Future<void> loadData() async {
    state = CreateCannedResponseFormViewModel(
      isLoading: true,
      data: state.data,
    );
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/create-canned-response-form-adapter',
      );
      state = CreateCannedResponseFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = CreateCannedResponseFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
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
