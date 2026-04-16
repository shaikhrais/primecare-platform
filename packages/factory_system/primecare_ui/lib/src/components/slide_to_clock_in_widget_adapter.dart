import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = SlideToClockInWidgetViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = SlideToClockInWidgetViewModel(isLoading: false, data: {});
  }
}

final slideToClockInWidgetAdapterProvider =
    NotifierProvider<
      SlideToClockInWidgetAdapter,
      SlideToClockInWidgetViewModel
    >(() {
      return SlideToClockInWidgetAdapter();
    });
