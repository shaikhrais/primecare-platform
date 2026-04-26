import 'package:primecare_ui/primecare_ui.dart';
// Layer: 04_VIEW_MODELS
import 'dart:async';
import '../../domain/models/02_M_physiotherapist_data.dart';
import '../../domain/models/02_M_physiotherapist_state.dart';
import '../../domain/repositories/03_D_physiotherapist_repository.dart';
import '../providers/03_D_providers.dart';

class PhysiotherapistNotifier extends Notifier<PhysiotherapistState>
    with ResilientNotifierMixin<PhysiotherapistState> {
  @override
  PhysiotherapistState build() => const PhysiotherapistState.initial();

  IPhysiotherapistRepository get _repository =>
      ref.watch(physiotherapistRepositoryProvider);

  Future<void> loadData() async {
    await guardHydration<PhysiotherapistData>(
      fetch: () => _repository.getPhysiotherapistData(),
      onSuccess: (PhysiotherapistData data) =>
          PhysiotherapistState.loaded(data: data),
      onError: (String message) => PhysiotherapistState.error(message),
      loadingState: const PhysiotherapistState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
