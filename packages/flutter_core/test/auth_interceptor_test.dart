import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/src/security/security_interceptor.dart';

class InterceptorActor extends AuthNotifier {
  int signouts=0;
  String token=List.filled(43,'a').join();
  @override
  AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userId:'synthetic-owner',role:'code_admin',token:token);
  @override
  Future<void> logout()async{signouts++;state=AuthState(isInitialized:true);}
  void replace(){token=List.filled(43,'b').join();state=AuthState(isInitialized:true,isAuthenticated:true,userId:'new-owner',role:'code_admin',token:token);}
}
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 Future<int> rejected(String path,{int status=401,bool newerActor=false})async{
  final actor=InterceptorActor(),c=ProviderContainer(overrides:[authProvider.overrideWith(()=>actor)]);
  final transport=Dio(BaseOptions(baseUrl:'https://api.example.test'));
  try{
   c.read(authProvider);final interceptor=c.read(Provider((ref)=>SecurityInterceptor(ref)));
   final sentToken=actor.token;if(newerActor)actor.replace();
   transport.interceptors.add(InterceptorsWrapper(onRequest:(options,handler)=>handler.reject(DioException(requestOptions:options,type:DioExceptionType.badResponse,response:Response(requestOptions:options,statusCode:status,data:{'error':'Synthetic denial'})),true)));
   transport.interceptors.add(InterceptorsWrapper(onError:interceptor.onError));
   await expectLater(transport.post<dynamic>(path,options:Options(headers:{'Authorization':'Bearer $sentToken'})),throwsA(isA<DioException>()));
   if(actor.signouts==0)expect(c.read(authProvider).token,actor.token);
   return actor.signouts;
  }finally{transport.close(force:true);c.dispose();}
 }
 for(final path in ['/v1/auth/login','/v1/auth/mfa','/v1/auth/mfa/recovery-codes','/v1/auth/mfa/replacement','/v1/auth/mfa/recovery','/v1/auth/mfa/replacement/confirm','/v1/auth/mfa/elevation','/v1/auth/mfa/support/approve','/v1/auth/mfa/support/revoke','/api/auth/mfa/replacement/confirm?probe=1']){
  test('$path rejects proof without revoking existing owned session',()async{expect(await rejected(path),0);});
 }
 test('current-session identity denial still clears invalid authority',()async{expect(await rejected('/v1/auth/me'),1);});
 test('late identity denial cannot sign out a newer actor',()async{expect(await rejected('/v1/auth/me',newerActor:true),0);});
 test('logout denial does not recursively sign out again',()async{expect(await rejected('/v1/auth/logout'),0);});
 test('tenant support permission denial cannot revoke valid session',()async{expect(await rejected('/v1/auth/mfa/support/summary',status:403),0);});
}
