import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ClientLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  ClientLayoutViewModel({this.isLoading = false, this.data});
}

class ClientLayoutAdapter extends Notifier<ClientLayoutViewModel> {
  @override
  ClientLayoutViewModel build() {
    return ClientLayoutViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = ClientLayoutViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = ClientLayoutViewModel(isLoading: false, data: {});
  }
}

final clientLayoutAdapterProvider =
    NotifierProvider<ClientLayoutAdapter, ClientLayoutViewModel>(() {
      return ClientLayoutAdapter();
    });
