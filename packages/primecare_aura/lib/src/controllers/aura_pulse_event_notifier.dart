part of '../../aura_providers.dart';

/// A notifier that tracks the most recent Aura heartbeat event.
class AuraPulseEventNotifier extends BaseValueNotifier<AuraEvent?> {
  @override
  AuraEvent? get initialValue => null;
  @override
  void update(covariant AuraEvent event) => super.update(event);
}
