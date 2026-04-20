import 'package:primecare_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Prisma Load Adapter

class CreateSupplyOrderFormViewModel {
  final bool isLoading;
  final dynamic data;
  CreateSupplyOrderFormViewModel({this.isLoading = false, this.data});
}

class CreateSupplyOrderFormAdapter
    extends Notifier<CreateSupplyOrderFormViewModel> {
  @override
  CreateSupplyOrderFormViewModel build() {
    return CreateSupplyOrderFormViewModel();
  }

  Future<void> loadData() async {
        state = CreateSupplyOrderFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/create-supply-order-form-adapter');
      state = CreateSupplyOrderFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = CreateSupplyOrderFormViewModel(isLoading: false, data: {});
    }
  }
}

final createSupplyOrderFormAdapterProvider =
    NotifierProvider<
      CreateSupplyOrderFormAdapter,
      CreateSupplyOrderFormViewModel
    >(() {
      return CreateSupplyOrderFormAdapter();
    });
