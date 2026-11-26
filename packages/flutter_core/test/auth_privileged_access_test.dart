import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/application/controllers/privileged_access_service.dart';

String uid(int n)=>'${n.toString().padLeft(8,'0')}-1111-4111-8111-111111111111';
final oldToken=List.filled(43,'a').join(),newToken=List.filled(43,'b').join();
class PrivilegedActor extends AuthNotifier {
  final String role;
  PrivilegedActor([this.role='code_admin']);
  @override
  AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userId:uid(role=='tenant_admin'?2:1),role:role,token:oldToken,tenantId:uid(11));
  void replace()=>state=AuthState(isInitialized:true,isAuthenticated:true,userId:uid(3),role:'code_admin',token:newToken,tenantId:uid(13));
}
class PrivilegedApi extends Fake implements ApiClient {
  final calls=<String>[],bodies=<Map<String,dynamic>>[],revoked=<String>[];
  final deadline=DateTime.now().toUtc().add(const Duration(minutes:10));
  Completer<ApiResponse>? pending;
  Map<String,dynamic>? reply;
  bool offline=false;
  Map<String,dynamic> request()=>{'requestId':uid(22),'requesterId':uid(1),'tenantId':uid(11),'ticket':'SYN-1','reason':'Investigate tenant sign-in counts','scope':['tenant_security_summary'],'expiresAt':deadline.toIso8601String(),'state':'pending'};
  @override
  Future<ApiResponse> get(String path,{Map<String,dynamic>? queryParameters})async{
    calls.add(path);if(offline)throw StateError('offline');if(pending!=null)return pending!.future;
    return ApiResponse(statusCode:200,data:reply??{'requests':[request()]});
  }
  @override
  Future<ApiResponse> post(String path,{dynamic body,Map<String,String>? headers})async{
    calls.add(path);bodies.add(Map<String,dynamic>.from(body as Map));expect(headers?['Authorization'],'Bearer $oldToken');
    if(offline)throw StateError('offline');if(pending!=null)return pending!.future;
    final data=reply??(path.endsWith('/elevation')?{'status':'elevated','elevationId':uid(21),'expiresAt':deadline.toIso8601String(),'scope':['tenant_security_summary']}
      :path.endsWith('/request')?request():path.endsWith('/summary')?{'tenantId':uid(11),'activeAccounts':2,'activeSessions':3,'enrolledAuthenticators':1}
      :path.endsWith('/approve')?{'status':'approved','requestId':uid(22),'expiresAt':deadline.toIso8601String()}:{'status':'revoked'});
    return ApiResponse(statusCode:200,data:data);
  }
  @override
  Future<ApiResponse> revokeSession(String token)async{revoked.add(token);return ApiResponse(statusCode:200,data:{'status':'signed_out'});}
}
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();setUp(()=>SharedPreferences.setMockInitialValues({}));
 ProviderContainer fixture(PrivilegedApi api,{PrivilegedActor? actor})=>ProviderContainer(overrides:[authProvider.overrideWith(()=>actor??PrivilegedActor()),apiClientProvider.overrideWithValue(api)]);
 TemporaryElevation elevation(PrivilegedApi api)=>TemporaryElevation(uid(21),api.deadline);
 TenantSupportRequest request(PrivilegedApi api)=>TenantSupportRequest(id:uid(22),requesterId:uid(1),tenantId:uid(11),ticket:'SYN-1',reason:'Investigate tenant sign-in counts',status:'pending',expiresAt:api.deadline);
 test('fixed registered elevation scope never changes role session or local persistence',()async{
  final api=PrivilegedApi(),c=fixture(api);addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  final result=await service.elevate('synthetic-password','123456','Investigate tenant sign-in counts');
  expect(result?.id,uid(21));expect(service.canElevate,true);expect(service.canApprove,false);
  expect(api.bodies.single,{'password':'synthetic-password','code':'123456','reason':'Investigate tenant sign-in counts','scope':['tenant_security_summary'],'seconds':900});
  expect(c.read(authProvider).token,oldToken);expect(c.read(authProvider).role,'code_admin');expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
 });
 test('malformed or overlong grant receipt and unexpected bearer authority fail closed',()async{
  final api=PrivilegedApi(),c=fixture(api);addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  for(final receipt in [
   {'status':'elevated','elevationId':uid(21),'expiresAt':api.deadline.toIso8601String(),'scope':['clinical_records']},
   {'status':'elevated','elevationId':uid(21),'expiresAt':DateTime.now().toUtc().add(const Duration(hours:1)).toIso8601String(),'scope':['tenant_security_summary']},
   {'status':'elevated','elevationId':uid(21),'expiresAt':api.deadline.toIso8601String(),'scope':['tenant_security_summary'],'token':newToken},
  ]){api.reply=receipt;expect(await service.elevate('synthetic-password','123456','Investigate tenant sign-in counts'),isNull);}
  expect(api.revoked,[newToken]);expect(c.read(authProvider).token,oldToken);expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
 });
 test('support request validates tenant requester purpose and elevation deadline',()async{
  final api=PrivilegedApi(),c=fixture(api);addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  expect((await service.requestSupport(elevation(api),uid(11),'SYN-1','Investigate tenant sign-in counts'))?.id,uid(22));
  for(final receipt in [{...api.request(),'tenantId':uid(12)},{...api.request(),'requesterId':uid(9)},{...api.request(),'state':'approved'},{...api.request(),'expiresAt':api.deadline.add(const Duration(seconds:1)).toIso8601String()}]){
   api.reply=receipt;expect(await service.requestSupport(elevation(api),uid(11),'SYN-1','Investigate tenant sign-in counts'),isNull);
  }
  expect(c.read(authProvider).token,oldToken);
 });
 test('tenant approval list rejects foreign duplicate or personal account fields',()async{
  final api=PrivilegedApi(),c=fixture(api,actor:PrivilegedActor('tenant_admin'));addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  expect(service.canApprove,true);expect(service.canElevate,false);expect((await service.listRequests())?.length,1);
  for(final rows in [[{...api.request(),'tenantId':uid(12)}],[api.request(),api.request()],[{...api.request(),'email':'private@example.invalid'}]]){
   api.reply={'requests':rows};expect(await service.listRequests(),isNull);
  }
  expect(c.read(authProvider).role,'tenant_admin');
 });
 test('summary accepts only owned request aggregate counts for the expected tenant',()async{
  final api=PrivilegedApi(),c=fixture(api);addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  final result=await service.summary(request(api));expect(result?.activeAccounts,2);expect(result?.activeSessions,3);expect(result?.enrolledAuthenticators,1);
  for(final receipt in [
   {'tenantId':uid(12),'activeAccounts':2,'activeSessions':3,'enrolledAuthenticators':1},
   {'tenantId':uid(11),'activeAccounts':-1,'activeSessions':3,'enrolledAuthenticators':1},
   {'tenantId':uid(11),'activeAccounts':'2','activeSessions':3,'enrolledAuthenticators':1},
   {'tenantId':uid(11),'activeAccounts':2,'activeSessions':3,'enrolledAuthenticators':1,'users':<Map<String,dynamic>>[]},
  ]){api.reply=receipt;expect(await service.summary(request(api)),isNull);}
  expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
 });
 test('tenant decisions require exact acknowledgements without extending approval expiry',()async{
  final api=PrivilegedApi(),c=fixture(api,actor:PrivilegedActor('tenant_admin'));addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  expect(await service.approve(request(api),'synthetic-password'),true);
  api.reply={'status':'approved','requestId':uid(99),'expiresAt':api.deadline.toIso8601String()};expect(await service.approve(request(api),'synthetic-password'),false);
  api.reply={'status':'approved','requestId':uid(22),'expiresAt':api.deadline.add(const Duration(seconds:1)).toIso8601String()};expect(await service.approve(request(api),'synthetic-password'),false);
  api.reply={'status':'revoked'};expect(await service.revokeSupport(request(api),'synthetic-password'),true);
  api.reply={'status':'success'};expect(await service.revokeSupport(request(api),'synthetic-password'),false);
 });
 test('late receipt after actor replacement is discarded and cannot overwrite newer authority',()async{
  final actor=PrivilegedActor(),api=PrivilegedApi()..pending=Completer<ApiResponse>(),c=fixture(api,actor:actor);addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  final pending=service.elevate('synthetic-password','123456','Investigate tenant sign-in counts');actor.replace();
  api.pending!.complete(ApiResponse(statusCode:200,data:{'status':'elevated','elevationId':uid(21),'expiresAt':api.deadline.toIso8601String(),'scope':['tenant_security_summary']}));
  expect(await pending,isNull);expect(c.read(authProvider).token,newToken);expect(c.read(authProvider).userId,uid(3));expect((await SharedPreferences.getInstance()).getKeys(),isEmpty);
 });
 test('ordinary actors malformed proof and offline responses cannot create capabilities',()async{
  final api=PrivilegedApi(),c=fixture(api,actor:PrivilegedActor('rmt'));addTearDown(c.dispose);final service=c.read(privilegedAccessServiceProvider);
  expect(await service.elevate('synthetic-password','123456','Investigate tenant sign-in counts'),isNull);expect(await service.listRequests(),isNull);expect(api.calls,isEmpty);
  final allowed=fixture(api);addTearDown(allowed.dispose);final own=allowed.read(privilegedAccessServiceProvider);api.offline=true;
  expect(await own.elevate('synthetic-password','123456','Investigate tenant sign-in counts'),isNull);
  api.offline=false;api.reply={'status':'offline_fallback'};expect(await own.elevate('synthetic-password','123456','Investigate tenant sign-in counts'),isNull);
  expect(allowed.read(authProvider).token,oldToken);
 });
}
