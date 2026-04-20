import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class EtaTrackerWidgetViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = EtaTrackerWidgetViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = EtaTrackerWidgetViewModel(isLoading: false, data: {});
    }
  }
}

final etaTrackerWidgetAdapterProvider =
    NotifierProvider<EtaTrackerWidgetAdapter, EtaTrackerWidgetViewModel>(() {
      return EtaTrackerWidgetAdapter();
    });
