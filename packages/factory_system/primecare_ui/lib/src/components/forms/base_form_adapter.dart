import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class BaseFormViewModel {
  final bool isLoading;
  final dynamic data;
  BaseFormViewModel({this.isLoading = false, this.data});
}

class BaseFormAdapter extends Notifier<BaseFormViewModel> {
  @override
  BaseFormViewModel build() {
    return BaseFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = BaseFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = BaseFormViewModel(isLoading: false, data: {});
  }
}

final baseFormAdapterProvider = NotifierProvider<BaseFormAdapter, BaseFormViewModel>(() {
  return BaseFormAdapter();
});
