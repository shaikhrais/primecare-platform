import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AssignCarePodFormViewModel {
  final bool isLoading;
  final dynamic data;
  AssignCarePodFormViewModel({this.isLoading = false, this.data});
}

class AssignCarePodFormAdapter extends Notifier<AssignCarePodFormViewModel> {
  @override
  AssignCarePodFormViewModel build() {
    return AssignCarePodFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AssignCarePodFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AssignCarePodFormViewModel(isLoading: false, data: {});
  }
}

final assignCarePodFormAdapterProvider = NotifierProvider<AssignCarePodFormAdapter, AssignCarePodFormViewModel>(() {
  return AssignCarePodFormAdapter();
});
