// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class MoodSliderWidgetViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = MoodSliderWidgetViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = MoodSliderWidgetViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final moodSliderWidgetAdapterProvider =
    NotifierProvider<MoodSliderWidgetAdapter, MoodSliderWidgetViewModel>(() {
      return MoodSliderWidgetAdapter();
    });
