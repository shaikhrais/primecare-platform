// ignore_for_file: avoid_print
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  ScreenRegistry.bootstrap();
  final intents = GovernanceRegistry.getAllIntents();
  for (final intent in intents) {
    if (intent is PrimeCareScreen) {
      print('[${intent.route}] Provider: ${intent.provider != null ? "YES" : "NO"} | Labels: ${intent.componentLabels}');
    }
  }
}
