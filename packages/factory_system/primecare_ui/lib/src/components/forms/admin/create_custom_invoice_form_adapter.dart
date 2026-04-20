import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class CreateCustomInvoiceFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      final response = await client.get('/api/v1/create-custom-invoice-form-adapter');
      state = CreateCustomInvoiceFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = CreateCustomInvoiceFormViewModel(isLoading: false, data: {});
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
