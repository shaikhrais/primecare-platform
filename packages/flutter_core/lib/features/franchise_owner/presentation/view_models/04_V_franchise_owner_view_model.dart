// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/models/02_M_franchise_owner_data.dart';
import '../../domain/models/02_M_franchise_owner_state.dart';
import '../../domain/repositories/03_D_franchise_owner_repository.dart';
import '../providers/03_D_repository_providers.dart';

class FranchiseOwnerViewModel extends Notifier<FranchiseOwnerState>
    with ResilientNotifierMixin<FranchiseOwnerState> {
  @override
  FranchiseOwnerState build() => const FranchiseOwnerState.initial();

  IFranchiseOwnerRepository get _repository =>
      ref.watch(franchiseOwnerRepositoryProvider);

  Future<void> loadData() async {
    final bool isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = const FranchiseOwnerState.error(
        'Offline. Franchise Owner dashboard requires an active connection.',
      );
      return;
    }

    await guardHydration<DomainResponse>(
      fetch: () => _repository.getFranchiseOwnerData(),
      onSuccess: (DomainResponse data) => FranchiseOwnerState.loaded(
        data: FranchiseOwnerData(metrics: data.data),
      ),
      onError: (String message) => FranchiseOwnerState.error(message),
      loadingState: const FranchiseOwnerState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
