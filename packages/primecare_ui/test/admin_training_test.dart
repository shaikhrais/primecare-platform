import 'dart:math' as math;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';
import 'package:primecare_ui/src/features/training/admin_training_progress.dart';
import 'package:primecare_ui/src/features/training/admin_training_screen.dart';
import 'package:primecare_ui/src/features/training/admin_training_launcher.dart';
import 'package:primecare_ui/src/features/training/localization/admin_training_catalog_generated.dart';
import 'package:primecare_ui/src/features/reports/report_pdf_exporter.dart';
import 'auth_design_test.dart' show localized;

class TrainingAuth extends AuthNotifier {
  @override
  AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userId:'learner-a',role:'admin',token:'test-token');
  void switchAccount(String? id)=>state=AuthState(isInitialized:true,isAuthenticated:id!=null,userId:id,role:'admin');
}
class MemoryTrainingStorage implements AdminTrainingStorage {
  final values=<String,String>{};
  bool writable=true;
  @override
  Future<String?> read(String key) async=>values[key];
  @override
  Future<bool> write(String key,String value) async {if(!writable)return false;values[key]=value;return true;}
  @override
  Future<bool> remove(String key) async {if(!writable)return false;values.remove(key);return true;}
}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(()=>SharedPreferences.setMockInitialValues({}));
  setUpAll(() async {SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
  test('native progress matches web export and isolates accounts/gateways',() async {
    final storage=MemoryTrainingStorage();
    final a=AdminTrainingProgress(gateway:'https://one/',actor:'a',storage:storage);
    expect(await a.answer('authority',0),false);expect(await a.results(),isEmpty);
    await Future.wait([a.answer('authority',1),a.answer('routine',2)]);
    final restored=AdminTrainingProgress(gateway:'https://one',actor:'a',storage:storage);
    expect((await restored.results()).map((r)=>r.lesson),['authority','routine']);
    expect(await AdminTrainingProgress(gateway:'https://one',actor:'b',storage:storage).results(),isEmpty);
    expect(await AdminTrainingProgress(gateway:'https://other',actor:'a',storage:storage).results(),isEmpty);
    final summary=await a.summary();expect(summary['recordType'],'device-self-assessment');expect(summary['supervisorVerified'],false);
    expect(summary.keys.toSet(),{'course','version','recordType','generatedAt','passed','total','supervisorVerified'});
    await a.reset();expect(await a.results(),isEmpty);
  });
  test('failed persistence and corrupt results never pass a lesson',() async {
    final storage=MemoryTrainingStorage()..writable=false;
    final p=AdminTrainingProgress(gateway:'https://one',actor:'a',storage:storage);
    await expectLater(p.answer('authority',1),throwsStateError);expect(await p.results(),isEmpty);
    await expectLater(p.reset(),throwsStateError);
    storage.writable=true;storage.values[p.key]='x'*32769;expect(await p.results(),isEmpty);
    storage.values[p.key]=jsonEncode([{'lesson':'unknown','passedAt':'2026-10-13'}]);expect(await p.results(),isEmpty);
    await expectLater(p.answer('unknown',1),throwsArgumentError);await expectLater(p.answer('authority',3),throwsArgumentError);
    expect(()=>AdminTrainingProgress(gateway:'https://one',actor:''),throwsArgumentError);
  });
  for(final language in ['en','fr','es']) {
    for(final width in [320.0,1440.0]) {
      testWidgets('native training in $language at $width preserves choices, exports and resumes', (tester) async {
        tester.view.physicalSize=Size(width,900);tester.view.devicePixelRatio=1;
        addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
        final storage=MemoryTrainingStorage();final progress=AdminTrainingProgress(gateway:'https://one',actor:'learner-a',storage:storage);
        Uint8List? exported;
        Future<bool> capture(Uint8List bytes,String name) async {expect(name,'PrimeCare-Admin-Training-Summary.pdf');exported=bytes;return true;}
        final exporter=ReportPdfExporter(save:capture,share:capture);
        final store=LiveScreenTextStore(baseUrl:'https://one',client:MockClient((request) async=>http.Response(jsonEncode(request.url.path.endsWith('/screen-text')?{'screens':[{'id':'admin_training','version':0}]}:{'screen':'admin_training','version':0,'locales':adminTrainingCatalog}),200,headers:{'content-type':'application/json; charset=utf-8'})));
        addTearDown(store.dispose);
        Widget screen()=>ProviderScope(overrides:[authProvider.overrideWith(TrainingAuth.new)],child:localized(LiveScreenTextScope(store:store,child:AdminTrainingScreen(actor:'learner-a',gateway:'https://one',progress:progress,exporter:exporter)),language:language));
        await tester.pumpWidget(screen());await tester.pumpAndSettle();
        final unselected=find.byWidgetPredicate((widget)=>widget is PrimeButton && widget.dataCy=='training-language-${language=='en'?'fr':'en'}');
        final textWidget=tester.widget<Text>(find.descendant(of:unselected,matching:find.byType(Text)));
        final buttonWidget=tester.widget<ElevatedButton>(find.descendant(of:unselected,matching:find.byType(ElevatedButton)));
        final foreground=textWidget.style!.color!.computeLuminance();
        final background=buttonWidget.style!.backgroundColor!.resolve({})!.computeLuminance();
        expect((math.max(foreground,background)+0.05)/(math.min(foreground,background)+0.05),greaterThanOrEqualTo(4.5));
        Future<void> tap(String key) async {
          final finder=find.byWidgetPredicate((widget)=>widget is PrimeButton && widget.dataCy==key);
          final scrollable=find.byType(Scrollable).first;
          tester.state<ScrollableState>(scrollable).position.jumpTo(0);
          await tester.pumpAndSettle();
          await tester.scrollUntilVisible(finder,250,scrollable:scrollable,maxScrolls:100);
          await tester.ensureVisible(finder);await tester.pumpAndSettle();
          expect(finder.hitTestable(),findsOneWidget,reason:'$key must be visible before tapping');
          await tester.tap(finder);await tester.pumpAndSettle();
        }
        await tap('training-submit');expect(find.text(adminTrainingCatalog[language]!['select_answer']!),findsOneWidget);
        await tap('training-answer-0');await tap('training-submit');expect(await progress.results(),isEmpty);
        await tap('training-answer-1');await tap('training-language-fr');
        final changed={for(final entry in adminTrainingCatalog.entries)entry.key:Map<String,String>.from(entry.value)};
        changed['fr']!['title']='Device training';await store.saveLocal('admin_training',changed);await tester.pumpAndSettle();
        expect(find.text('Device training'),findsOneWidget);
        await tap('training-submit');expect((await progress.results()).length,1);
        for(final lesson in adminTrainingLessons.skip(1)) {await tap('training-lesson-${lesson.id}');await tap('training-answer-${lesson.correct}');await tap('training-submit');}
        expect((await progress.results()).length,8);expect(tester.takeException(),isNull);
        await tap('training-export');expect(exported,isNotNull);expect(ascii.decode(exported!.take(5).toList()),'%PDF-');
        await tester.pumpWidget(const SizedBox());await tester.pumpAndSettle();await tester.pumpWidget(screen());await tester.pumpAndSettle();
        expect((await progress.results()).length,8);
        final counter=find.textContaining('8/8');
        await tester.scrollUntilVisible(counter,200,scrollable:find.byType(Scrollable).first,maxScrolls:100);
        await tester.pumpAndSettle();expect(counter,findsOneWidget);
        await tap('training-reset');await tester.tap(find.text(adminTrainingCatalog[language]!['reset']!).last);await tester.pumpAndSettle();expect(await progress.results(),isEmpty);
        storage.writable=false;await tap('training-answer-1');await tap('training-submit');expect(find.text(adminTrainingCatalog[language]!['storage_error']!),findsOneWidget);expect(await progress.results(),isEmpty);
        expect(tester.takeException(),isNull);
      });
    }
  }
  testWidgets('verified account opens training; switching account hides old progress', (tester) async {
    final container=ProviderContainer(overrides:[authProvider.overrideWith(TrainingAuth.new)]);addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container:container,child:localized(const Scaffold(body:AdminTrainingLauncher()))));await tester.pumpAndSettle();
    await tester.tap(find.byWidgetPredicate((widget)=>widget is PrimeButton && widget.dataCy=='workspace-training'));await tester.pumpAndSettle();expect(find.byType(AdminTrainingScreen),findsOneWidget);
    (container.read(authProvider.notifier) as TrainingAuth).switchAccount('learner-b');await tester.pumpAndSettle();expect(find.byKey(const ValueKey('training-submit')),findsNothing);
    (container.read(authProvider.notifier) as TrainingAuth).switchAccount(null);await tester.pumpAndSettle();expect(find.byKey(const ValueKey('training-export')),findsNothing);
  });
}
