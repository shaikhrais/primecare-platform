import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class ClientLayoutViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = ClientLayoutViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = ClientLayoutViewModel(isLoading: false, data: {});
    }
  }
}

final clientLayoutAdapterProvider =
    NotifierProvider<ClientLayoutAdapter, ClientLayoutViewModel>(() {
      return ClientLayoutAdapter();
    });
