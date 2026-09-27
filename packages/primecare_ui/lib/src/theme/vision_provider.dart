// Governance - Category: controller | Purpose: Core implementation file for the Vision Provider platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final auraVisionProvider = NotifierProvider<AuraVisionNotifier, AuraVisionMode>(
  () {
    return AuraVisionNotifier();
  },
);

class AuraVisionNotifier extends Notifier<AuraVisionMode> {
  @override
  AuraVisionMode build() => AuraVisionMode.live;

  void setMode(AuraVisionMode mode) {
    state = mode;
  }
}
