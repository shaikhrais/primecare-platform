import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class LogInventorySpoilageFormViewModel {
  final bool isLoading;
  final dynamic data;
  LogInventorySpoilageFormViewModel({this.isLoading = false, this.data});
}

class LogInventorySpoilageFormAdapter
    extends Notifier<LogInventorySpoilageFormViewModel> {
  @override
  LogInventorySpoilageFormViewModel build() {
    return LogInventorySpoilageFormViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = LogInventorySpoilageFormViewModel(
      isLoading: true,
      data: state.data,
    );
    // Simulate fetch
    state = LogInventorySpoilageFormViewModel(isLoading: false, data: {});
  }
}

final logInventorySpoilageFormAdapterProvider =
    NotifierProvider<
      LogInventorySpoilageFormAdapter,
      LogInventorySpoilageFormViewModel
    >(() {
      return LogInventorySpoilageFormAdapter();
    });
