import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class MasterLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  MasterLayoutViewModel({this.isLoading = false, this.data});
}

class MasterLayoutAdapter extends Notifier<MasterLayoutViewModel> {
  @override
  MasterLayoutViewModel build() {
    return MasterLayoutViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = MasterLayoutViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = MasterLayoutViewModel(isLoading: false, data: {});
  }
}

final masterLayoutAdapterProvider =
    NotifierProvider<MasterLayoutAdapter, MasterLayoutViewModel>(() {
      return MasterLayoutAdapter();
    });
