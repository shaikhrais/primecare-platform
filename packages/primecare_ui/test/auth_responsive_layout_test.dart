import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class _AuthFixture implements AuthTransport {
  final paths = <String>[];
  @override
  Future<Map<String, dynamic>> send(String method, String path, {Map<String, dynamic>? body, String? token}) async {
    paths.add(path);
    if (path == '/login' || path == '/me') {
      return {'userId': '00000000-0000-4000-8000-000000000001', 'role': 'client', 'status': 'authenticated', 'token': 'a' * 43};
    }
    return {'message': 'Server text must not replace the shared translations', 'status': 'signed_out'};
  }
}

class _AuthApp extends BasePrimecareApp {
  const _AuthApp(AuthTransport transport) : super(appCode: 'layout-test', title: 'PrimeCare', authTransport: transport);
}

Widget _accessibleHost(AuthTransport transport) => ListenableBuilder(
  listenable: applicationLanguage,
  builder: (_, _) => MaterialApp(
    locale: Locale(applicationLanguage.language.name), supportedLocales: AppStrings.locales, localizationsDelegates: AppStrings.delegates,
    builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2), viewInsets: const EdgeInsets.only(bottom: 160)), child: child!),
    home: AuthScreen(title: 'PrimeCare', transport: transport),
  ),
);

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}

void viewport(WidgetTester tester, double width, double height) {
  tester.view.physicalSize = Size(width, height); tester.view.devicePixelRatio = 1;
}

void main() {
  WidgetController.hitTestWarningShouldBeFatal = true;
  tearDown(() => applicationLanguage.selectLanguage(SupportedLanguage.en));
  for (final language in SupportedLanguage.values) {
    for (final dimensions in [const Size(320, 568), const Size(600, 960), const Size(1024, 768), const Size(1920, 1080), const Size(3840, 2160)]) {
      testWidgets('Inherited Auth workflows fit ${dimensions.width.toInt()} pixels in ${language.name}', (tester) async {
        viewport(tester, dimensions.width, dimensions.height);
        addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
        applicationLanguage.selectLanguage(language); final strings = AppStrings(language.name); final api = _AuthFixture();
        await tester.pumpWidget(_AuthApp(api)); await tester.pumpAndSettle();
        expect(tester.getSize(find.byType(Form)).width, lessThanOrEqualTo(dimensions.width >= 2560 ? 560 : 440));
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.signIn')));
        expect(find.text(strings.text('required', {'field': strings.text('auth.email')})), findsOneWidget);
        expect(api.paths, isEmpty);
        await tapVisible(tester, find.text(strings.text('auth.forgot')));
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.email')), 'qa@example.invalid');
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.sendRecovery')));
        expect(find.text(strings.text('auth.recoverySent')), findsOneWidget);
        expect(find.text('Server text must not replace the shared translations'), findsNothing);
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.resetCode')), 'ABCDEF123456');
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.newPassword')), 'reset-password-1234');
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.reset')));
        expect(find.text(strings.text('auth.resetDone')), findsOneWidget);
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.password')), 'reset-password-1234');
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.signIn')));
        expect(find.text(strings.text('auth.signedIn')), findsOneWidget);
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.checkSession')));
        await tapVisible(tester, find.widgetWithText(TextButton, strings.text('auth.changePassword')));
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.currentPassword')), 'reset-password-1234');
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.newPassword')), 'updated-password-1234');
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.changePassword')));
        expect(find.text(strings.text('auth.changeDone')), findsOneWidget);
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.email')), 'qa@example.invalid');
        await tester.enterText(find.widgetWithText(TextFormField, strings.text('auth.password')), 'updated-password-1234');
        await tapVisible(tester, find.widgetWithText(FilledButton, strings.text('auth.signIn')));
        await tapVisible(tester, find.widgetWithText(OutlinedButton, strings.text('auth.signOut')));
        expect(find.text(strings.text('auth.signedIn')), findsNothing);
        expect(api.paths, ['/forgot-password', '/reset-password', '/login', '/me', '/change-password', '/login', '/logout']);
      });
    }
    testWidgets('Auth preserves drafts through language menus and phone/landscape/4K resizing from ${language.name}', (tester) async {
      viewport(tester, 320, 640); addTearDown(tester.view.resetPhysicalSize); addTearDown(tester.view.resetDevicePixelRatio);
      applicationLanguage.selectLanguage(language); final api = _AuthFixture();
      await tester.pumpWidget(_accessibleHost(api)); await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextFormField, AppStrings(language.name).text('auth.email')), 'draft@example.invalid');
      await tester.enterText(find.widgetWithText(TextFormField, AppStrings(language.name).text('auth.password')), 'private-draft-1234');
      for (final next in SupportedLanguage.values) {
        FocusManager.instance.primaryFocus?.unfocus(); await tester.pumpAndSettle();
        await tester.tap(find.byType(PopupMenuButton<SupportedLanguage>)); await tester.pumpAndSettle();
        final name = switch(next) {SupportedLanguage.en => 'English', SupportedLanguage.es => 'Español', SupportedLanguage.fr => 'Français'};
        await tester.tap(find.widgetWithText(PopupMenuItem<SupportedLanguage>, name)); await tester.pumpAndSettle();
        final strings = AppStrings(next.name);
        expect(tester.widget<TextFormField>(find.widgetWithText(TextFormField, strings.text('auth.email'))).controller!.text, 'draft@example.invalid');
        expect(tester.widget<TextFormField>(find.widgetWithText(TextFormField, strings.text('auth.password'))).controller!.text, 'private-draft-1234');
        expect(tester.takeException(), isNull);
      }
      for (final dimensions in [const Size(667, 375), const Size(3840, 2160), const Size(320, 640)]) {
        viewport(tester, dimensions.width, dimensions.height); await tester.pumpAndSettle();
        expect(find.text('draft@example.invalid'), findsOneWidget);
        expect(tester.widget<EditableText>(find.descendant(of: find.widgetWithText(TextFormField, AppStrings('fr').text('auth.password')), matching: find.byType(EditableText))).obscureText, isTrue);
        expect(tester.takeException(), isNull);
      }
      tester.view.physicalSize = const Size(3840, 2160); tester.view.devicePixelRatio = 2;
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(Form)).width, lessThanOrEqualTo(440));
      expect(find.text('draft@example.invalid'), findsOneWidget);
      expect(tester.takeException(), isNull);
      expect(api.paths, isEmpty);
    });
  }
}
