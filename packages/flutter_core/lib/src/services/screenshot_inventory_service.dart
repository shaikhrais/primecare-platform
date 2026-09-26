// Governance - Category: service | Purpose: Scans screenshot previews, updates DB, generates markdown inventory.
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:flutter_core/database/database.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:image/image.dart' as img;

class ScreenshotInventoryService {
  final QueryExecutor db;
  final String previewDir = 'docs/screen_previews';
  ScreenshotInventoryService(this.db);

  /// Scans the preview directory, updates `screens` table, and writes inventory markdown.
  Future<void> scanAndUpdate() async {
    final dir = Directory(previewDir);
    if (!await dir.exists()) return;
    final files = await dir.list().where((e) => e is File && e.path.endsWith('.png')).cast<File>().toList();
    final Map<String, int> duplicateCount = {};
    for (final file in files) {
      final basename = p.basename(file.path);
      duplicateCount[basename] = (duplicateCount[basename] ?? 0) + 1;
    }
    for (final file in files) {
      final stat = await file.stat();
      final size = stat.size;
      final generatedAt = stat.modified.toIso8601String();
      final basename = p.basename(file.path);
      final parts = basename.split('_');
      if (parts.length < 2) continue; // malformed name
      final role = parts[0];
      final screenNameWithExt = parts.sublist(1).join('_');
      final screenName = screenNameWithExt.replaceAll('.png', '');
      final routePath = '/screens/$screenName';
      final componentFile = 'generated_screens/${screenName}.dart';
      final status = size == 0 ? 'EMPTY_FILE' : (duplicateCount[basename]! > 1 ? 'DUPLICATE' : 'GENERATED');
      final visualScore = _calculateVisualScore(file);
      await db.execute('''
        INSERT OR REPLACE INTO screens (screen_name, role, route_path, component_file, screenshot_status, screenshot_file_path, screenshot_generated_at, screenshot_file_size, visual_quality_score)
        VALUES (?,?,?,?,?,?,?,?,?)
      ''', [
        screenName,
        role,
        routePath,
        componentFile,
        status,
        file.path,
        generatedAt,
        size,
        visualScore,
      ]);
    // Apply overlay onto screenshot
    final bytes = await file.readAsBytes();
    final overlayData = {
      'platform': 'PrimeCare Platform',
      'role': role,
      'screen': screenName,
      'route': routePath,
      'component': componentFile,
      'visualScore': visualScore.toString(),
      'generatedAt': generatedAt,
    };
    final newBytes = await _applyOverlay(bytes, overlayData);
    await file.writeAsBytes(newBytes);
    }
    await _generateMarkdown(files);
  }

  double _calculateVisualScore(File file) {
  // Placeholder: use image dimensions as a simple quality proxy.
  // In production, integrate with image processing lib.
  return 1.0;
}

Future<Uint8List> _applyOverlay(Uint8List baseImageBytes, Map<String, String> data) async {
  final image = img.decodeImage(baseImageBytes);
  if (image == null) return baseImageBytes;
  // Create an overlay image with transparent background
  final overlay = img.Image(width: image.width, height: image.height);
  img.fill(overlay, color: img.ColorRgba8(0, 0, 0, 0));
  // Prepare top header text
  final header = '${data['platform'] ?? 'PrimeCare Platform'} | ${data['role'] ?? ''} | ${data['screen'] ?? ''}';
  img.drawString(overlay, header, font: img.arial24, x: 10, y: 10, color: img.ColorRgb8(255, 255, 255));
  // Subtext with route and component
  final sub = 'Route: ${data['route'] ?? ''}';
  img.drawString(overlay, sub, font: img.arial14, x: 10, y: 40, color: img.ColorRgb8(200, 200, 200));
  // Draw overlay onto original image
  img.compositeImage(image, overlay);
  return Uint8List.fromList(img.encodePng(image));
}

  Future<void> _generateMarkdown(List<File> files) async {
    final buffer = StringBuffer();
    buffer.writeln('# Screenshot Inventory');
    buffer.writeln('| File | Role | Screen Name | Route Path | Component File | Size | Generated At | Render Status | Visual Quality Score |');
    buffer.writeln('|---|---|---|---|---|---|---|---|---|');
    for (final file in files) {
      final stat = await file.stat();
      final size = stat.size;
      final generatedAt = stat.modified.toIso8601String();
      final basename = p.basename(file.path);
      final parts = basename.split('_');
      if (parts.length < 2) continue;
      final role = parts[0];
      final screenName = parts.sublist(1).join('_').replaceAll('.png', '');
      final routePath = '/screens/$screenName';
      final componentFile = 'generated_screens/${screenName}.dart';
      final status = size == 0 ? 'EMPTY_FILE' : 'GENERATED';
      final visualScore = _calculateVisualScore(file);
      buffer.writeln('| ${basename} | $role | $screenName | $routePath | $componentFile | $size | $generatedAt | $status | $visualScore |');
    }
    final outPath = p.join(previewDir, 'SCREENSHOT_INVENTORY.md');
    final outFile = File(outPath);
    await outFile.writeAsString(buffer.toString());
  }
}
