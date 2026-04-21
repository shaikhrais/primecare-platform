// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class CreateSupplyOrderFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = CreateSupplyOrderFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = CreateSupplyOrderFormViewModel(isLoading: false, data: <String, dynamic>{});
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
