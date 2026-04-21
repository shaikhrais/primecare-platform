// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class MasterDetailLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  MasterDetailLayoutViewModel({this.isLoading = false, this.data});
}

class MasterDetailLayoutAdapter extends Notifier<MasterDetailLayoutViewModel> {
  @override
  MasterDetailLayoutViewModel build() {
    return MasterDetailLayoutViewModel();
  }

  Future<void> loadData() async {
        state = MasterDetailLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/master-detail-layout-adapter');
      state = MasterDetailLayoutViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = MasterDetailLayoutViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final masterDetailLayoutAdapterProvider =
    NotifierProvider<MasterDetailLayoutAdapter, MasterDetailLayoutViewModel>(
      () {
        return MasterDetailLayoutAdapter();
      },
    );
