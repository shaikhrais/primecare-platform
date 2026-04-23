// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class ClientLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ClientLayoutViewModel({this.isLoading = false, this.data});
}

class ClientLayoutAdapter extends Notifier<ClientLayoutViewModel> {
  @override
  ClientLayoutViewModel build() {
    return ClientLayoutViewModel();
  }

  Future<void> loadData() async {
        state = ClientLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/client-layout-adapter');
      state = ClientLayoutViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = ClientLayoutViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final clientLayoutAdapterProvider =
    NotifierProvider<ClientLayoutAdapter, ClientLayoutViewModel>(() {
      return ClientLayoutAdapter();
    });
