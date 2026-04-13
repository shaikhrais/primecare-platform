import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class MasterAppShellViewModel {
  final bool isLoading;
  final dynamic data;
  MasterAppShellViewModel({this.isLoading = false, this.data});
}

class MasterAppShellAdapter extends Notifier<MasterAppShellViewModel> {
  @override
  MasterAppShellViewModel build() {
    return MasterAppShellViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = MasterAppShellViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = MasterAppShellViewModel(isLoading: false, data: {});
  }
}

final masterAppShellAdapterProvider = NotifierProvider<MasterAppShellAdapter, MasterAppShellViewModel>(() {
  return MasterAppShellAdapter();
});
