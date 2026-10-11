import 'package:test/test.dart';
import 'package:primecare_models/primecare_models.dart';
void main() {
  Map<String,dynamic> report() => {'id':'page_readiness','title':'Report',
    'columns':[{'key':'page','label':'Page'}], 'rows':[{'page':'Dashboard'}],
    'generatedAt':'2026-10-11T16:00:00Z','scope':'authorized_pages',
    'classification':'internal','locale':'en','source':'governance.db'};
  test('admin result preserves shared parent and provenance', () {
    final result=AdminReportResult.fromJson(report());
    expect(result,isA<ReportData>()); expect(result.rows.single['page'],'Dashboard');
    expect(result.isOffline,isFalse); expect(result.generatedAt.isUtc,isTrue);
  });
  test('offline and malformed report data cannot become an exportable result', () {
    expect(() => AdminReportResult.fromJson({...report(),'isOffline':true}),throwsFormatException);
    expect(() => AdminReportResult.fromJson({...report(),'generatedAt':'bad'}),throwsFormatException);
  });
  test('definition preserves server-controlled export and email capabilities', () {
    final definition=AdminReportDefinition.fromJson({'id':'page_readiness','title':'Report',
      'classification':'internal','canExport':false,'canEmail':true});
    expect(definition.canExport,isFalse);expect(definition.canEmail,isTrue);
    expect(const AdminReportRequest(locale:'es',search:'admin').toJson(),
      {'locale':'es','search':'admin','readiness':'all'});
  });
}
