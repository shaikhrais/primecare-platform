import 'package:test/test.dart';
import 'package:primecare_core/primecare_core.dart';

class _Admin extends BaseAdminWorkflow {
  _Admin(super.request);
}
void main() {
  Map<String,dynamic> workspace(Uri uri) => {'organization':{'name':'Organization'},'users':[],'assignableRoles':['client'],'total':0,'active':0,'offset':int.parse(uri.queryParameters['offset']!),'limit':25,'search':uri.queryParameters['search']??''};
  test('Shared search normalizes, encodes and survives mutations and pagination', () async {
    final paths=<String>[];
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
      paths.add('$method $path');return method=='GET'?workspace(Uri.parse(path)):{'user':{}};
    }
    final admin=_Admin(request);
    await admin.load(query:'  CASE+TAG@EXAMPLE.COM  ');expect(admin.search,'case+tag@example.com');expect(admin.error,isNull);
    expect(Uri.parse(paths.last.substring(4)).queryParameters['search'],'case+tag@example.com');
    await admin.load(pageOffset:25);expect(admin.offset,25);expect(admin.search,'case+tag@example.com');
    await admin.create('new@example.com','client','initial-password-123');expect(admin.offset,0);expect(admin.search,'case+tag@example.com');
    await admin.load(query:'');expect(admin.search,'');expect(paths.last,'GET /admin/workspace?offset=0');
  });
  test('Mismatched search echo keeps the last valid view and localized error code', () async {
    var mismatch=false;
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => {...workspace(Uri.parse(path)),if(mismatch)'search':'wrong'};
    final admin=_Admin(request);await admin.load(query:'first');mismatch=true;await admin.load(query:'second');
    expect(admin.search,'first');expect(admin.errorCode,'error.invalidResponse');expect(admin.busy,false);
  });
  test('Shared audit filter persists on refresh/pagination and rejects wrong targets', () async {
    const id='aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';var wrongTarget=false;final paths=<String>[];
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
      paths.add(path);final uri=Uri.parse(path);final userId=uri.queryParameters['userId']??'';
      return {'events':[{'id':'event','actor':'actor','target':wrongTarget?'wrong':id,'action':'account_created','createdAt':'2026-10-10T12:00:00Z','before':null,'after':null}],'total':1,'offset':int.parse(uri.queryParameters['offset']!),'limit':25,'userId':userId};
    }
    final admin=_Admin(request);await admin.loadAudit(userId:id.toUpperCase());expect(admin.auditUserId,id);expect(admin.error,isNull);
    await admin.loadAudit(pageOffset:25);expect(Uri.parse(paths.last).queryParameters['userId'],id);
    wrongTarget=true;await admin.loadAudit();expect(admin.errorCode,'error.invalidResponse');expect(admin.events.single.target,id);
    wrongTarget=false;await admin.loadAudit(userId:'');expect(admin.auditUserId,'');expect(paths.last,'/admin/workspace/audit?offset=0');
  });
  test('Rate limits use a central localized error code', () async {
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => throw const AuthFailure('Too many requests',status:429);
    final admin=_Admin(request);await admin.load();expect(admin.errorCode,'error.rateLimit');expect(admin.busy,false);
  });
}
