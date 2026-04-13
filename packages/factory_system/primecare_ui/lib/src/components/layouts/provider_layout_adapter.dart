import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ProviderLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  ProviderLayoutViewModel({this.isLoading = false, this.data});
}

class ProviderLayoutAdapter extends Notifier<ProviderLayoutViewModel> {
  @override
  ProviderLayoutViewModel build() {
    return ProviderLayoutViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ProviderLayoutViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ProviderLayoutViewModel(isLoading: false, data: {});
  }
}

final providerLayoutAdapterProvider = NotifierProvider<ProviderLayoutAdapter, ProviderLayoutViewModel>(() {
  return ProviderLayoutAdapter();
});
