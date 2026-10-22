import 'dart:async';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/src/application/controllers/privileged_access_service.dart';

class ElevationViewState {
  final bool canUse,working,failed,ended;
  final String password,factor,reason,tenant,ticket;
  final TemporaryElevation? elevation;
  final TenantSupportRequest? request;
  final TenantSecuritySummary? summary;
  const ElevationViewState({this.canUse=false,this.working=false,this.failed=false,this.ended=false,
    this.password='',this.factor='',this.reason='',this.tenant='',this.ticket='',this.elevation,this.request,this.summary});
  ElevationViewState copy({bool? working,bool? failed,String? password,String? factor,String? reason,String? tenant,String? ticket,
    TemporaryElevation? elevation,TenantSupportRequest? request,TenantSecuritySummary? summary,bool clearRequest=false,bool clearSummary=false})=>
    ElevationViewState(canUse:canUse,working:working??this.working,failed:failed??this.failed,password:password??this.password,factor:factor??this.factor,
      reason:reason??this.reason,tenant:tenant??this.tenant,ticket:ticket??this.ticket,elevation:elevation??this.elevation,
      request:clearRequest?null:request??this.request,summary:clearSummary?null:summary??this.summary);
}
class AuthElevationController extends Notifier<ElevationViewState> {
  int _revision=0;Timer? _expiry;
  @override
  ElevationViewState build(){
    final lifetime=ref;
    ref.onDispose((){_revision++;_expiry?.cancel();});
    ref.onCancel((){_revision++;_expiry?.cancel();scheduleMicrotask((){if(lifetime.mounted)lifetime.invalidateSelf();});});
    ref.listen(authProvider,(previous,next){if(previous?.token!=next.token||previous?.userId!=next.userId||previous?.role!=next.role||previous?.tenantId!=next.tenantId||!next.isAuthenticated)_clear();});
    return ElevationViewState(canUse:ref.read(privilegedAccessServiceProvider).canElevate);
  }
  bool _live(int revision)=>ref.mounted&&revision==_revision;
  void _clear({bool ended=false}){_revision++;_expiry?.cancel();if(ref.mounted)state=ElevationViewState(canUse:ref.read(privilegedAccessServiceProvider).canElevate,ended:ended);}
  void _watch(DateTime deadline){_expiry?.cancel();final revision=_revision;_expiry=Timer(deadline.difference(DateTime.now()),(){if(_live(revision))_clear(ended:true);});}
  void password(String value){if(!state.working)state=state.copy(password:value,failed:false);}
  void factor(String value){if(!state.working)state=state.copy(factor:value,failed:false);}
  void reason(String value){if(!state.working)state=state.copy(reason:value,failed:false);}
  void tenant(String value){if(!state.working)state=state.copy(tenant:value,failed:false);}
  void ticket(String value){if(!state.working)state=state.copy(ticket:value,failed:false);}
  Future<void> elevate()async{
    if(!state.canUse||state.working||state.elevation!=null)return;
    final password=state.password,code=state.factor,reason=state.reason,revision=++_revision;
    state=state.copy(working:true,failed:false,password:'',factor:'');TemporaryElevation? result;
    try{result=await ref.read(privilegedAccessServiceProvider).elevate(password,code,reason);}catch(_){}
    if(!_live(revision))return;
    state=state.copy(working:false,failed:result==null,elevation:result);if(result!=null)_watch(result.expiresAt);
  }
  Future<void> requestSupport()async{
    final elevation=state.elevation;if(!state.canUse||state.working||elevation==null||state.request!=null)return;
    final tenant=state.tenant,ticket=state.ticket,reason=state.reason,revision=++_revision;
    state=state.copy(working:true,failed:false,password:'',factor:'');TenantSupportRequest? result;
    try{result=await ref.read(privilegedAccessServiceProvider).requestSupport(elevation,tenant,ticket,reason);}catch(_){}
    if(!_live(revision))return;
    state=state.copy(working:false,failed:result==null,request:result);_watch(result?.expiresAt??elevation.expiresAt);
  }
  Future<void> readSummary()async{
    final request=state.request;if(!state.canUse||state.working||request==null)return;
    final revision=++_revision;state=state.copy(working:true,failed:false,clearSummary:true,password:'',factor:'');TenantSecuritySummary? result;
    try{result=await ref.read(privilegedAccessServiceProvider).summary(request);}catch(_){}
    if(!_live(revision))return;
    state=state.copy(working:false,failed:result==null,summary:result);_watch(request.expiresAt);
  }
  Future<void> revokeSupport()async{
    final request=state.request;if(!state.canUse||state.working||request==null)return;
    final password=state.password,revision=++_revision;state=state.copy(working:true,failed:false,password:'',factor:'',clearSummary:true);var accepted=false;
    try{accepted=await ref.read(privilegedAccessServiceProvider).revokeSupport(request,password);}catch(_){}
    if(!_live(revision))return;
    state=state.copy(working:false,failed:!accepted,clearRequest:accepted,clearSummary:true,tenant:accepted?'':state.tenant,ticket:accepted?'':state.ticket);
    final elevation=state.elevation;if(elevation!=null)_watch(elevation.expiresAt);
  }
  Future<void> end()async{
    final elevation=state.elevation;if(state.working||elevation==null)return;
    final revision=++_revision;state=state.copy(working:true,failed:false,password:'',factor:'',clearSummary:true);var accepted=false;
    try{accepted=await ref.read(privilegedAccessServiceProvider).revokeElevation(elevation);}catch(_){}
    if(!_live(revision))return;
    if(accepted){_clear(ended:true);}else{state=state.copy(working:false,failed:true);_watch(elevation.expiresAt);}
  }
}
final authElevationProvider=NotifierProvider.autoDispose<AuthElevationController,ElevationViewState>(AuthElevationController.new);

