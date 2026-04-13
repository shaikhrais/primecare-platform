import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class SubmitDailyCensusFormViewModel {
  final bool isLoading;
  final dynamic data;
  SubmitDailyCensusFormViewModel({this.isLoading = false, this.data});
}

class SubmitDailyCensusFormAdapter extends Notifier<SubmitDailyCensusFormViewModel> {
  @override
  SubmitDailyCensusFormViewModel build() {
    return SubmitDailyCensusFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = SubmitDailyCensusFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SubmitDailyCensusFormViewModel(isLoading: false, data: {});
  }
}

final submitDailyCensusFormAdapterProvider = NotifierProvider<SubmitDailyCensusFormAdapter, SubmitDailyCensusFormViewModel>(() {
  return SubmitDailyCensusFormAdapter();
});
