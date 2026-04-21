// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/models/02_M_quality_assurance_state.dart';
import '../../domain/models/02_M_quality_assurance_data.dart';
import '../../domain/repositories/03_D_quality_assurance_repository.dart';
import '../providers/03_D_providers.dart';

class QualityAssuranceNotifier extends Notifier<QualityAssuranceState>
    with ResilientNotifierMixin<QualityAssuranceState> {
  @override
  QualityAssuranceState build() => const QualityAssuranceState.initial();

  IQualityAssuranceRepository get _repository =>
      ref.watch(qualityAssuranceRepositoryProvider);

  Future<void> loadData() async {
    // Fast-fail if offline
    if (!ref.read(isOnlineProvider)) {
      state = QualityAssuranceState.error('Offline: Data hydration aborted.');
      return;
    }

    await guardHydration<QualityAssuranceData>(
      fetch: () => _repository.getQualityAssuranceData(),
      onSuccess: (QualityAssuranceData data) =>
          QualityAssuranceState.loaded(data: data),
      onError: (String message) => QualityAssuranceState.error(message),
      loadingState: const QualityAssuranceState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
