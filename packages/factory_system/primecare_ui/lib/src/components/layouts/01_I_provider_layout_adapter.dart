// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class ProviderLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ProviderLayoutViewModel({this.isLoading = false, this.data});
}

class ProviderLayoutAdapter extends Notifier<ProviderLayoutViewModel> {
  @override
  ProviderLayoutViewModel build() {
    return ProviderLayoutViewModel();
  }

  Future<void> loadData() async {
    state = ProviderLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/provider-layout-adapter');
      state = ProviderLayoutViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = ProviderLayoutViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final providerLayoutAdapterProvider =
    NotifierProvider<ProviderLayoutAdapter, ProviderLayoutViewModel>(() {
      return ProviderLayoutAdapter();
    });
