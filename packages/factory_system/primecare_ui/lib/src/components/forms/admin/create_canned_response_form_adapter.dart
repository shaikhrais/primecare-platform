import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class CreateCannedResponseFormViewModel {
  final bool isLoading;
  final dynamic data;
  CreateCannedResponseFormViewModel({this.isLoading = false, this.data});
}

class CreateCannedResponseFormAdapter extends Notifier<CreateCannedResponseFormViewModel> {
  @override
  CreateCannedResponseFormViewModel build() {
    return CreateCannedResponseFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = CreateCannedResponseFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = CreateCannedResponseFormViewModel(isLoading: false, data: {});
  }
}

final createCannedResponseFormAdapterProvider = NotifierProvider<CreateCannedResponseFormAdapter, CreateCannedResponseFormViewModel>(() {
  return CreateCannedResponseFormAdapter();
});
