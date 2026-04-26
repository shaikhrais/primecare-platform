// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class CreateCustomInvoiceFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  CreateCustomInvoiceFormViewModel({this.isLoading = false, this.data});
}

class CreateCustomInvoiceFormAdapter
    extends Notifier<CreateCustomInvoiceFormViewModel> {
  @override
  CreateCustomInvoiceFormViewModel build() {
    return CreateCustomInvoiceFormViewModel();
  }

  Future<void> loadData() async {
    state = CreateCustomInvoiceFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get(
        '/api/v1/create-custom-invoice-form-adapter',
      );
      state = CreateCustomInvoiceFormViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = CreateCustomInvoiceFormViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final createCustomInvoiceFormAdapterProvider =
    NotifierProvider<
      CreateCustomInvoiceFormAdapter,
      CreateCustomInvoiceFormViewModel
    >(() {
      return CreateCustomInvoiceFormAdapter();
    });
