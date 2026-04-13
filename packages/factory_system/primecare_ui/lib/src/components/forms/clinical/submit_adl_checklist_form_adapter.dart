import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class SubmitAdlChecklistFormViewModel {
  final bool isLoading;
  final dynamic data;
  SubmitAdlChecklistFormViewModel({this.isLoading = false, this.data});
}

class SubmitAdlChecklistFormAdapter extends Notifier<SubmitAdlChecklistFormViewModel> {
  @override
  SubmitAdlChecklistFormViewModel build() {
    return SubmitAdlChecklistFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = SubmitAdlChecklistFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SubmitAdlChecklistFormViewModel(isLoading: false, data: {});
  }
}

final submitAdlChecklistFormAdapterProvider = NotifierProvider<SubmitAdlChecklistFormAdapter, SubmitAdlChecklistFormViewModel>(() {
  return SubmitAdlChecklistFormAdapter();
});
