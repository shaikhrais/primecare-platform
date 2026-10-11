import 'package:test/test.dart';
import 'package:primecare_core/primecare_core.dart';

class _Admin extends BaseAdminWorkflow {
  _Admin(super.request);
}
Map<String,dynamic> _workspace(String path) {
  final uri=Uri.parse(path),status=Uri.parse(path).queryParameters['status']??'';
  return {'organization':{'name':'Organization'},'users':<Map<String,dynamic>>[],'assignableRoles':['client'],'total':0,'active':0,'offset':int.parse(uri.queryParameters['offset']!),'limit':25,'search':uri.queryParameters['search']??'','status':status};
}
void main() {
  test('Status and email filters survive refresh, pagination and mutations', () async {
    final paths=<String>[];
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {paths.add(path);return method=='GET'?_workspace(path):<String,dynamic>{};}
    final admin=_Admin(request);await admin.load(query:'  USER@EXAMPLE.COM ',statusFilter:'inactive');expect(admin.error,isNull);
    await admin.load(pageOffset:25);expect(Uri.parse(paths.last).queryParameters,{'offset':'25','search':'user@example.com','status':'inactive'});
    await admin.create('new@example.com','client','initial-password-123');expect(admin.accountStatus,'inactive');expect(admin.offset,0);
    await admin.update(const AdminUser(id:'user',email:'user@example.com',role:'client',status:'inactive'),'user@example.com','client','active');expect(Uri.parse(paths.last).queryParameters['status'],'inactive');
    await admin.load(query:'');expect(admin.search,'');expect(admin.accountStatus,'inactive');
    await admin.load(statusFilter:'');expect(admin.accountStatus,'');expect(paths.last,'/admin/workspace?offset=0');
  });
  test('Unsupported status is rejected before transport without losing state', () async {
    var calls=0;
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {calls++;return _workspace(path);}
    final admin=_Admin(request);await admin.load(statusFilter:'active');await admin.load(statusFilter:'paused');expect(calls,1);expect(admin.stateRevision,2);expect(admin.accountStatus,'active');expect(admin.errorCode,'error.invalidRequest');
  });
  test('Mismatched status echo preserves the previous valid workspace', () async {
    var mismatch=false;
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => {..._workspace(path),if(mismatch)'status':'inactive'};
    final admin=_Admin(request);await admin.load(statusFilter:'active');mismatch=true;await admin.load();expect(admin.accountStatus,'active');expect(admin.errorCode,'error.invalidResponse');
  });
  test('Rows outside the selected status are rejected', () async {
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => {..._workspace(path),'users':<Map<String,dynamic>>[{'id':'user','email':'user@example.com','role':'client','status':'active'}],'total':1,'active':0};
    final admin=_Admin(request);await admin.load(statusFilter:'inactive');expect(admin.errorCode,'error.invalidResponse');expect(admin.users,isEmpty);
  });
  test('Status-filter counts must match canonical active/inactive semantics', () async {
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => {..._workspace(path),'total':1,'active':Uri.parse(path).queryParameters['status']=='active'?0:1};
    final admin=_Admin(request);
    for(final status in ['active','inactive']) {await admin.load(statusFilter:status);expect(admin.errorCode,'error.invalidResponse');expect(admin.accountStatus,'');}
  });
}
