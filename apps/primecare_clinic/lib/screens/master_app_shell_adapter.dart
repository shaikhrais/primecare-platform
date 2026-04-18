import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
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
    final telemetry = ref.read(executionGateProvider);
    telemetry.passGate(ExecutionGateCategory.navigationLayer, 'Fetching MasterAppShell Layout');

    state = MasterAppShellViewModel(isLoading: true, data: state.data);

    final result = await Result.guardFuture<dynamic>(() async {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get('/api/v1/metrics?route=MasterAppShell');
      if (response.statusCode == 200) return response.data;
        throw Exception('API error loading master app shell: ${response.statusCode}');
    });

    result.fold(
      (data) {
        state = MasterAppShellViewModel(isLoading: false, data: data);
      },
      (error) {
         telemetry.failGate(ExecutionGateCategory.navigationLayer, 'MasterAppShell Result Error', error: error);
         state = MasterAppShellViewModel(isLoading: false, data: {});
      }
    );
  }
}

final masterAppShellAdapterProvider = NotifierProvider<MasterAppShellAdapter, MasterAppShellViewModel>(() {
  return MasterAppShellAdapter();
});
