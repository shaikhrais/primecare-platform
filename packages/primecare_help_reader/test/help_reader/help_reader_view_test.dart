import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCard;
import 'package:primecare_theme/advanced_theme/advanced_theme_model.dart';
import 'package:primecare_theme/advanced_theme/advanced_theme_region.dart';
import 'package:primecare_component_factory/component_catalogue/prime_component_catalogue.dart';
import 'package:primecare_help_reader/help_reader/help_reader_controller.dart';
import 'package:primecare_help_reader/help_reader/help_reader_view.dart';
import 'package:primecare_preferences/preference_sync/preference_protocol.dart';

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

ConstrainedBox _frame(WidgetTester tester) {
  final scroll = tester.widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
  return (scroll.child! as Align).child! as ConstrainedBox;
}
Padding _outerPadding(WidgetTester tester) => _frame(tester).child! as Padding;
Finder _registered(String id) => find.byWidgetPredicate((widget) =>
  widget is Semantics && widget.properties.identifier == 'fixture-$id');
Padding _cardPadding(WidgetTester tester, String id) => tester.widget<PrimeCard>(
  find.descendant(of: _registered(id), matching: find.byType(PrimeCard))).child! as Padding;

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
        final article = <String,Object>{'id':'Guide:A.1','revision':1,'title':'Fixture title',
          'category':'general', if (command['action']=='read') 'body':'Plain <script>body</script>'
          else 'summary':'Fixture summary'};
        return http.Response(jsonEncode({'version':1,'action':command['action'],
          'locale':command['locale'],'scope':_scope.toJson(),
          if (command['action']=='read') 'article':article else ...{
            'offset':command['offset'],'limit':command['limit'],'total':noResults?0:2,
            'items':noResults?<Map<String,Object>>[]:[article]}}),200,headers:{'content-type':'application/json'});
      }));
  });
  tearDown(() { controller.dispose(); });
  Widget scene({double textScale = 1, AdvancedTheme? advanced}) => MaterialApp(
    theme: advanced == null ? null : advancedThemeData(ThemeData(), advanced, 'main'),
    builder:(context,child) => MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(textScale)),child:child!),home: Scaffold(body: Builder(builder:(context) =>
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
  testWidgets('boxed layout uses configured max width and effective theme spacing', (t) async {
    await t.binding.setSurfaceSize(const Size(1800,1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    final theme = AdvancedTheme.defaults().patch('tokens.spacing',24)
      .patch('layout.container','boxed').patch('layout.maxWidth',1440);
    final expected = AdvancedThemeTokens(theme,'main').spacing;
    await t.pumpWidget(scene(advanced:theme));
    expect(commands,isEmpty);
    expect(_frame(t).constraints.maxWidth,1440);
    expect(t.getSize(find.byWidget(_frame(t))).width,1440);
    expect(_outerPadding(t).padding,EdgeInsets.all(expected));
    expect(_cardPadding(t,'idle').padding,EdgeInsets.all(expected));
    final column = _outerPadding(t).child! as Column;
    expect(column.children.cast<Padding>().map((child) => child.padding),
      everyElement(EdgeInsets.only(bottom:expected)));
    await controller.load(); await t.pumpAndSettle();
    final paging = t.widget<Wrap>(find.byType(Wrap));
    expect(paging.spacing,expected); expect(paging.runSpacing,expected);
    expect(t.takeException(),isNull);
  });
  testWidgets('theme replacement updates density spacing and content width without a read', (t) async {
    await t.binding.setSurfaceSize(const Size(1800,1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    final initial = AdvancedTheme.defaults().patch('tokens.spacing',24)
      .patch('layout.container','boxed').patch('layout.maxWidth',1440);
    await t.pumpWidget(scene(advanced:initial));
    await controller.load(); await t.pumpAndSettle();
    final reads = commands.length;
    final changed = initial.patch('tokens.spacing',8).patch('tokens.density','compact')
      .patch('layout.container','content').patch('layout.maxWidth',960);
    final expected = AdvancedThemeTokens(changed,'main').spacing;
    expect(expected,6);
    await t.pumpWidget(scene(advanced:changed)); await t.pumpAndSettle();
    expect(commands.length,reads);
    expect(controller.state.phase,'list');
    expect(find.text('Fixture title'),findsOneWidget);
    expect(_frame(t).constraints.maxWidth,960);
    expect(t.getSize(find.byWidget(_frame(t))).width,960);
    expect(_outerPadding(t).padding,EdgeInsets.all(expected));
    final card = t.widget<PrimeCard>(find.byType(PrimeCard));
    expect((card.child! as Padding).padding,EdgeInsets.all(expected));
    final paging = t.widget<Wrap>(find.byType(Wrap));
    expect(paging.spacing,expected); expect(paging.runSpacing,expected);
    expect(t.takeException(),isNull);
  });
  testWidgets('fullwidth theme does not acquire the boxed maximum-width cap', (t) async {
    await t.binding.setSurfaceSize(const Size(1800,1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    final theme = AdvancedTheme.defaults().patch('layout.container','fullwidth')
      .patch('layout.maxWidth',960).patch('tokens.spacing',20);
    await t.pumpWidget(scene(advanced:theme));
    expect(_frame(t).constraints.maxWidth,double.infinity);
    expect(t.getSize(find.byWidget(_frame(t))).width,1800);
    expect(_outerPadding(t).padding,EdgeInsets.all(AdvancedThemeTokens(theme,'main').spacing));
    expect(commands,isEmpty);
    expect(t.takeException(),isNull);
  });
  testWidgets('missing extension uses registered defaults and retired states retain theme layout', (t) async {
    await t.pumpWidget(scene());
    final defaults = AdvancedThemeTokens(AdvancedTheme.defaults(),'main');
    expect(_outerPadding(t).padding,EdgeInsets.all(defaults.spacing));
    expect(_cardPadding(t,'idle').padding,EdgeInsets.all(defaults.spacing));
    expect(_frame(t).constraints.maxWidth,double.infinity);
    expect(commands,isEmpty);
    final theme = AdvancedTheme.defaults().patch('tokens.spacing',12)
      .patch('tokens.density','compact').patch('layout.container','content')
      .patch('layout.maxWidth',1000);
    controller.retire();
    await t.pumpWidget(scene(advanced:theme)); await t.pumpAndSettle();
    final expected = AdvancedThemeTokens(theme,'main').spacing;
    expect(_frame(t).constraints.maxWidth,1000);
    expect(_outerPadding(t).padding,EdgeInsets.all(expected));
    expect(_cardPadding(t,'retired').padding,EdgeInsets.all(expected));
    expect(find.byType(TextButton),findsNothing);
    expect(commands,isEmpty);
    expect(t.takeException(),isNull);
  });
}
