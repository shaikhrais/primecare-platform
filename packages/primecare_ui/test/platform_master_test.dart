import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/platform/platform_master_repository.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/platform/platform_master_controller.dart';
import 'package:primecare_ui/src/features/platform/platform_master_screen.dart';
import 'package:primecare_ui/src/communications/communication_workspace.dart';
import '../../flutter_core/test/fixtures/voice_contact_transport.dart';

const base = PlatformMasterRepository.endpoint;
AuthState session({String user = 'actor-a', String? tenant = 'control', String token = 'token-a', String role = 'code_admin'}) =>
  AuthState(isInitialized: true, isAuthenticated: true, userId: user, tenantId: tenant, token: token, role: role);
class PlatformAuthFixture extends AuthNotifier {
  @override
  AuthState build() => session();
  void replace(AuthState value) { state = value; }
}
class PlatformGlobalAuthFixture extends PlatformAuthFixture {
  @override
  AuthState build() => session(tenant: null);
}
Map<String, dynamic> index({String actor = 'actor-a'}) => {
  'identity': {'userId': actor}, 'tenants': [{'id': 'tenant-a', 'name': 'Clinic A'}, {'id': 'tenant-b', 'name': 'Clinic B'}],
  'masterTypes': ['department', 'location', 'service_category'],
};
Map<String, dynamic> record({String label = 'Recruitment'}) => {
  'id': 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'type': 'department', 'code': 'hr_recruitment',
  'label': label, 'status': 'active', 'version': 1,
};
class Fixture {
  final container = ProviderContainer();
  final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
  late final ApiClient client;
  late final PlatformMasterRepository repository;
  Fixture(void Function(RequestOptions, RequestInterceptorHandler) handle) {
    client = container.read(Provider((ref) => ApiClient(ref, transport: dio)));
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      expect(options.headers['Authorization'], 'Bearer captured-token');
      expect(options.headers.keys.any((key) => key.toLowerCase() == 'x-tenant-id'), isFalse);
      handle(options, handler);
    }));
    repository = PlatformMasterRepository(client, actor: 'actor-a', token: 'captured-token');
  }
  void dispose() { dio.close(force: true); container.dispose(); }
}
void success(RequestOptions options, RequestInterceptorHandler handler, dynamic data, [int status = 200]) =>
  handler.resolve(Response(requestOptions: options, statusCode: status, data: data));
