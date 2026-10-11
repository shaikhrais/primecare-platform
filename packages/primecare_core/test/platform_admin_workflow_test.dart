import 'package:test/test.dart';
import 'package:primecare_core/primecare_core.dart';
class Admin extends BasePlatformAdminWorkflow { Admin(super.request); }
Map<String,dynamic> snapshot()=>{'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'categories':['services'],'assignableRoles':['client']};
Map<String,dynamic> page(Uri uri)=>{'items':<Map<String,dynamic>>[],'total':0,'offset':int.parse(uri.queryParameters['offset']??'0'),'limit':25,if(uri.path.endsWith('accounts'))'tenantId':uri.queryParameters['tenantId'],if(uri.path.endsWith('masters'))...{'tenantId':uri.queryParameters['tenantId'],'category':uri.queryParameters['category']}};
void main(){
 test('Refresh inherits lifecycle and reads global masters',() async {
  final paths=<String>[];
  final admin=Admin((method,path,{body}) async {paths.add(path);return path.endsWith('monitor')?snapshot():page(Uri.parse(path));});
  await admin.refresh();expect(admin.error,isNull);expect(admin.busy,false);expect(admin.categories,['services']);expect(paths.any((path)=>path.contains('tenantId=')),false);expect(paths.length,4);
 });
 test('Tenant switch failure clears previous tenant data',() async {
  const tenant=AdminTenant(id:'tenant-a',name:'A',slug:'a',status:'active');
  final admin=Admin((method,path,{body}) async {if(path.contains('accounts'))throw const AuthFailure('Unavailable',status:503);return page(Uri.parse(path));});
  admin.selectedTenant=tenant;admin.accounts=[const AdminUser(id:'old',email:'old@example.invalid',role:'client',status:'active')];
  await admin.selectTenant(const AdminTenant(id:'tenant-b',name:'B',slug:'b',status:'active'));
  expect(admin.selectedTenant,tenant);expect(admin.accounts,isEmpty);expect(admin.records,isEmpty);expect(admin.busy,false);expect(admin.error,isNotNull);
 });
 test('Mismatched tenant echo is rejected',() async {
  final admin=Admin((method,path,{body}) async=>{...page(Uri.parse(path)),'tenantId':'wrong'});
  await admin.selectTenant(const AdminTenant(id:'tenant-a',name:'A',slug:'a',status:'active'));
  expect(admin.errorCode,'error.invalidResponse');expect(admin.accounts,isEmpty);
 });
 test('Invalid monitor catalog does not enable controls',() async {
  final admin=Admin((method,path,{body}) async=>{...snapshot(),'categories':['unknown']});await admin.refresh();expect(admin.snapshot,isNull);expect(admin.errorCode,'error.invalidResponse');
 });
 test('Master edits send labels and status without moving scope',() async {
  Map<String,dynamic>? sent;
  final admin=Admin((method,path,{body}) async {if(method=='PUT'){sent=body;return {}; }return path.endsWith('monitor')?snapshot():page(Uri.parse(path));});
  const record=AdminMasterRecord(id:'record',tenantId:null,category:'services',code:'care',status:'active',labels:{'en':'Care','es':'Cuidado','fr':'Soins'});
  await admin.saveMaster('ignored',record.labels,'inactive',record:record);expect(sent!.keys.toSet(),{'labels','status'});expect(admin.error,isNull);
 });
 test('Selected tenant updates use the shared lifecycle and immutable scope',() async {
  const user=AdminUser(id:'user',email:'old@example.invalid',role:'client',status:'active');Map<String,dynamic>? sent;
  final admin=Admin((method,path,{body}) async {if(method=='PUT'){sent=body;return {}; }return path.endsWith('monitor')?snapshot():page(Uri.parse(path));});
  admin.selectedTenant=const AdminTenant(id:'tenant',name:'Tenant',slug:'tenant',status:'active');admin.accounts=[user];admin.assignableRoles=['client','rn'];
  await admin.updateTenantAccount(user,'new@example.invalid','rn','inactive');expect(sent,{'tenantId':'tenant','email':'new@example.invalid','role':'rn','status':'inactive'});expect(admin.error,isNull);expect(admin.busy,false);
 });
 test('Protected accounts cannot open a client-side mutation',() async {
  var calls=0;final admin=Admin((method,path,{body}) async {calls++;return {};});
  admin.selectedTenant=const AdminTenant(id:'tenant',name:'Tenant',slug:'tenant',status:'active');const user=AdminUser(id:'admin',email:'admin@example.invalid',role:'admin',status:'active');admin.accounts=[user];
  await admin.updateTenantAccount(user,user.email,'client','active');expect(calls,0);expect(admin.errorCode,'error.protected');
 });

}
