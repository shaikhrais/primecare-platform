import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class DragAssignWidgetViewModel {
  final bool isLoading;
  final dynamic data;
  DragAssignWidgetViewModel({this.isLoading = false, this.data});
}

class DragAssignWidgetAdapter extends Notifier<DragAssignWidgetViewModel> {
  @override
  DragAssignWidgetViewModel build() {
    return DragAssignWidgetViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = DragAssignWidgetViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = DragAssignWidgetViewModel(isLoading: false, data: {});
  }
}

final dragAssignWidgetAdapterProvider =
    NotifierProvider<DragAssignWidgetAdapter, DragAssignWidgetViewModel>(() {
      return DragAssignWidgetAdapter();
    });
