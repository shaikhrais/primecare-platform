// Layer: 05_UI_PRESENTATION
import 'package:primecare_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class MfaScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  MfaScreenViewModel({this.isLoading = false, this.data});
}

class MfaScreenAdapter extends Notifier<MfaScreenViewModel> {
  @override
  MfaScreenViewModel build() {
    return MfaScreenViewModel();
  }

  Future<void> loadData() async {
        state = MfaScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/mfa-screen-adapter');
      state = MfaScreenViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = MfaScreenViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final mfaScreenAdapterProvider =
    NotifierProvider<MfaScreenAdapter, MfaScreenViewModel>(() {
      return MfaScreenAdapter();
    });
