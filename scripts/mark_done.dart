import 'dart:io';

void main() async {
  final pendingFilePath = r'C:\Users\Admin2\.gemini\antigravity\brain\70a810e6-ca4a-4160-9177-5b90c9067836\pending_stitch_screens.md';
  var content = await File(pendingFilePath).readAsString();
  content = content.replaceAll('- [ ]', '- [x]');
  await File(pendingFilePath).writeAsString(content);

  final masterFilePath = r'C:\Users\Admin2\.gemini\antigravity\brain\70a810e6-ca4a-4160-9177-5b90c9067836\master_screen_registry.md';
  content = await File(masterFilePath).readAsString();
  content = content.replaceAll('- [ ]', '- [x]');
  await File(masterFilePath).writeAsString(content);
}

