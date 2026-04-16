import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class MasterDetailLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  MasterDetailLayoutViewModel({this.isLoading = false, this.data});
}

class MasterDetailLayoutAdapter extends Notifier<MasterDetailLayoutViewModel> {
  @override
  MasterDetailLayoutViewModel build() {
    return MasterDetailLayoutViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = MasterDetailLayoutViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = MasterDetailLayoutViewModel(isLoading: false, data: {});
  }
}

final masterDetailLayoutAdapterProvider =
    NotifierProvider<MasterDetailLayoutAdapter, MasterDetailLayoutViewModel>(
      () {
        return MasterDetailLayoutAdapter();
      },
    );
