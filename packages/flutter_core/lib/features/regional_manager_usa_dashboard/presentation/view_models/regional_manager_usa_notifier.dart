import '../../../../flutter_core.dart';
import '../../domain/repositories/regional_manager_usa_repository.dart';
import '../providers/providers.dart';

class RegionalManagerUsaNotifier
    extends Notifier<AsyncValue<RegionalManagerUsaDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<RegionalManagerUsaDashboardViewModel>
        > {
  @override
  AsyncValue<RegionalManagerUsaDashboardViewModel> build() {
    return AsyncValue.data(RegionalManagerUsaDashboardViewModel.empty());
  }

  IRegionalManagerUsaRepository get _repository =>
      ref.watch(regionalManagerUsaRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<RegionalManagerUsaDashboardViewModel>(
      fetch: () => _repository.getRegionalManagerUsaData(),
      onSuccess: (RegionalManagerUsaDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(RegionalManagerUsaDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
