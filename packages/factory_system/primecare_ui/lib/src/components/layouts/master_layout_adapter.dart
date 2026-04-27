// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
// Prisma Load Adapter

class MasterLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  MasterLayoutViewModel({this.isLoading = false, this.data});
}

class MasterLayoutAdapter extends Notifier<MasterLayoutViewModel> {
  @override
  MasterLayoutViewModel build() {
    return MasterLayoutViewModel();
  }

  Future<void> loadData() async {
    state = MasterLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/master-layout-adapter');
      state = MasterLayoutViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = MasterLayoutViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final masterLayoutAdapterProvider =
    NotifierProvider<MasterLayoutAdapter, MasterLayoutViewModel>(() {
      return MasterLayoutAdapter();
    });
