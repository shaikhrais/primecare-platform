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
    // TODO: Prisma API binding
    state = CreateSupplyOrderFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = CreateSupplyOrderFormViewModel(isLoading: false, data: {});
  }
}

final createSupplyOrderFormAdapterProvider =
    NotifierProvider<
      CreateSupplyOrderFormAdapter,
      CreateSupplyOrderFormViewModel
    >(() {
      return CreateSupplyOrderFormAdapter();
    });
