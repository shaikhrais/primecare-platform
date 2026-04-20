// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/primecare_core.dart';
// Prisma Load Adapter

class MasterDashboardPageViewModel {
  final bool isLoading;
  final dynamic data;
  MasterDashboardPageViewModel({this.isLoading = false, this.data});
}

class MasterDashboardPageAdapter extends Notifier<MasterDashboardPageViewModel> {
  @override
  MasterDashboardPageViewModel build() {
    return MasterDashboardPageViewModel();
  }

  Future<void> loadData() async {
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(ExecutionGateCategory.navigationLayer, 'Fetching Master Dashboard Layout');

    state = MasterDashboardPageViewModel(isLoading: true, data: state.data);

    final result = await Result.guardFuture<dynamic>(() async {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get('/api/v1/metrics?route=MasterDashboard');
      if (response.statusCode == 200) return response.data;
      throw Exception('API error loading master dashboard: ${response.statusCode}');
    });

    result.fold(
      (data) {
        state = MasterDashboardPageViewModel(isLoading: false, data: data);
      },
      (error) {
         telemetry.failGate(ExecutionGateCategory.navigationLayer, 'MasterDashboard Result Error', error: error);
         state = MasterDashboardPageViewModel(isLoading: false, data: {});
      }
    );
  }
}

final masterDashboardPageAdapterProvider = NotifierProvider<MasterDashboardPageAdapter, MasterDashboardPageViewModel>(() {
  return MasterDashboardPageAdapter();
});

// Styled with global Theme and CustomColors.
