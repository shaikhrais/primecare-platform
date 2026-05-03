
import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/screen_registry.dart');
  if (!file.existsSync()) return;

  var content = file.readAsStringSync();

  // 4. Clinical Role remediation
  final clinicalRegex = RegExp(
    r"(title: '(?:Chiropractor|Physiotherapist|Rmt|Rn|Rpn|Psw)',[\s\S]*?pendingComponents: \[)(.*?)(\],)",
    multiLine: true,
  );

  content = content.replaceAllMapped(clinicalRegex, (match) {
    var pending = match.group(2) ?? '';
    if (!pending.contains('AnatomicalBodyMap')) {
      if (pending.isEmpty) {
        pending = "'AnatomicalBodyMap', 'ClinicalSessionTimer', 'TreatmentNoteEditor'";
      } else {
        pending += ", 'AnatomicalBodyMap', 'ClinicalSessionTimer', 'TreatmentNoteEditor'";
      }
    }
    return '${match.group(1)}$pending${match.group(3)}';
  });

  file.writeAsStringSync(content);
  print('Clinical remediation complete.');
}
