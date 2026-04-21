// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class CreateRevenueReportFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  CreateRevenueReportFormViewModel({this.isLoading = false, this.data});
}

class CreateRevenueReportFormAdapter
    extends Notifier<CreateRevenueReportFormViewModel> {
  @override
  CreateRevenueReportFormViewModel build() {
    return CreateRevenueReportFormViewModel();
  }

  Future<void> loadData() async {
        state = CreateRevenueReportFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/create-revenue-report-form-adapter');
      state = CreateRevenueReportFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = CreateRevenueReportFormViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final createRevenueReportFormAdapterProvider =
    NotifierProvider<
      CreateRevenueReportFormAdapter,
      CreateRevenueReportFormViewModel
    >(() {
      return CreateRevenueReportFormAdapter();
    });