class TenantApprovalViewState {
  final bool canUse,working,failed;
  final String password;
  final List<TenantSupportRequest> requests;
  const TenantApprovalViewState({this.canUse=false,this.working=false,this.failed=false,this.password='',this.requests=const []});
}
class TenantSupportController extends Notifier<TenantApprovalViewState> {
  int _revision=0;
  @override
  TenantApprovalViewState build(){
    final lifetime=ref;
    ref.onDispose((){_revision++;});
    ref.onCancel((){_revision++;scheduleMicrotask((){if(lifetime.mounted)lifetime.invalidateSelf();});});
    ref.listen(authProvider,(previous,next){
      if(previous?.token!=next.token||previous?.userId!=next.userId||previous?.role!=next.role||previous?.tenantId!=next.tenantId||!next.isAuthenticated){
        final revision=++_revision,allowed=ref.read(privilegedAccessServiceProvider).canApprove;
        state=TenantApprovalViewState(canUse:allowed);
        if(allowed)scheduleMicrotask((){if(lifetime.mounted&&revision==_revision)refresh();});
      }
    });
    final allowed=ref.read(privilegedAccessServiceProvider).canApprove;
    final revision=_revision;
    if(allowed)scheduleMicrotask((){if(lifetime.mounted&&revision==_revision)refresh();});
    return TenantApprovalViewState(canUse:allowed);
  }
  bool _live(int revision)=>ref.mounted&&revision==_revision;
  void password(String value){if(!state.working)state=TenantApprovalViewState(canUse:state.canUse,password:value,requests:state.requests);}
  Future<void> refresh()async{
    if(!state.canUse||state.working)return;
    final revision=++_revision;state=TenantApprovalViewState(canUse:true,working:true,requests:state.requests);List<TenantSupportRequest>? result;
    try{result=await ref.read(privilegedAccessServiceProvider).listRequests();}catch(_){}
    if(_live(revision))state=TenantApprovalViewState(canUse:true,failed:result==null,requests:result??const []);
  }
  Future<void> decide(TenantSupportRequest request,{required bool approve})async{
    if(!state.canUse||state.working)return;
    final password=state.password,revision=++_revision;state=TenantApprovalViewState(canUse:true,working:true,requests:state.requests);var accepted=false;
    try{final service=ref.read(privilegedAccessServiceProvider);accepted=approve?await service.approve(request,password):await service.revokeSupport(request,password);}catch(_){}
    if(!_live(revision))return;
    state=TenantApprovalViewState(canUse:true,failed:!accepted,requests:accepted&&!approve?state.requests.where((item)=>item.id!=request.id).toList():state.requests);
    if(accepted)await refresh();
  }
}
final tenantSupportProvider=NotifierProvider.autoDispose<TenantSupportController,TenantApprovalViewState>(TenantSupportController.new);
