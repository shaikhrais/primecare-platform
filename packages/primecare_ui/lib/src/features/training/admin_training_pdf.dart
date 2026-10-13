import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'localization/admin_training_catalog_generated.dart';

/// Local training evidence is separate from server-authorized business reports.
class AdminTrainingPdf {
  static Future<Uint8List> render(Map<String,Object> summary, String locale) async {
    final language = adminTrainingCatalog.containsKey(locale) ? locale : 'en';
    final copy = adminTrainingCatalog[language]!;
    String text(String key) => copy[key]!.replaceAll('’', "'");
    final records = (summary['passed'] as List).whereType<Map>().toList();
    final document = pw.Document();
    document.addPage(pw.MultiPage(build: (_) => [
      pw.Header(level:0,child:pw.Text(text('title'))),
      pw.Paragraph(text:text('local_note')),
      pw.Paragraph(text:'${text('progress')}: ${records.length}/${adminTrainingLessons.length}'),
      pw.Paragraph(text:text('export_scope')),
      for (final lesson in adminTrainingLessons)
        pw.Paragraph(text:'${text(lesson.titleKey)} - ${text(records.any((r)=>r['lesson']==lesson.id)?'passed':'pending')}'),
      // ASCII-only governed identifiers/timestamps preserve the exact summary.
      pw.Text(const JsonEncoder.withIndent('  ').convert(summary),style:pw.TextStyle(font:pw.Font.courier(),fontSize:8)),
    ]));
    return document.save();
  }
}
