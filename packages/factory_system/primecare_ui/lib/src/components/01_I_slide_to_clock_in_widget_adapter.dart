// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class SlideToClockInWidgetViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  SlideToClockInWidgetViewModel({this.isLoading = false, this.data});
}

class SlideToClockInWidgetAdapter
    extends Notifier<SlideToClockInWidgetViewModel> {
  @override
  SlideToClockInWidgetViewModel build() {
    return SlideToClockInWidgetViewModel();
  }

  Future<void> loadData() async {
        state = SlideToClockInWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/slide-to-clock-in-widget-adapter');
      state = SlideToClockInWidgetViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = SlideToClockInWidgetViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final slideToClockInWidgetAdapterProvider =
    NotifierProvider<
      SlideToClockInWidgetAdapter,
      SlideToClockInWidgetViewModel
    >(() {
      return SlideToClockInWidgetAdapter();
    });
