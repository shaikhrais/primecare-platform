import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/network/api_client.dart';

final oldToken=List.filled(43,'c').join(),newToken=List.filled(43,'b').join(),replacementToken=List.filled(43,'d').join();
class ManagedAuth extends AuthNotifier {
  @override
  AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,role:'code_admin',userId:'owner',token:oldToken,tenantId:'synthetic-tenant',userName:'synthetic@example.invalid');
}
class ManagementApi extends Fake implements ApiClient {
  final calls=<String>[],revoked=<String>[];
  Completer<ApiResponse>? pending,identity;
  Map<String,dynamic>? replyOverride;
  bool foreignIdentity=false;
  @override
  Future<ApiResponse> post(String path,{dynamic body,Map<String,String>? headers}) async {
    calls.add(path);
    if(path.endsWith('/login'))return ApiResponse(statusCode:200,data:{'token':replacementToken,'role':'rmt','userId':'replacement-user','tenantId':'replacement-tenant'});
    if(pending!=null)return pending!.future;
    return ApiResponse(statusCode:200,data:replyOverride ?? (path.endsWith('recovery-codes')
      ? {'status':'recovery_codes_issued','recoveryCodes':List.generate(10,(i)=>String.fromCharCode(65+i)+List.filled(25,'A').join())}
      : path.endsWith('/confirm') ? {'status':'authenticated','token':newToken,'role':'code_admin','userId':'owner'}
      : {'status':'mfa_replacement_required','challenge':List.filled(43,'r').join(),'setupKey':List.filled(32,'A').join()}));
  }
  @override
  Future<ApiResponse> confirmSession(String value) async {
    expect(value,newToken);calls.add('confirm');if(identity!=null)return identity!.future;
    return ApiResponse(statusCode:200,data:{'status':'authenticated','roles':'code_admin','userId':foreignIdentity?'foreign':'owner'});
  }
  @override
  Future<ApiResponse> revokeSession(String value)async{revoked.add(value);return ApiResponse(statusCode:200,data:{'status':'signed_out'});}
}
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(()=>SharedPreferences.setMockInitialValues({}));
  ProviderContainer fixture(ManagementApi api)=>ProviderContainer(overrides:[authProvider.overrideWith(ManagedAuth.new),apiClientProvider.overrideWithValue(api)]);
  test('code management keeps proof transient and never changes session authority',()async{
    final api=ManagementApi(),c=fixture(api);addTearDown(c.dispose);
    final result=await c.read(authProvider.notifier).manageMfa(MfaManagementAction.recoveryCodes,'synthetic-password','123456');
    expect(result?['recoveryCodes'],hasLength(10));expect(c.read(authProvider).token,oldToken);
    expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);expect(api.calls,['/v1/auth/mfa/recovery-codes']);
  });
  test('duplicate codes and unexpected authority fail without clearing the current actor',()async{
    final api=ManagementApi(),c=fixture(api);addTearDown(c.dispose);final auth=c.read(authProvider.notifier);
    api.replyOverride={'status':'recovery_codes_issued','recoveryCodes':List.filled(10,List.filled(26,'A').join())};
    expect(await auth.manageMfa(MfaManagementAction.recoveryCodes,'p','123456'),isNull);
    api.replyOverride={'status':'mfa_replacement_required','token':newToken};
    expect(await auth.manageMfa(MfaManagementAction.replace,'p','123456'),isNull);
    expect(api.revoked,[newToken]);expect(c.read(authProvider).token,oldToken);expect(c.read(authProvider).isAuthenticated,true);
  });
  test('replacement authority is stored only after the matching owned identity is confirmed',()async{
    final api=ManagementApi()..identity=Completer<ApiResponse>(),c=fixture(api);addTearDown(c.dispose);
    final pending=c.read(authProvider.notifier).confirmManagedMfa(List.filled(43,'r').join(),'123456');
    while(!api.calls.contains('confirm')){await Future<void>.delayed(Duration.zero);}
    expect(c.read(authProvider).token,oldToken);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
    api.identity!.complete(ApiResponse(statusCode:200,data:{'status':'authenticated','roles':'code_admin','userId':'owner'}));
    expect(await pending,true);expect(c.read(authProvider).token,newToken);
    expect((await SharedPreferences.getInstance()).getString('auth_token'),newToken);
  });
  test('unconfirmed replacement revokes provisional authority and removes the invalidated old actor',()async{
    final api=ManagementApi()..foreignIdentity=true,c=fixture(api);addTearDown(c.dispose);
    expect(await c.read(authProvider.notifier).confirmManagedMfa(List.filled(43,'r').join(),'123456'),false);
    expect(api.revoked,containsAll([newToken,oldToken]));expect(c.read(authProvider).isAuthenticated,false);
    expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
  });
  test('a newer actor survives a late management confirmation and its cleanup',()async{
    final api=ManagementApi()..identity=Completer<ApiResponse>(),c=fixture(api);addTearDown(c.dispose);final auth=c.read(authProvider.notifier);
    final pending=auth.confirmManagedMfa(List.filled(43,'r').join(),'123456');
    while(!api.calls.contains('confirm')){await Future<void>.delayed(Duration.zero);}
    expect(await auth.login('replacement@example.invalid','synthetic-password'),true);
    api.identity!.complete(ApiResponse(statusCode:200,data:{'status':'authenticated','roles':'code_admin','userId':'owner'}));
    expect(await pending,false);expect(api.revoked,[newToken]);expect(c.read(authProvider).userId,'replacement-user');
    expect((await SharedPreferences.getInstance()).getString('auth_token'),replacementToken);
  });
}