void failure(RequestOptions options, RequestInterceptorHandler handler, int status) =>
  handler.reject(DioException(requestOptions: options, response: Response(requestOptions: options,
    statusCode: status, data: {'error': 'private provider detail'}), type: DioExceptionType.badResponse));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('global own-phone composition delegates tenant identity to native transport', (tester) async {
    final paths=<String>[];
    final dio=Dio(BaseOptions(baseUrl:'https://synthetic.invalid'));
    dio.interceptors.add(InterceptorsWrapper(onRequest:(options,handler){
      paths.add(options.path);
      if(options.path==base){success(options,handler,index());return;}
      expect(options.path,'/v1/voice/contact/status');expect(options.method,'POST');
      expect(options.data,<String,Object?>{});
      expect(options.headers.keys.any((k)=>k.toLowerCase()=='x-tenant-id'),false);
      success(options,handler,{'verified':false,'enrollmentAllowed':true});
    }));
    final container=ProviderContainer(overrides:[authProvider.overrideWith(PlatformGlobalAuthFixture.new),
      apiClientProvider.overrideWith((ref)=>ApiClient(ref,transport:dio))]);
    addTearDown((){dio.close(force:true);container.dispose();});
    await tester.pumpWidget(UncontrolledProviderScope(container:container,
      child:PrimeTheme(data:const PrimeThemeData(),child:const MaterialApp(home:PlatformMasterScreen()))));
    await tester.pumpAndSettle();
    expect(find.byType(VoiceContactVerificationPanel),findsOneWidget);
    expect(paths,[base,'/v1/voice/contact/status']);
    expect(container.read(voiceContactControllerProvider)!.canSend,true);
    expect(container.read(communicationWorkspaceControllerProvider),isNull);
    expect(tester.takeException(),isNull);await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('registered platform screen reuses own-phone panel without loading clinical messaging', (tester) async {
    final dio=Dio(BaseOptions(baseUrl:'https://synthetic.invalid'));
    var masterReads=0;
    dio.interceptors.add(InterceptorsWrapper(onRequest:(options,handler){
      masterReads++;expect(options.path,base);success(options,handler,index());
    }));
    final transport=VoiceContactTransport();
    late VoiceContactController phone;
    final container=ProviderContainer(overrides:[
      authProvider.overrideWith(PlatformAuthFixture.new),
      apiClientProvider.overrideWith((ref)=>ApiClient(ref,transport:dio)),
      voiceContactControllerProvider.overrideWith((ref){
        ref.watch(authProvider);
        phone=VoiceContactController(hub:CommunicationHub(transport));
        ref.onDispose(phone.dispose);return phone;
      }),
    ]);
    addTearDown((){dio.close(force:true);container.dispose();});
    await tester.pumpWidget(UncontrolledProviderScope(container:container,
      child:PrimeTheme(data:const PrimeThemeData(),child:const MaterialApp(home:PlatformMasterScreen()))));
    await tester.pumpAndSettle();
    expect(masterReads,1);expect(find.byType(VoiceContactVerificationPanel),findsOneWidget);
    expect(transport.requests,[{'action':'status'}]);expect(transport.sends,0);
    expect(phone.canSend,true);expect(find.byType(CommunicationWorkspaceView),findsNothing);
    final old=phone;
    (container.read(authProvider.notifier) as PlatformAuthFixture).replace(session(user:'actor-b'));
    await tester.pumpAndSettle();expect(old.isDisposed,true);
    expect(tester.takeException(),isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  for (final denied in [false, true]) {
    testWidgets('global administration delegates missing client tenant to server, denied=$denied', (tester) async {
      var calls = 0;
      final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        calls++; expect(options.path, base);
        if (denied) { failure(options, handler, 403); }
        else { success(options, handler, index()); }
      }));
      final container = ProviderContainer(overrides: [voiceContactControllerProvider.overrideWith((ref)=>null),authProvider.overrideWith(PlatformGlobalAuthFixture.new),
        apiClientProvider.overrideWith((ref) => ApiClient(ref, transport: dio))]);
      addTearDown(() { dio.close(force: true); container.dispose(); });
      await tester.pumpWidget(UncontrolledProviderScope(container: container,
        child: PrimeTheme(data: const PrimeThemeData(), child: const MaterialApp(home: PlatformMasterScreen()))));
      await tester.pumpAndSettle(); expect(calls, 1);
      if (denied) {
        expect(find.text('Request failed.'), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      } else { expect(find.byType(DropdownButtonFormField<String>), findsOneWidget); }
      expect(tester.takeException(), isNull); await tester.pumpWidget(const SizedBox.shrink());
    });
  }
  test('server identity and selected tenant are validated before further I/O', () async {
    var calls = 0;
    final fixture = Fixture((options, handler) { calls++; success(options, handler, index()); });
    addTearDown(fixture.dispose);
    final authorized = await fixture.repository.index();
    expect(calls, 1);
    await expectLater(fixture.repository.records(authorized, 'foreign/escape'), throwsA(isA<PlatformAdministrationFailure>()));
    expect(calls, 1);
    expect(() => PlatformAdministrationIndex(index(actor: 'foreign'), 'actor-a'), throwsFormatException);
    final tenant = (index()['tenants'] as List).first;
    expect(() => PlatformAdministrationIndex({...index(), 'tenants': [tenant, tenant]}, 'actor-a'), throwsFormatException);
  });

  for (final afterWrite in [false, true]) {
    test('explicit retry retains original command after ${afterWrite ? 'readback' : 'write'} uncertainty', () async {
      var posts = 0, writes = 0, reads = 0;
      final keys = <String>[], bodies = <dynamic>[];
      final saved = <Map<String, dynamic>>[];
      final fixture = Fixture((options, handler) {
        if (options.path == base) { success(options, handler, index()); return; }
        expect(options.path, '$base/tenants/tenant-a/masters');
        if (options.method == 'POST') {
          posts++; keys.add(options.headers['Idempotency-Key'] as String); bodies.add(options.data);
          if (saved.isEmpty) { writes++; saved.add(record()); }
          if (!afterWrite && posts == 1) {
            handler.reject(DioException(requestOptions: options, type: DioExceptionType.connectionTimeout)); return;
          }
          success(options, handler, {'record': record()}, 201); return;
        }
        reads++;
        if (afterWrite && reads == 2) { failure(options, handler, 503); return; }
        success(options, handler, {'records': saved, 'types': ['department']});
      });
      addTearDown(fixture.dispose);
      var active = true;
      final controller = PlatformMasterController(fixture.repository, isCurrent: () => active, key: () => 'original-key-123456');
      addTearDown(controller.dispose);
      await controller.load(); await controller.selectTenant('tenant-a');
      expect(await controller.create('department', 'hr_recruitment', 'Recruitment'), isFalse);
      expect(controller.snapshot.pending, isTrue);
      expect(controller.snapshot.notice, isNull);
      expect(await controller.create('department', 'hr_other', 'Other'), isFalse);
      await controller.selectTenant('tenant-b');
      expect(controller.snapshot.tenant, 'tenant-a');
      active = false;
      expect(await controller.retryPending(), isFalse); expect(posts, 1);
      active = true;
      expect(await controller.retryPending(), isTrue);
      expect(keys, ['original-key-123456', 'original-key-123456']);
      expect(bodies[0], bodies[1]); expect(writes, 1);
      expect(controller.snapshot.notice, 'master_created');
      expect(controller.snapshot.pending, isFalse);
      expect(controller.snapshot.records.single.label, 'Recruitment');
    });
  }

  test('malformed write receipt never reports completion or loses replay identity', () async {
    final fixture = Fixture((options, handler) {
      if (options.path == base) { success(options, handler, index()); }
      else if (options.method == 'POST') { success(options, handler, {'record': record(label: 'Wrong')}, 201); }
      else { success(options, handler, {'records': <Object>[], 'types': ['department']}); }
    });
    addTearDown(fixture.dispose);
    final controller = PlatformMasterController(fixture.repository, isCurrent: () => true);
    addTearDown(controller.dispose);
    await controller.load(); await controller.selectTenant('tenant-a');
    expect(await controller.create('department', 'hr_recruitment', 'Recruitment'), isFalse);
    expect(controller.snapshot.notice, isNull); expect(controller.snapshot.pending, isTrue);
  });

  test('failed tenant record read cannot enable or dispatch creation', () async {
    var posts = 0;
    final fixture = Fixture((options, handler) {
      if (options.method == 'POST') { posts++; failure(options, handler, 503); }
      else if (options.path == base) { success(options, handler, index()); }
      else { failure(options, handler, 503); }
    });
    addTearDown(fixture.dispose);
    final controller = PlatformMasterController(fixture.repository, isCurrent: () => true);
    addTearDown(controller.dispose);
    await controller.load(); await controller.selectTenant('tenant-a');
    expect(controller.snapshot.index, isNotNull); expect(controller.snapshot.recordsLoaded, isFalse);
    expect(controller.canCreate, isFalse);
    expect(await controller.create('department', 'hr_recruitment', 'Recruitment'), isFalse);
    expect(posts, 0);
  });

  test('denied server access clears tenant data and redacts provider errors', () async {
    var denied = false;
    final fixture = Fixture((options, handler) {
      if (denied) { failure(options, handler, 403); }
      else if (options.path == base) { success(options, handler, index()); }
      else { success(options, handler, {'records': [record()], 'types': ['department']}); }
    });
    addTearDown(fixture.dispose);
    final controller = PlatformMasterController(fixture.repository, isCurrent: () => true);
    addTearDown(controller.dispose);
    await controller.load(); await controller.selectTenant('tenant-a');
    expect(controller.snapshot.records, hasLength(1));
    denied = true; await controller.load();
    expect(controller.snapshot.index, isNull); expect(controller.snapshot.records, isEmpty);
    expect(controller.snapshot.error, 'request_failed');
  });

  test('in-flight creation is single flight and disposal prevents late readback', () async {
    final deferred = Completer<void>();
    final dispatched = Completer<void>();
    var posts = 0, reads = 0;
    final fixture = Fixture((options, handler) {
      if (options.path == base) { success(options, handler, index()); }
      else if (options.method == 'POST') {
        posts++;
        if (!dispatched.isCompleted) dispatched.complete();
        deferred.future.then((_) => success(options, handler, {'record': record()}, 201));
      } else { reads++; success(options, handler, {'records': <Object>[], 'types': ['department']}); }
    });
    addTearDown(fixture.dispose);
    final controller = PlatformMasterController(fixture.repository, isCurrent: () => true);
    addTearDown(() { controller.dispose(); if (!deferred.isCompleted) deferred.complete(); });
    await controller.load(); await controller.selectTenant('tenant-a');
    final pending = controller.create('department', 'hr_recruitment', 'Recruitment');
    await dispatched.future.timeout(const Duration(seconds: 5));
    expect(posts, 1); expect(await controller.create('department', 'hr_other', 'Other'), isFalse);
    expect(await controller.retryPending(), isFalse);
    controller.dispose(); deferred.complete(); expect(await pending, isFalse); expect(reads, 1);
  });

  for (final change in ['user', 'tenant', 'role', 'token']) {
    testWidgets('administration clears cached and late data on $change change', (tester) async {
      final delayed = <(RequestOptions, RequestInterceptorHandler)>[];
      var calls = 0;
      final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        calls++;
        if (calls == 1) { success(options, handler, index()); }
        else if (calls == 2) { success(options, handler, {'records': [record(label: 'Private Alice')], 'types': ['department']}); }
        else { delayed.add((options, handler)); }
      }));
      final container = ProviderContainer(overrides: [voiceContactControllerProvider.overrideWith((ref)=>null),authProvider.overrideWith(PlatformAuthFixture.new),
        apiClientProvider.overrideWith((ref) => ApiClient(ref, transport: dio))]);
      addTearDown(() { dio.close(force: true); container.dispose(); });
      await tester.pumpWidget(UncontrolledProviderScope(container: container,
        child: PrimeTheme(data: const PrimeThemeData(), child: const MaterialApp(home: PlatformMasterScreen()))));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<String>).first); await tester.pumpAndSettle();
      await tester.tap(find.text('Clinic A').last); await tester.pumpAndSettle();
      expect(find.text('Private Alice'), findsOneWidget);
      final actor = container.read(authProvider.notifier) as PlatformAuthFixture;
      actor.replace(session(user: change == 'user' ? 'actor-b' : 'actor-a',
        tenant: change == 'tenant' ? 'tenant-b' : 'control', token: change == 'token' ? 'token-b' : 'token-a',
        role: change == 'role' ? 'patient' : 'code_admin'));
      await tester.pump(); await tester.pump(const Duration(milliseconds: 10));
      expect(find.text('Private Alice'), findsNothing);
      actor.replace(AuthState(isInitialized: true)); await tester.pump();
      for (final (options, handler) in delayed) { success(options, handler, index()); }
      await tester.pumpAndSettle();
      expect(find.text('Clinic A'), findsNothing); expect(find.byType(PlatformMasterScreen), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing); expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  for (final locale in ['en', 'fr', 'es']) {
    testWidgets('tenant selection, department creation and reload render in $locale at narrow width', (tester) async {
      tester.view.physicalSize = const Size(320, 900); tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
      final saved = <Map<String, dynamic>>[];
      var posts = 0;
      final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (options.path == base) { success(options, handler, index()); return; }
        expect(options.path, '$base/tenants/tenant-a/masters');
        if (options.method == 'POST') {
          posts++; expect(options.data, {'type': 'department', 'code': 'hr_recruitment', 'label': 'Recruitment'});
          expect(options.headers['Idempotency-Key'], matches(RegExp(r'^[a-f0-9]{32}$')));
          saved.add(record()); success(options, handler, {'record': record()}, 201);
        } else { success(options, handler, {'records': List.of(saved), 'types': ['department']}); }
      }));
      final container = ProviderContainer(overrides: [voiceContactControllerProvider.overrideWith((ref)=>null),authProvider.overrideWith(PlatformAuthFixture.new),
        apiClientProvider.overrideWith((ref) => ApiClient(ref, transport: dio))]);
      addTearDown(() { dio.close(force: true); container.dispose(); });
      await tester.pumpWidget(UncontrolledProviderScope(container: container,
        child: PrimeTheme(data: const PrimeThemeData(), child: MaterialApp(locale: Locale(locale),
          supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.5)), child: child!),
          home: const PlatformMasterScreen()))));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>).first);
      await tester.tap(find.byType(DropdownButtonFormField<String>).first); await tester.pumpAndSettle();
      await tester.tap(find.text('Clinic A').last); await tester.pumpAndSettle();
      final type = find.byType(DropdownButtonFormField<String>).last;
      await tester.ensureVisible(type); await tester.tap(type); await tester.pumpAndSettle();
      await tester.tap(find.text('department').last); await tester.pumpAndSettle();
      final inputs = find.byType(PrimeCareTextField);
      await tester.enterText(find.descendant(of: inputs.first, matching: find.byType(TextFormField)), 'hr_recruitment');
      await tester.enterText(find.descendant(of: inputs.last, matching: find.byType(TextFormField)), 'Recruitment');
      final create = find.byWidgetPredicate((widget) => widget is PrimeButton && widget.dataCy == 'platform-master-create-submit');
      await tester.ensureVisible(create); await tester.tap(create); await tester.pumpAndSettle();
      expect(posts, 1); expect(find.text('Recruitment'), findsOneWidget);
      final refresh = find.byWidgetPredicate((widget) => widget is PrimeButton && widget.dataCy == 'platform-refresh');
      await tester.ensureVisible(refresh); await tester.tap(refresh); await tester.pumpAndSettle();
      expect(find.text('Recruitment'), findsOneWidget); expect(posts, 1); expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
