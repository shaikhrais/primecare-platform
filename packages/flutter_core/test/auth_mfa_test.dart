import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/network/api_client.dart';

class GuestAuth extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true);
}
class MfaApi extends Fake implements ApiClient {
  final challenge = List.filled(43, 'a').join();
  final token = List.filled(43, 'b').join();
  Map<String, dynamic>? challengeOverride;
  Map<String, dynamic>? factorOverride;
  final calls = <String>[];
  final revoked = <String>[];
  int factorStatus = 200;
  bool identityMatches = true;
  Completer<ApiResponse>? identity;
  Completer<ApiResponse>? factor;
  @override
  Future<ApiResponse> post(String path, {dynamic body, Map<String, String>? headers}) async {
    calls.add(path);
    if (path.endsWith('/login')) return ApiResponse(statusCode: 200, data: challengeOverride ?? {
      'status': 'mfa_required', 'challenge': challenge, 'purpose': 'enroll', 'setupKey': List.filled(32, 'A').join(),
    });
    expect(path, '/v1/auth/mfa');
    expect(body, {'challenge': challenge, 'code': '123456'});
    if (factor != null) return factor!.future;
    return ApiResponse(statusCode: factorStatus, data: factorOverride ?? {'status':'authenticated', 'token':token, 'role':'code_admin', 'userId':'owner'});
  }
  @override
  Future<ApiResponse> confirmSession(String value) async {
    expect(value, token); calls.add('confirm');
    if (identity != null) return identity!.future;
    return ApiResponse(statusCode:200, data:{'status':'authenticated','roles':'code_admin','userId':identityMatches ? 'owner' : 'foreign'});
  }
  @override
  Future<ApiResponse> revokeSession(String value) async { revoked.add(value); return ApiResponse(statusCode:200, data:{'status':'signed_out'}); }
}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() { SharedPreferences.setMockInitialValues({}); authListenable.value = false; });
  ProviderContainer fixture(MfaApi api) => ProviderContainer(overrides:[apiClientProvider.overrideWithValue(api),authProvider.overrideWith(GuestAuth.new)]);
  test('challenge and code never persist; session is confirmed before authority is retained', () async {
    final api=MfaApi();
    final c=fixture(api); addTearDown(c.dispose);
    final auth=c.read(authProvider.notifier); api.identity=Completer<ApiResponse>();
    final started=Completer<void>();
    final login=auth.login('synthetic@example.invalid','synthetic-password',completeMfa:(challenge,verify) async {
      expect(challenge['purpose'],'enroll'); expect(c.read(authProvider).isAuthenticated,false);
      expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
      final verifying=verify('123456'); started.complete();
      await verifying.then((value)=>expect(value,true));
    });
    await started.future;
    while (!api.calls.contains('confirm')) { await Future<void>.delayed(Duration.zero); }
    expect(c.read(authProvider).isAuthenticated,false);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
    api.identity!.complete(ApiResponse(statusCode:200,data:{'status':'authenticated','roles':'code_admin','userId':'owner'}));
    expect(await login,true);expect(c.read(authProvider).token,api.token);expect(c.read(authProvider).role,'code_admin');
    final prefs=await SharedPreferences.getInstance();expect(prefs.getString('auth_token'),api.token);expect(prefs.getKeys().any((k)=>k.contains('mfa')||k.contains('code')),false);
  });
  test('cancellation and unsupported client create no session or stored credential', () async {
    final api=MfaApi();final container=fixture(api);addTearDown(container.dispose);
    final auth=container.read(authProvider.notifier);
    expect(await auth.login('e','p'),false);
    expect(await auth.login('e','p',completeMfa:(challenge,verify) async {}),false);
    expect(api.calls.every((p)=>p.endsWith('/login')),true);expect(container.read(authProvider).isAuthenticated,false);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
  test('wrong factor can retry the same challenge and cannot authenticate early', () async {
    final api=MfaApi();final container=fixture(api);addTearDown(container.dispose);
    expect(await container.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {
      api.factorStatus=401;expect(await verify('123456'),false);expect(container.read(authProvider).isAuthenticated,false);
      api.factorStatus=200;expect(await verify('123456'),true);
    }),true);
  });
  test('closed prompt invalidates a captured verifier without making a factor request', () async {
    final api=MfaApi();final c=fixture(api);addTearDown(c.dispose);
    late Future<bool> Function(String) captured;
    expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {captured=verify;}),false);
    expect(await captured('123456'),false);
    expect(api.calls, ['/v1/auth/login']);
    expect(api.revoked,isEmpty);
    expect(c.read(authProvider).isAuthenticated,false);
    expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
  for (final closingDuringConfirmation in [false,true]) {
    test('prompt closure revokes a late ${closingDuringConfirmation ? "confirmation" : "factor"} response', () async {
      final api=MfaApi();final c=fixture(api);addTearDown(c.dispose);
      final response=Completer<ApiResponse>();
      if (closingDuringConfirmation) {api.identity=response;} else {api.factor=response;}
      late Future<bool> verification;
      expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {
        verification=verify('123456');
        final waitingFor=closingDuringConfirmation ? 'confirm' : '/v1/auth/mfa';
        while (!api.calls.contains(waitingFor)) {await Future<void>.delayed(Duration.zero);}
        // Model prompt disposal without logout or a replacement login.
      }),false);
      response.complete(ApiResponse(statusCode:200,data:closingDuringConfirmation
        ? {'status':'authenticated','roles':'code_admin','userId':'owner'}
        : {'status':'authenticated','token':api.token,'role':'code_admin','userId':'owner'}));
      expect(await verification,false);
      expect(api.revoked,[api.token]);
      expect(c.read(authProvider).isAuthenticated,false);
      expect(c.read(authProvider).token,isNull);
      expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
      if (!closingDuringConfirmation) expect(api.calls, isNot(contains('confirm')));
    });
  }
  test('identity mismatch revokes provisional MFA session', () async {
    final api=MfaApi()..identityMatches=false;final c=fixture(api);addTearDown(c.dispose);
    expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async { expect(await verify('123456'),false); }),false);
    expect(api.revoked,[api.token]);expect(c.read(authProvider).isAuthenticated,false);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
  test('malformed challenge cannot open factor prompt', () async {
    final api=MfaApi()..challengeOverride={'status':'mfa_required','challenge':'bad','purpose':'enroll','setupKey':'bad'};final c=fixture(api);addTearDown(c.dispose);var prompted=false;
    expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {prompted=true;}),false);expect(prompted,false);
  });
  test('a challenge carrying unexpected authority is revoked without opening a prompt', () async {
    final api=MfaApi();final c=fixture(api);addTearDown(c.dispose);var prompted=false;
    api.challengeOverride={'status':'mfa_required','challenge':api.challenge,'purpose':'verify','token':api.token};
    expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {prompted=true;}),false);
    expect(prompted,false);expect(api.calls,['/v1/auth/login']);expect(api.revoked,[api.token]);
    expect(c.read(authProvider).isAuthenticated,false);expect(c.read(authProvider).token,isNull);
    expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
  for (final failure in ['http-status','envelope-status','token-format']) {
    test('rejected MFA $failure revokes returned authority without confirming or persisting it', () async {
      final api=MfaApi();final c=fixture(api);addTearDown(c.dispose);
      final issued=failure=='token-format' ? 'malformed-provisional-token' : api.token;
      api.factorStatus=failure=='http-status' ? 401 : 200;
      api.factorOverride={'status':failure=='envelope-status' ? 'unexpected' : 'authenticated',
        'token':issued,'role':'code_admin','userId':'owner'};
      expect(await c.read(authProvider.notifier).login('e','p',completeMfa:(challenge,verify) async {
        expect(await verify('123456'),false);
      }),false);
      expect(api.calls,isNot(contains('confirm')));expect(api.revoked,[issued]);
      expect(c.read(authProvider).isAuthenticated,false);expect(c.read(authProvider).token,isNull);
      expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
    });
  }
  test('logout during factor confirmation wins and revokes its late token', () async {
    final api=MfaApi()..identity=Completer<ApiResponse>();final c=fixture(api);addTearDown(c.dispose);final auth=c.read(authProvider.notifier);
    final login=auth.login('e','p',completeMfa:(challenge,verify) async {expect(await verify('123456'),false);});
    while (!api.calls.contains('confirm')) {await Future<void>.delayed(Duration.zero);}
    await auth.logout();api.identity!.complete(ApiResponse(statusCode:200,data:{'status':'authenticated','roles':'code_admin','userId':'owner'}));
    expect(await login,false);expect(api.revoked,[api.token]);expect(c.read(authProvider).isAuthenticated,false);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
}
