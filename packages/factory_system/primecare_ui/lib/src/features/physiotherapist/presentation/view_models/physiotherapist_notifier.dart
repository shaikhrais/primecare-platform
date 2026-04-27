import 'package:primecare_ui/primecare_ui.dart';
// Layer: 04_VIEW_MODELS
import 'dart:async';
import '../../domain/models/physiotherapist_data.dart';
import '../../domain/models/physiotherapist_state.dart';
import '../../domain/repositories/physiotherapist_repository.dart';
import '../providers/providers.dart';

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
