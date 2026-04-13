import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class CreateCustomInvoiceFormViewModel {
  final bool isLoading;
  final dynamic data;
  CreateCustomInvoiceFormViewModel({this.isLoading = false, this.data});
}

class CreateCustomInvoiceFormAdapter extends Notifier<CreateCustomInvoiceFormViewModel> {
  @override
  CreateCustomInvoiceFormViewModel build() {
    return CreateCustomInvoiceFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = CreateCustomInvoiceFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = CreateCustomInvoiceFormViewModel(isLoading: false, data: {});
  }
}

final createCustomInvoiceFormAdapterProvider = NotifierProvider<CreateCustomInvoiceFormAdapter, CreateCustomInvoiceFormViewModel>(() {
  return CreateCustomInvoiceFormAdapter();
});
