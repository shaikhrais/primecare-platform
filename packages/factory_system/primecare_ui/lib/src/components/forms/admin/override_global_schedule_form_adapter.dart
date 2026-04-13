import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class OverrideGlobalScheduleFormViewModel {
  final bool isLoading;
  final dynamic data;
  OverrideGlobalScheduleFormViewModel({this.isLoading = false, this.data});
}

class OverrideGlobalScheduleFormAdapter extends Notifier<OverrideGlobalScheduleFormViewModel> {
  @override
  OverrideGlobalScheduleFormViewModel build() {
    return OverrideGlobalScheduleFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = OverrideGlobalScheduleFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = OverrideGlobalScheduleFormViewModel(isLoading: false, data: {});
  }
}

final overrideGlobalScheduleFormAdapterProvider = NotifierProvider<OverrideGlobalScheduleFormAdapter, OverrideGlobalScheduleFormViewModel>(() {
  return OverrideGlobalScheduleFormAdapter();
});
