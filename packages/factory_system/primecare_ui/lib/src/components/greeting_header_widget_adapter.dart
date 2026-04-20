import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
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
        state = GreetingHeaderWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/greeting-header-widget-adapter');
      state = GreetingHeaderWidgetViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = GreetingHeaderWidgetViewModel(isLoading: false, data: {});
    }
  }
}

final greetingHeaderWidgetAdapterProvider =
    NotifierProvider<
      GreetingHeaderWidgetAdapter,
      GreetingHeaderWidgetViewModel
    >(() {
      return GreetingHeaderWidgetAdapter();
    });
