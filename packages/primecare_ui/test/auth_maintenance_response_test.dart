import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/maintenance/maintenance_configuration_screen.dart';

class MaintenanceActor extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
      token: 'ceo-token', userId: 'ceo-user', tenantId: 'ceo-tenant', role: 'ceo');
  void replaceSession() {
    state = AuthState(isInitialized: true, isAuthenticated: true,
        token: 'replacement', userId: 'replacement-user', tenantId: 'other-tenant', role: 'ceo');
  }
}

class MaintenanceApi extends Fake implements ApiClient {
  dynamic payload = <String, dynamic>{};
  int status = 200;
  int reads = 0;
  Completer<ApiResponse>? pending;
  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters}) async {
    reads++;
    return ApiResponse(statusCode: 200, data: {
      'sender': 'sender@example.test', 'revision': 0,
      'settingsReady': true, 'emailReady': true, 'templates': <String, dynamic>{},
      'pending': <String>[], 'externalConfiguration': <dynamic>[], 'audit': <dynamic>[],
    });
  }
  @override
  Future<ApiResponse> post(String path, {dynamic body, Map<String, String>? headers}) async =>
      pending == null ? ApiResponse(statusCode: status, data: payload) : await pending!.future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final operation in ['save', 'test', 'create']) {
    testWidgets('maintenance $operation rejects malformed success before clearing drafts or reloading', (tester) async {
      final api = MaintenanceApi();
      await tester.pumpWidget(ProviderScope(overrides: [
        authProvider.overrideWith(MaintenanceActor.new), apiClientProvider.overrideWithValue(api),
      ], child: const MaterialApp(home: MaintenanceConfigurationScreen())));
      await tester.pumpAndSettle();
      final email = find.widgetWithText(TextField, 'IT team member email');
      final password = find.widgetWithText(TextField, 'Initial password (12+ characters)');
      await tester.ensureVisible(email);
      await tester.enterText(email, 'new@example.test');
      await tester.enterText(password, 'fixture-password-123');
      final button = find.text(operation == 'save' ? 'Save email settings and templates'
          : operation == 'test' ? 'Send test email to my signed-in account' : 'Create maintenance account');
      Future<void> submit() async {
        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pumpAndSettle();
      }
      for (final payload in <dynamic>[null, [], {}, {'message': 'unexpected success'},
        {'user': {'id': 'created', 'email': 'new@example.test', 'roles': 'maintenance',
          'status': 'active', 'tenant_id': 'foreign-tenant'}}]) {
        api.payload = payload;
        await submit();
        expect(api.reads, 1);
        expect(find.text('Maintenance account created. Share access through your approved IT process.'), findsNothing);
        expect(tester.widget<TextField>(password).controller!.text, 'fixture-password-123');
      }
      api.status = operation == 'create' ? 201 : 200;
      api.payload = operation == 'save'
          ? {'message': 'Settings saved. Send a test email to check delivery.'}
          : operation == 'test'
              ? {'message': 'Provider accepted the test. Check your inbox/spam to confirm delivery.'}
              : {'user': {'id': 'created', 'email': 'new@example.test', 'roles': 'maintenance',
                  'status': 'active', 'tenant_id': 'ceo-tenant'}};
      await submit();
      expect(api.reads, operation == 'create' ? 1 : 2);
      expect(tester.widget<TextField>(password).controller!.text,
          operation == 'create' ? '' : 'fixture-password-123');
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets('maintenance ignores an acknowledgement after actor replacement', (tester) async {
    final api = MaintenanceApi()..pending = Completer<ApiResponse>();
    final actor = MaintenanceActor();
    await tester.pumpWidget(ProviderScope(overrides: [
      authProvider.overrideWith(() => actor), apiClientProvider.overrideWithValue(api),
    ], child: const MaterialApp(home: MaintenanceConfigurationScreen())));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save email settings and templates'));
    await tester.pump();
    actor.replaceSession();
    api.pending!.complete(ApiResponse(statusCode: 200, data: {
      'message': 'Settings saved. Send a test email to check delivery.',
    }));
    await tester.pumpAndSettle();
    expect(api.reads, 1);
    expect(find.text('Settings saved. Send a test email to check delivery.'), findsNothing);
    expect(find.text('Verified sender email'), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
