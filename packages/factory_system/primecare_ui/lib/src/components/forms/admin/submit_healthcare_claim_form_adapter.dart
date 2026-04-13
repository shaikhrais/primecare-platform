import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class SubmitHealthcareClaimFormViewModel {
  final bool isLoading;
  final dynamic data;
  SubmitHealthcareClaimFormViewModel({this.isLoading = false, this.data});
}

class SubmitHealthcareClaimFormAdapter extends Notifier<SubmitHealthcareClaimFormViewModel> {
  @override
  SubmitHealthcareClaimFormViewModel build() {
    return SubmitHealthcareClaimFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = SubmitHealthcareClaimFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SubmitHealthcareClaimFormViewModel(isLoading: false, data: {});
  }
}

final submitHealthcareClaimFormAdapterProvider = NotifierProvider<SubmitHealthcareClaimFormAdapter, SubmitHealthcareClaimFormViewModel>(() {
  return SubmitHealthcareClaimFormAdapter();
});
