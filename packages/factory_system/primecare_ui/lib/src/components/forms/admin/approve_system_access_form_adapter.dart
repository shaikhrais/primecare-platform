import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ApproveSystemAccessFormViewModel {
  final bool isLoading;
  final dynamic data;
  ApproveSystemAccessFormViewModel({this.isLoading = false, this.data});
}

class ApproveSystemAccessFormAdapter
    extends Notifier<ApproveSystemAccessFormViewModel> {
  @override
  ApproveSystemAccessFormViewModel build() {
    return ApproveSystemAccessFormViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = ApproveSystemAccessFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = ApproveSystemAccessFormViewModel(isLoading: false, data: {});
  }
}

final approveSystemAccessFormAdapterProvider =
    NotifierProvider<
      ApproveSystemAccessFormAdapter,
      ApproveSystemAccessFormViewModel
    >(() {
      return ApproveSystemAccessFormAdapter();
    });
