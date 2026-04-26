// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class EtaTrackerWidgetViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  EtaTrackerWidgetViewModel({this.isLoading = false, this.data});
}

class EtaTrackerWidgetAdapter extends Notifier<EtaTrackerWidgetViewModel> {
  @override
  EtaTrackerWidgetViewModel build() {
    return EtaTrackerWidgetViewModel();
  }

  Future<void> loadData() async {
    state = EtaTrackerWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/eta-tracker-widget-adapter');
      state = EtaTrackerWidgetViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = EtaTrackerWidgetViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final etaTrackerWidgetAdapterProvider =
    NotifierProvider<EtaTrackerWidgetAdapter, EtaTrackerWidgetViewModel>(() {
      return EtaTrackerWidgetAdapter();
    });
