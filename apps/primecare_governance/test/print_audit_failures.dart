// ignore_for_file: avoid_print
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  final results = AutomatedAuditEngine.runAudits();
  for (final res in results) {
    if (!res.isPass) {
      print('[${res.check}] ${res.result}: ${res.meaning}');
    }
  }
}
