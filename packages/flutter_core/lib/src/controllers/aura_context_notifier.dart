part of '../../aura_providers.dart';

/// Track the current institutional context (e.g., active office or feature).
/// This allows Aura to surface screen-specific insights and commands.
class AuraContextNotifier extends BaseValueNotifier<String?> {
  @override
  String? get initialValue => null;

}
