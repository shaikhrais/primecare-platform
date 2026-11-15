import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_core/component_catalogue/prime_component_catalogue.dart';
import 'package:flutter_core/help_reader/help_reader_controller.dart';
import 'package:flutter_core/help_reader/help_reader_view.dart';
import 'package:flutter_core/preference_sync/preference_protocol.dart';

// Synthetic metadata and transport are fixtures, never production registrations.
const _keys = ['start', 'search', 'locale', 'previous', 'next', 'back', 'retry',
  'article', 'open', 'idle', 'loading', 'empty', 'error', 'retired'];
CatalogueLabels _labels(String locale) => CatalogueLabels.fromMetadata({
  'kind': 'verified_metadata_export',
  'controls': [for (var i = 0; i < _keys.length; i++) {
    'key': _keys[i], 'testId': 'fixture-${_keys[i]}', 'controlId': i + 1,
    'componentCode': _keys[i] == 'search' ? 'prime_text_field' : _keys[i] == 'locale'
      ? 'prime_dropdown_web' : ['article','idle','loading','empty','error','retired'].contains(_keys[i])
        ? 'prime_card' : 'prime_button'}],
  'locales': {for (final lang in ['en','fr','es']) lang:
    {for (final key in _keys) key: '$lang $key'}},
}, locale);
final _scope = PreferenceScope('tenant-a', 'psw-a', 'psw', 'live');
final _token = List.filled(43, 'a').join();

void main() {
  late HelpReaderController controller;
  late List<Map<String,dynamic>> commands;
  late int status;
  late bool noResults;
  Completer<void>? pending;
  setUp(() {
    commands = []; status = 200; noResults = false; pending = null;
    controller = HelpReaderController(origin: Uri.parse('https://fixture.example.test'),
      token: _token, scope: _scope, currentToken: () => _token,
      currentScope: () => _scope, pageSize: 1, client: MockClient((request) async {
        if (request.url.path == '/v1/auth/me') return http.Response(jsonEncode({
          'status':'authenticated','userId':_scope.userId,'tenantId':_scope.tenantId,'roles':_scope.role}),200,headers:{'content-type':'application/json'});
        final command = jsonDecode(request.body) as Map<String,dynamic>;
        commands.add(command);
        if (pending != null) await pending!.future;
        if (status != 200) return http.Response('PRIVATE diagnostics', status);
        final article = {'id':'Guide:A.1','revision':1,'title':'Fixture title',
          'category':'general', if (command['action']=='read') 'body':'Plain <script>body</script>'
          else 'summary':'Fixture summary'};
        return http.Response(jsonEncode({'version':1,'action':command['action'],
          'locale':command['locale'],'scope':_scope.toJson(),
          if (command['action']=='read') 'article':article else ...{
            'offset':command['offset'],'limit':command['limit'],'total':noResults?0:2,
            'items':noResults?[]:[article]}}),200,headers:{'content-type':'application/json'});
      }));
  });
  tearDown(() { controller.dispose(); });
  Widget scene({double textScale = 1}) => MaterialApp(builder:(context,child) => MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(textScale)),child:child!),home: Scaffold(body: Builder(builder:(context) =>
    HelpReaderView(controller:controller,labelsForLocale:_labels,
      localeNames:(_) => {'en':'English','fr':'Français','es':'Español'},
      start:'start',search:'search',locale:'locale',previous:'previous',next:'next',
      back:'back',retry:'retry',article:'article',open:'open',idle:'idle',
      loading:'loading',empty:'empty',error:'error',retired:'retired').build(context))));
  testWidgets('idle does not load; explicit start and detail/back use actual controller', (t) async {
    await t.pumpWidget(scene()); expect(commands,isEmpty); expect(find.text('en idle'),findsOneWidget);
    await t.tap(find.text('en start')); await t.pumpAndSettle();
    expect(find.text('Fixture title'),findsOneWidget); expect(commands.single['offset'],0);
    await t.tap(find.text('Fixture title')); await t.pumpAndSettle();
    expect(commands.last['articleId'],'Guide:A.1');
    expect(find.text('Plain <script>body</script>'),findsOneWidget);
    await t.tap(find.text('en back')); await t.pumpAndSettle();
    expect(commands.last['action'],'list'); expect(find.text('Fixture summary'),findsOneWidget);
  });
  testWidgets('paging, search reset and localized locale selection', (t) async {
    await t.pumpWidget(scene()); await controller.load(); await t.pumpAndSettle();
    await t.ensureVisible(find.text('en next')); await t.tap(find.text('en next')); await t.pumpAndSettle();
    expect(commands.last['offset'],1);
    await t.enterText(find.byWidgetPredicate((widget) => widget is TextFormField),'needle'); await t.testTextInput.receiveAction(TextInputAction.search); await t.pumpAndSettle();
    expect(commands.last['query'],'needle'); expect(commands.last['offset'],0);
    await t.tap(find.text('English')); await t.pumpAndSettle();
    await t.tap(find.text('Français').last); await t.pumpAndSettle();
    expect(commands.last['locale'],'fr'); expect(find.text('fr search'),findsOneWidget);
  });
  testWidgets('loading hides results; errors sanitized; retry and empty', (t) async {
    await t.pumpWidget(scene()); await controller.load(); await t.pumpAndSettle();
    pending = Completer<void>(); final request = controller.search('retry'); await t.pump();
    expect(find.text('Fixture title'),findsNothing); expect(find.text('en loading'),findsOneWidget);
    status = 503; pending!.complete(); await request; pending = null; await t.pumpAndSettle();
    expect(find.text('en error'),findsOneWidget); expect(find.textContaining('PRIVATE'),findsNothing);
    status = 200; noResults = true; await t.tap(find.text('en retry')); await t.pumpAndSettle();
    expect(find.text('en empty'),findsOneWidget);
  });
  testWidgets('retirement clears private content and every action', (t) async {
    await t.pumpWidget(scene()); await controller.load(); await t.pumpAndSettle();
    controller.retire(); await t.pumpAndSettle();
    expect(find.text('Fixture title'),findsNothing); expect(find.text('en retired'),findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is TextFormField),findsNothing); expect(find.byType(TextButton),findsNothing);
  });
  testWidgets('narrow layout and large text remain scrollable without overflow', (t) async {
    await t.binding.setSurfaceSize(const Size(320,480));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(scene(textScale:2));
    await controller.load(); await t.pumpAndSettle(); expect(t.takeException(),isNull);
    expect(find.byType(SingleChildScrollView),findsOneWidget);
  });
}
