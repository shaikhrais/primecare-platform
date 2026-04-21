// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class DragAssignWidgetViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  DragAssignWidgetViewModel({this.isLoading = false, this.data});
}

class DragAssignWidgetAdapter extends Notifier<DragAssignWidgetViewModel> {
  @override
  DragAssignWidgetViewModel build() {
    return DragAssignWidgetViewModel();
  }

  Future<void> loadData() async {
        state = DragAssignWidgetViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/drag-assign-widget-adapter');
      state = DragAssignWidgetViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = DragAssignWidgetViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final dragAssignWidgetAdapterProvider =
    NotifierProvider<DragAssignWidgetAdapter, DragAssignWidgetViewModel>(() {
      return DragAssignWidgetAdapter();
    });
