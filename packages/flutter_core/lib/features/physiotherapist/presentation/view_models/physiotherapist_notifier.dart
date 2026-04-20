import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src/resilience/resilient_notifier_mixin.dart';
import '../../../../telemetry_service.dart';
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
