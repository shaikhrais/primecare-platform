import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final auraVisionProvider = NotifierProvider<AuraVisionNotifier, AuraVisionMode>(() {
  return AuraVisionNotifier();
});

class AuraVisionNotifier extends Notifier<AuraVisionMode> {
  @override
  AuraVisionMode build() => AuraVisionMode.live;

  void setMode(AuraVisionMode mode) {
    state = mode;
  }
}
