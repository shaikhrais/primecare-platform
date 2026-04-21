// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class GreetingHeaderWidgetViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = GreetingHeaderWidgetViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = GreetingHeaderWidgetViewModel(isLoading: false, data: <String, dynamic>{});
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
