import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class MfaScreenViewModel {
  final bool isLoading;
  final dynamic data;
  MfaScreenViewModel({this.isLoading = false, this.data});
}

class MfaScreenAdapter extends Notifier<MfaScreenViewModel> {
  @override
  MfaScreenViewModel build() {
    return MfaScreenViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = MfaScreenViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = MfaScreenViewModel(isLoading: false, data: {});
  }
}

final mfaScreenAdapterProvider =
    NotifierProvider<MfaScreenAdapter, MfaScreenViewModel>(() {
      return MfaScreenAdapter();
    });
