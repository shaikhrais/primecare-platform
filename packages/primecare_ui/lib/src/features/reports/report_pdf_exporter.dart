import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:printing/printing.dart';

typedef ReportPdfExport =
    Future<bool> Function(Uint8List bytes, String filename);

/// Desktop saves use the OS file dialog; mobile/web use printing's share/download.
/// Cancellation is a normal result, and plugin or write failures reach the panel.
class ReportPdfExporter {
  final ReportPdfExport _save, _share;
  ReportPdfExporter({ReportPdfExport? save, ReportPdfExport? share})
    : _save = save ?? _saveDesktop,
      _share = share ?? _shareMobileOrWeb;

  Future<bool> export(
    Uint8List bytes,
    String filename, {
    TargetPlatform? platform,
    bool? isWeb,
  }) {
    final target = platform ?? defaultTargetPlatform;
    if (!(isWeb ?? kIsWeb) &&
        [
          TargetPlatform.windows,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(target)) {
      return _save(bytes, filename);
    }
    return _share(bytes, filename);
  }

  static Future<bool> _saveDesktop(Uint8List bytes, String filename) async {
    final location = await getSaveLocation(
      suggestedName: filename,
      acceptedTypeGroups: const [
        XTypeGroup(label: 'PDF', extensions: ['pdf']),
      ],
    );
    if (location == null) return false;
    await XFile.fromData(
      bytes,
      mimeType: 'application/pdf',
      name: filename,
    ).saveTo(location.path);
    return true;
  }

  static Future<bool> _shareMobileOrWeb(Uint8List bytes, String filename) =>
      Printing.sharePdf(bytes: bytes, filename: filename);
}
