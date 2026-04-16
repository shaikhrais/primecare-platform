import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class GreetingHeaderWidgetViewModel {
  final bool isLoading;
  final dynamic data;
  GreetingHeaderWidgetViewModel({this.isLoading = false, this.data});
}

class GreetingHeaderWidgetAdapter
    extends Notifier<GreetingHeaderWidgetViewModel> {
  @override
  GreetingHeaderWidgetViewModel build() {
    return GreetingHeaderWidgetViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = GreetingHeaderWidgetViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = GreetingHeaderWidgetViewModel(isLoading: false, data: {});
  }
}

final greetingHeaderWidgetAdapterProvider =
    NotifierProvider<
      GreetingHeaderWidgetAdapter,
      GreetingHeaderWidgetViewModel
    >(() {
      return GreetingHeaderWidgetAdapter();
    });
