import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = MoodSliderWidgetViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = MoodSliderWidgetViewModel(isLoading: false, data: {});
  }
}

final moodSliderWidgetAdapterProvider =
    NotifierProvider<MoodSliderWidgetAdapter, MoodSliderWidgetViewModel>(() {
      return MoodSliderWidgetAdapter();
    });
