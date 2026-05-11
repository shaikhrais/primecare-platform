
import 'dart:io';

void main() {
  final file = File('apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart');
  var content = file.readAsStringSync();
  
  final regex = RegExp(r'ScreenMetadata\((.*?)\),', dotAll: true);
  
  final updatedContent = content.replaceAllMapped(regex, (match) {
    final block = match.group(1)!;
    if (!block.contains('isVirtual:')) {
      // Append isVirtual: true before the closing parenthesis
      return 'ScreenMetadata(${block.trimRight()}\n      isVirtual: true,\n    ),';
    }
    return match.group(0)!;
  });
  
  file.writeAsStringSync(updatedContent);
  print('Successfully ensured all screens have isVirtual: true where missing.');
}
