import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/features/auth/auth_experience.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}

void main() {
  for (final size in [const Size(360, 800), const Size(1440, 1000)]) {
    for (final page in AuthPage.values.where((p) => p != AuthPage.language)) {
      testWidgets('${page.name} fits ${size.width}', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(ProviderScope(overrides: [
          authProvider.overrideWith(GuestAuth.new),
        ], child: MaterialApp(home: PrimeAuthExperience(page: page))));
        await tester.pump();
        expect(tester.takeException(), isNull);
        expect(find.byType(PrimeAuthExperience), findsOneWidget);
      });
    }
  }

  testWidgets('password visibility is explicit and reversible', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: PrimeAuthTextField(
      id: 'password-test', label: 'Password', password: true, onChanged: (_) {},
    ))));
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isTrue);
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isFalse);
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(tester.widget<EditableText>(find.byType(EditableText)).obscureText, isTrue);
  });

  testWidgets('recovery link stays in the app and retains safe return path', (tester) async {
    final router = GoRouter(initialLocation: '/login?returnUrl=%2Fappointments&enable-semantics=true', routes: [
      GoRoute(path: '/login', builder: (_, __) => const PrimeAuthExperience(page: AuthPage.login)),
      GoRoute(path: '/forgot-password', builder: (_, __) => const Scaffold(body: Text('Recovery destination'))),
    ]);
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(overrides: [authProvider.overrideWith(GuestAuth.new)], child: MaterialApp.router(routerConfig: router)));
    await tester.pumpAndSettle();
    final link = find.text('auth_design_forgot');
    await tester.ensureVisible(link);
    await tester.tap(link);
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, '/forgot-password');
    expect(router.routeInformationProvider.value.uri.queryParameters['returnUrl'], '/appointments');
    expect(find.text('Recovery destination'), findsOneWidget);
  });
}
