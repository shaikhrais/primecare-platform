import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/auth_service.dart';
import '../../network/api_client.dart';
import '../privileged_access_contract.g.dart';

class TemporaryElevation {
  final String id;
  final DateTime expiresAt;
  const TemporaryElevation(this.id,this.expiresAt);
}
class TenantSupportRequest {
  final String id,requesterId,tenantId,ticket,reason,status;
  final DateTime expiresAt;
  const TenantSupportRequest({required this.id,required this.requesterId,required this.tenantId,
    required this.ticket,required this.reason,required this.status,required this.expiresAt});
}
class TenantSecuritySummary {
  final String tenantId;
  final int activeAccounts,activeSessions,enrolledAuthenticators;
  const TenantSecuritySummary(this.tenantId,this.activeAccounts,this.activeSessions,this.enrolledAuthenticators);
}

/// References never replace session authority. The server rechecks every use.
class PrivilegedAccessService {
  final Ref _ref;
  PrivilegedAccessService(this._ref);
  bool get canElevate=>_actor()?.role=='code_admin';
  bool get canApprove=>_actor()?.role=='tenant_admin';
  AuthState? _actor(){
    if(!_ref.mounted)return null;
    final actor=_ref.read(authProvider);
    return actor.isInitialized&&actor.isAuthenticated&&_id(actor.userId)&&_token(actor.token)?actor:null;
  }
  bool _current(AuthState actor){
    if(!_ref.mounted)return false;
    final current=_actor();
    return current!=null&&current.userId==actor.userId&&current.token==actor.token&&current.role==actor.role&&current.tenantId==actor.tenantId;
  }
  static bool _id(Object? value)=>value is String&&RegExp(r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[1-5][a-fA-F0-9]{3}-[89abAB][a-fA-F0-9]{3}-[a-fA-F0-9]{12}$').hasMatch(value);
  static bool _token(Object? value)=>value is String&&RegExp(r'^[A-Za-z0-9_-]{43}$').hasMatch(value);
  static bool _text(Object? value,int min,int max)=>value is String&&value==value.trim()&&value.runes.length>=min&&value.runes.length<=max&&!RegExp(r'[\x00-\x1f\x7f]').hasMatch(value);
  static bool _password(String value)=>value.isNotEmpty&&utf8.encode(value).length<=72;
  static bool _scope(Object? value)=>value is List&&value.length==1&&value[0]==temporaryAccessAction;
  static DateTime? _expiry(Object? value){
    if(value is! String)return null;
    final date=DateTime.tryParse(value),now=DateTime.now().toUtc();
    if(date==null||!date.isUtc||date.toIso8601String()!=value||!date.isAfter(now)||date.isAfter(now.add(const Duration(seconds:temporaryAccessMaximumSeconds+30))))return null;
    return date;
  }
  Future<Map<String,dynamic>?> _call(AuthState actor,String operation,Map<String,dynamic> body)async{
    final api=_ref.read(apiClientProvider);String? unexpected;
    try{
      final response=operation=='listSupport'?await api.get(privilegedAccessEndpoints[operation]!)
        :await api.post(privilegedAccessEndpoints[operation]!,body:body,headers:{'Authorization':'Bearer ${actor.token}'});
      final data=response.data;
      if(data is Map<String,dynamic>&&data['token'] is String&&(data['token'] as String).trim().isNotEmpty)unexpected=data['token'] as String;
      if(!_current(actor)||response.statusCode!=200||unexpected!=null||data is! Map<String,dynamic>)return null;
      return Map<String,dynamic>.unmodifiable(data);
    }catch(_){return null;}
    finally{if(unexpected!=null){try{await api.revokeSession(unexpected);}catch(_){}}}
  }
  Future<TemporaryElevation?> elevate(String password,String code,String reason)async{
    final actor=_actor();reason=reason.trim();
    if(actor==null||actor.role!='code_admin'||!_password(password)||!RegExp(r'^[0-9]{6}$').hasMatch(code)||!_text(reason,10,500))return null;
    final data=await _call(actor,'elevate',{'password':password,'code':code,'reason':reason,'scope':[temporaryAccessAction],'seconds':temporaryAccessMaximumSeconds});
    if(data==null||data.length!=4||data['status']!='elevated'||!_id(data['elevationId'])||!_scope(data['scope']))return null;
    final expiry=_expiry(data['expiresAt']);return expiry==null?null:TemporaryElevation(data['elevationId'] as String,expiry);
  }
  Future<bool> revokeElevation(TemporaryElevation elevation)async{
    final actor=_actor();if(actor==null||actor.role!='code_admin'||!_id(elevation.id))return false;
    final data=await _call(actor,'revokeElevation',{'elevationId':elevation.id});return data?.length==1&&data?['status']=='revoked';
  }
  TenantSupportRequest? _request(Object? value,{String? tenantId,String? requesterId}){
    if(value is! Map<String,dynamic>||value.length!=8||!_id(value['requestId'])||!_id(value['requesterId'])||!_id(value['tenantId'])||!_text(value['ticket'],1,100)||!_text(value['reason'],10,500)||!_scope(value['scope'])||!['pending','approved','revoked'].contains(value['state'])||tenantId!=null&&value['tenantId']!=tenantId||requesterId!=null&&value['requesterId']!=requesterId)return null;
    final expiry=_expiry(value['expiresAt']);if(expiry==null)return null;
    return TenantSupportRequest(id:value['requestId'] as String,requesterId:value['requesterId'] as String,tenantId:value['tenantId'] as String,ticket:value['ticket'] as String,reason:value['reason'] as String,status:value['state'] as String,expiresAt:expiry);
  }
  Future<TenantSupportRequest?> requestSupport(TemporaryElevation elevation,String tenantId,String ticket,String reason)async{
    final actor=_actor();tenantId=tenantId.trim().toLowerCase();ticket=ticket.trim();reason=reason.trim();
    if(actor==null||actor.role!='code_admin'||!_id(elevation.id)||!_id(tenantId)||!_text(ticket,1,100)||!_text(reason,10,500))return null;
    final data=await _call(actor,'requestSupport',{'elevationId':elevation.id,'tenantId':tenantId,'ticket':ticket,'reason':reason,'scope':[temporaryAccessAction],'seconds':temporaryAccessMaximumSeconds});
    final request=_request(data,tenantId:tenantId,requesterId:actor.userId);
    if(request==null||request.status!='pending'||request.expiresAt.isAfter(elevation.expiresAt))return null;
    return request;
  }
  Future<List<TenantSupportRequest>?> listRequests()async{
    final actor=_actor();if(actor==null||actor.role!='tenant_admin')return null;
    final data=await _call(actor,'listSupport',{}),knownTenant=actor.tenantId;
    if(data==null||data.length!=1||data['requests'] is! List)return null;
    final rows=data['requests'] as List;if(rows.length>50)return null;
    final result=<TenantSupportRequest>[];
    for(final row in rows){final request=_request(row,tenantId:knownTenant==null||knownTenant.isEmpty?null:knownTenant);if(request==null||request.requesterId==actor.userId||result.any((item)=>item.id==request.id))return null;result.add(request);}
    return List<TenantSupportRequest>.unmodifiable(result);
  }
  Future<bool> approve(TenantSupportRequest request,String password)async{
    final actor=_actor();if(actor==null||actor.role!='tenant_admin'||!_password(password)||!_id(request.id))return false;
    final data=await _call(actor,'approveSupport',{'requestId':request.id,'password':password});
    return data?.length==3&&data?['status']=='approved'&&data?['requestId']==request.id&&_expiry(data?['expiresAt'])?.isAtSameMomentAs(request.expiresAt)==true;
  }
  Future<bool> revokeSupport(TenantSupportRequest request,String password)async{
    final actor=_actor();if(actor==null||!['code_admin','tenant_admin'].contains(actor.role)||!_password(password)||!_id(request.id))return false;
    final data=await _call(actor,'revokeSupport',{'requestId':request.id,'password':password});return data?.length==1&&data?['status']=='revoked';
  }
  Future<TenantSecuritySummary?> summary(TenantSupportRequest request)async{
    final actor=_actor();if(actor==null||actor.role!='code_admin'||!_id(request.id)||request.requesterId!=actor.userId)return null;
    final data=await _call(actor,'summary',{'requestId':request.id});
    if(data==null||data.length!=4||data['tenantId']!=request.tenantId)return null;
    final values=[data['activeAccounts'],data['activeSessions'],data['enrolledAuthenticators']];
    if(!values.every((value)=>value is int&&value>=0))return null;
    return TenantSecuritySummary(request.tenantId,values[0] as int,values[1] as int,values[2] as int);
  }
}
final privilegedAccessServiceProvider=Provider<PrivilegedAccessService>(PrivilegedAccessService.new);
