part of '../../aura_providers.dart';

/// Global toggle state to snooze Aura HUD alerts.
class AuraSnoozeNotifier extends BaseValueNotifier<bool> {
  @override
  bool get initialValue => false;
}
