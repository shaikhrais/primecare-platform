import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

const task = AdminTask(id: 'workspace', titleKey: 'task.workspace.title', descriptionKey: 'task.workspace.description', operation: 'workspace.read');
final longEmail = '${'account' * 25}@example.invalid';

Future<Map<String, dynamic>> request(String method, String path, {Map<String, dynamic>? body}) async {
  final query = Uri.parse(path).queryParameters;
  if (path.startsWith('/admin/workspace/audit')) {
    return {'events': [{'id': 'audit-1', 'actor': '00000000-0000-4000-8000-000000000001', 'target': '00000000-0000-4000-8000-000000000002', 'action': 'account_updated', 'createdAt': '2026-10-11T00:00:00Z', 'before': {'email': longEmail}, 'after': {'role': 'rmt', 'status': 'inactive'}}], 'total': 1, 'offset': 0, 'limit': 25};
  }
  return {'organization': {'name': 'Organization'}, 'users': [{'id': 'user-1', 'email': longEmail, 'role': 'rmt', 'status': 'active'}, {'id': 'admin-1', 'email': 'admin@example.invalid', 'role': 'admin', 'status': 'active'}], 'assignableRoles': ['client', 'rmt'], 'total': 2, 'active': 2, 'offset': 0, 'limit': 25, 'search': query['search'] ?? '', 'status': query['status'] ?? ''};
}

Widget host(Widget child, SupportedLanguage language, {double textScale = 1}) => MaterialApp(
  locale: Locale(language.name), supportedLocales: AppStrings.locales, localizationsDelegates: AppStrings.delegates,
  builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)), child: child!),
  home: child,
);

void main() {
  tearDown(() => applicationLanguage.selectLanguage(SupportedLanguage.en));
  for (final language in SupportedLanguage.values) {
    for (final width in [320.0, 600.0, 1024.0, 1920.0, 3840.0]) {
      testWidgets('Admin screens fit ${width.toInt()} logical pixels in ${language.name}', (tester) async {
        tester.view.physicalSize = Size(width, switch(width) {320 => 568, 600 => 960, 1024 => 768, 1920 => 1080, _ => 2160}); tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
        applicationLanguage.selectLanguage(language);
        for (final screen in [AdminScreen(request: request), AdminAuditScreen(request: request), const AdminTasksScreen(tasks: [task])]) {
          await tester.pumpWidget(host(screen, language)); await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          final list = find.byType(ListView);
          expect(tester.getSize(list).width, lessThanOrEqualTo(PrimecareLayoutData(width).maxContentWidth));
          await tester.drag(list, const Offset(0, -900)); await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      });
    }
    testWidgets('Mobile Admin editor supports double-size text in ${language.name}', (tester) async {
      tester.view.physicalSize = const Size(320, 640); tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
      applicationLanguage.selectLanguage(language); final strings = AppStrings(language.name);
      await tester.pumpWidget(host(AdminScreen(request: request), language, textScale: 2)); await tester.pumpAndSettle();
      final create = find.widgetWithText(FilledButton, strings.text('admin.create'));
      await tester.ensureVisible(create); await tester.pumpAndSettle(); await tester.tap(create); await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget); expect(tester.takeException(), isNull);
      await tester.enterText(find.widgetWithText(TextFormField, strings.text('admin.email')), 'draft@example.invalid');
      tester.view.physicalSize = const Size(3840, 2160); await tester.pumpAndSettle();
      expect(find.text('draft@example.invalid'), findsOneWidget); expect(tester.takeException(), isNull);
    });
  }
  testWidgets('Window resize preserves search input and does not reload business data', (tester) async {
    tester.view.physicalSize = const Size(375, 1000); tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
    var calls = 0;
    Future<Map<String, dynamic>> counted(String method, String path, {Map<String, dynamic>? body}) { calls++; return request(method, path, body: body); }
    await tester.pumpWidget(host(AdminScreen(request: counted), SupportedLanguage.en)); await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'unsaved search');
    tester.view.physicalSize = const Size(3840, 2160); await tester.pumpAndSettle();
    expect(find.text('unsaved search'), findsOneWidget); expect(calls, 1); expect(tester.takeException(), isNull);
  });
}
