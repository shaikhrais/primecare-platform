import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class SlideToClockInWidgetViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = SlideToClockInWidgetViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SlideToClockInWidgetViewModel(isLoading: false, data: {});
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
