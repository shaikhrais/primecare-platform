import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart' show ApiClient, apiClientProvider;
import 'package:primecare_models/primecare_models.dart' hide TargetPlatform;
import 'package:primecare_ui/src/features/reports/admin_report_service.dart';
import 'package:primecare_ui/src/features/reports/admin_reports_panel.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late Dio dio;
  late ApiClient client;
  setUp(() {
    container=ProviderContainer();dio=Dio(BaseOptions(baseUrl:'https://test'));
    client=container.read(Provider((ref) => ApiClient(ref,transport:dio)));
    dio.interceptors.clear();
  });
  tearDown(() {dio.close(force:true);container.dispose();});
  test('report errors retain status and never become offline success', () async {
    dio.interceptors.add(InterceptorsWrapper(onRequest:(o,h) => h.reject(DioException(
      requestOptions:o,type:DioExceptionType.connectionTimeout))));
    for(final path in ['/v1/governance/reports','/v1/governance/reports/page_readiness?locale=fr',
      'https://test/v1/governance/reports/page_readiness']) {
      expect((await client.get(path)).statusCode,503);
    }
    expect((await client.post('/v1/governance/reports/page_readiness/email')).statusCode,503);
    expect(() => AdminReportService(client,'/v1/other'),throwsArgumentError);
  });
  test('email transports key and consent and distinguishes accepted from unknown', () async {
    String state='accepted';int status=202;
    dio.interceptors.add(InterceptorsWrapper(onRequest:(o,h) {
      expect(o.headers['Idempotency-Key'],'same-key-123456789');
      expect((o.data as Map)['confirmed'],true);
      h.resolve(Response(requestOptions:o,statusCode:status,data:{'state':state}));
    }));
    final service=AdminReportService(client,'/v1/governance/reports');
    Future<String> send() => service.email('page_readiness',const AdminReportRequest(),
      to:'person@example.net',subject:'Report',message:'Attached',confirmed:true,
      idempotencyKey:'same-key-123456789');
    expect(await send(),'accepted');state='unknown';status=503;expect(await send(),'unknown');
  });
  test('PDF transport uses bytes and rejects JSON masquerading as a PDF', () async {
    bool valid=true;
    dio.interceptors.add(InterceptorsWrapper(onRequest:(o,h) {
      expect(o.responseType,ResponseType.bytes);
      h.resolve(Response(requestOptions:o,statusCode:200,
        data:(valid ? '%PDF-1.4\n' : '{"error":true}').codeUnits));
    }));
    final service=AdminReportService(client,'/v1/governance/reports');
    expect(await service.pdf('page_readiness',const AdminReportRequest()),isNotEmpty);
    valid=false;await expectLater(service.pdf('page_readiness',const AdminReportRequest()),throwsFormatException);
  });
  for(final platform in [TargetPlatform.android, TargetPlatform.iOS,
    TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]) {
  for(final width in [320.0,768.0,1440.0,3840.0]) {
   for(final enabled in [false,true]) {
    testWidgets('$platform report controls fit $width with delivery enabled=$enabled', (tester) async {
      debugDefaultTargetPlatformOverride = platform;
      addTearDown(() { debugDefaultTargetPlatformOverride = null; });
      tester.view.physicalSize=Size(width,1200);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      dio.interceptors.add(InterceptorsWrapper(onRequest:(o,h) => h.resolve(Response(
        requestOptions:o,statusCode:200,data:{'reports':[{'id':'page_readiness',
          'title':'Authorized page readiness','classification':'internal','canExport':enabled,'canEmail':enabled,'supportsFilters':enabled}],
          'resources':{'title':'Reports','report':'Report','generate':'Generate','refresh':'Refresh',
            'search':'Search','all':'All','created':'Created','ready':'Ready','working':'Working',
            'pdf':'Download PDF','recipient':'Recipient','subject':'Subject','message':'Message',
            'confirm':'I confirm this recipient may receive this report','email':'Email report'}}))));
      await tester.pumpWidget(ProviderScope(overrides:[apiClientProvider.overrideWithValue(client)],
        child:MaterialApp(home:PrimeTheme(data:const PrimeThemeData(),child:Scaffold(body:SingleChildScrollView(
          child:AdminReportsPanel(endpoint:'/v1/governance/reports')))))));
      await tester.pumpAndSettle();
      expect(find.text('Reports'),findsOneWidget);expect(find.text('Generate'),findsOneWidget);
      expect(find.byType(CheckboxListTile),enabled ? findsOneWidget : findsNothing);
      expect(find.text('Download PDF'),enabled ? findsOneWidget : findsNothing);
      expect(find.text('Email report'),enabled ? findsOneWidget : findsNothing);
      expect(tester.takeException(),isNull);
      await tester.pumpWidget(const SizedBox());
    });
   }
  }
  }
}
