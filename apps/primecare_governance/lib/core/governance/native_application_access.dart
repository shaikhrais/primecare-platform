import 'package:flutter_core/dashboard_pages.dart' show validateDashboardResponseScope;
import 'package:flutter_core/preference_sync.dart' show PreferenceScope;

/// Existing screen2534/API16578 capability, never a grant inferred from a route.
Future<bool> authorizeNativeApplicationRoute({required String? userId,
  required String? tenantId,required String? role,required bool Function() isCurrent,
  required Future<Object?> Function() loadDashboard})async{
  if(role!='tenant_admin'||userId==null||userId.isEmpty||tenantId==null||tenantId.isEmpty)return false;
  try{
    if(!isCurrent())return false;
    final raw=await loadDashboard();
    if(!isCurrent())return false;
    validateDashboardResponseScope(raw,PreferenceScope(tenantId,userId,role,'live'));
    return isCurrent();
  }catch(_){return false;}
}
