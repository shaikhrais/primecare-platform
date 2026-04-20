import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class MoodSliderWidgetViewModel {
  final bool isLoading;
  final dynamic data;
  MoodSliderWidgetViewModel({this.isLoading = false, this.data});
}

class MoodSliderWidgetAdapter extends Notifier<MoodSliderWidgetViewModel> {
  @override
  MoodSliderWidgetViewModel build() {
    return MoodSliderWidgetViewModel();
  }

  Future<void> loadData() async {
        state = MoodSliderWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/mood-slider-widget-adapter');
      state = MoodSliderWidgetViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = MoodSliderWidgetViewModel(isLoading: false, data: {});
    }
  }
}

final moodSliderWidgetAdapterProvider =
    NotifierProvider<MoodSliderWidgetAdapter, MoodSliderWidgetViewModel>(() {
      return MoodSliderWidgetAdapter();
    });
