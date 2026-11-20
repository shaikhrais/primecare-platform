import 'dart:convert';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';

/// Layout files carry only the bounded, validated presentation contract.
class WorkspaceFiles {
  static bool get canExportFile => kIsWeb || [TargetPlatform.windows,
    TargetPlatform.linux, TargetPlatform.macOS].contains(defaultTargetPlatform);
  static Future<bool> exportJson(String json) async {
    if (!canExportFile) throw UnsupportedError('Use Copy JSON on this platform');
    const filename = 'primecare-layout.json';
    final file = XFile.fromData(Uint8List.fromList(utf8.encode(json)),
      mimeType: 'application/json', name: filename);
    if (kIsWeb) { await file.saveTo(filename); return true; }
    final target = await getSaveLocation(suggestedName: filename,
      acceptedTypeGroups: const [XTypeGroup(label: 'Layout JSON', extensions: ['json'])]);
    if (target == null) return false;
    await file.saveTo(target.path); return true;
  }
  static Future<String?> importJson() async {
    final file = await openFile(acceptedTypeGroups: const [
      XTypeGroup(label: 'Layout JSON', extensions: ['json'], mimeTypes: ['application/json'],
        uniformTypeIdentifiers: ['public.json'])]);
    if (file == null) return null;
    if (await file.length() > 32768) throw const FormatException('Layout file too large');
    return file.readAsString();
  }
}
