import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/reports/report_pdf_exporter.dart';

void main() {
  final bytes = Uint8List.fromList('%PDF-1.4\n'.codeUnits);
  for (final platform in TargetPlatform.values) {
    for (final web in [false, true]) {
      test('$platform web=$web dispatches the original PDF once', () async {
        final calls = <String>[];
        Future<bool> handle(
          String route,
          Uint8List data,
          String filename,
        ) async {
          expect(identical(data, bytes), isTrue);
          expect(filename, 'page_readiness.pdf');
          calls.add(route);
          return true;
        }

        final exporter = ReportPdfExporter(
          save: (data, name) => handle('save', data, name),
          share: (data, name) => handle('share', data, name),
        );
        expect(
          await exporter.export(
            bytes,
            'page_readiness.pdf',
            platform: platform,
            isWeb: web,
          ),
          isTrue,
        );
        final desktop = [
          TargetPlatform.windows,
          TargetPlatform.macOS,
          TargetPlatform.linux,
        ].contains(platform);
        expect(calls, [!web && desktop ? 'save' : 'share']);
      });
    }
  }
  test('cancelled Save does not fall back to share', () async {
    final exporter = ReportPdfExporter(
      save: (_, _) async => false,
      share: (_, _) async => throw StateError('unexpected sharing'),
    );
    expect(
      await exporter.export(
        bytes,
        'report.pdf',
        platform: TargetPlatform.linux,
        isWeb: false,
      ),
      isFalse,
    );
  });
  test('failed file writes propagate without sharing', () async {
    final exporter = ReportPdfExporter(
      save: (_, _) async => throw StateError('write failed'),
      share: (_, _) async => throw StateError('unexpected sharing'),
    );
    await expectLater(
      exporter.export(
        bytes,
        'report.pdf',
        platform: TargetPlatform.macOS,
        isWeb: false,
      ),
      throwsStateError,
    );
  });
}
