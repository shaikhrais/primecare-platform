import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class CreateRevenueReportFormViewModel {
  final bool isLoading;
  final dynamic data;
  CreateRevenueReportFormViewModel({this.isLoading = false, this.data});
}

class CreateRevenueReportFormAdapter
    extends Notifier<CreateRevenueReportFormViewModel> {
  @override
  CreateRevenueReportFormViewModel build() {
    return CreateRevenueReportFormViewModel();
  }

  Future<void> loadData() async {
    // TODO: Prisma API binding
    state = CreateRevenueReportFormViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = CreateRevenueReportFormViewModel(isLoading: false, data: {});
  }
}

final createRevenueReportFormAdapterProvider =
    NotifierProvider<
      CreateRevenueReportFormAdapter,
      CreateRevenueReportFormViewModel
    >(() {
      return CreateRevenueReportFormAdapter();
    });
