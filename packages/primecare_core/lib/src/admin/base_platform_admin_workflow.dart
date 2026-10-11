import 'base_admin_workflow.dart';
import '../auth/base_auth_workflow.dart';
import 'package:primecare_models/primecare_models.dart';

/// Platform commands inherit the same busy/error/completion lifecycle as Admin.
abstract class BasePlatformAdminWorkflow extends BaseAdminWorkflow {
 BasePlatformAdminWorkflow(super.request);
 @override
 Future<void> execute(Future<void> Function() operation)=>super.execute(() async {try{await operation();}on FormatException{throw const AuthFailure('Invalid response',code:'error.invalidResponse');}on TypeError{throw const AuthFailure('Invalid response',code:'error.invalidResponse');}});
 List<AdminTenant> tenants=const [];
 List<AdminMasterRecord> records=const [];
 List<AdminUser> accounts=const [];
 List<AdminControlEvent> controlEvents=const [];
 List<String> categories=const [];
 AdminTenant? selectedTenant;
 AdminPlatformSnapshot? snapshot;
 String category='services';
 int tenantTotal=0,tenantOffset=0,masterTotal=0,masterOffset=0,accountTotal=0,accountOffset=0,eventTotal=0,eventOffset=0;
 List<Map<String,dynamic>> page(Map<String,dynamic> data,int offset){final items=data['items'];if(items is! List||items.length>25||items.any((item)=>item is! Map)||data['total'] is! int||(data['total'] as int)<0||data['offset']!=offset||data['limit']!=25)throw const AuthFailure('Invalid page',code:'error.invalidResponse');return items.map((item)=>Map<String,dynamic>.from(item as Map)).toList();}
 Future<void> _monitor() async {final data=await request('GET','/admin/control/monitor');final next=AdminPlatformSnapshot.fromJson(data);final codes=data['categories'],roles=data['assignableRoles'];if(codes is! List||codes.isEmpty||codes.any((value)=>value is! String)||codes.toSet().length!=codes.length||!codes.contains(category)||roles is! List||roles.any((value)=>value is! String))throw const AuthFailure('Invalid catalog',code:'error.invalidResponse');categories=List<String>.from(codes);assignableRoles=List<String>.from(roles);snapshot=next;}
 Future<void> _tenants(int offset) async {final data=await request('GET','/admin/control/tenants?offset=$offset');final items=page(data,offset).map(AdminTenant.fromJson).toList();tenants=items;tenantTotal=data['total'] as int;tenantOffset=offset;}
 Future<void> _accounts(int offset) async {final tenant=selectedTenant;if(tenant==null){accounts=const [];accountTotal=0;accountOffset=0;return;}final data=await request('GET','/admin/control/accounts?tenantId=${Uri.encodeQueryComponent(tenant.id)}&offset=$offset');if(data['tenantId']!=tenant.id)throw const AuthFailure('Invalid tenant',code:'error.invalidResponse');final items=page(data,offset).map(AdminUser.fromJson).toList();accounts=items;accountTotal=data['total'] as int;accountOffset=offset;}
 Future<void> _masters(int offset) async {final id=selectedTenant?.id;final data=await request('GET','/admin/control/masters?category=${Uri.encodeQueryComponent(category)}&offset=$offset${id==null?'':'&tenantId=${Uri.encodeQueryComponent(id)}'}');if(data['category']!=category||data['tenantId']!=id)throw const AuthFailure('Invalid master scope',code:'error.invalidResponse');final items=page(data,offset).map(AdminMasterRecord.fromJson).toList();if(items.any((item)=>item.category!=category||item.tenantId!=id))throw const AuthFailure('Invalid master scope',code:'error.invalidResponse');records=items;masterTotal=data['total'] as int;masterOffset=offset;}
 Future<void> _events(int offset) async {final data=await request('GET','/admin/control/audit?offset=$offset');final items=page(data,offset).map(AdminControlEvent.fromJson).toList();controlEvents=items;eventTotal=data['total'] as int;eventOffset=offset;}
 Future<void> _refresh() async {await _monitor();await _tenants(tenantOffset);await _accounts(accountOffset);await _masters(masterOffset);await _events(eventOffset);}
 Future<void> refresh()=>execute(_refresh);
 Future<void> loadTenants(int offset)=>execute(()=>_tenants(offset));
 Future<void> loadAccounts(int offset)=>execute(()=>_accounts(offset));
 Future<void> loadMasters(int offset)=>execute(()=>_masters(offset));
 Future<void> loadEvents(int offset)=>execute(()=>_events(offset));
 Future<void> selectTenant(AdminTenant? tenant)=>execute(() async {final previous=selectedTenant;selectedTenant=tenant;accounts=const [];records=const [];accountTotal=0;masterTotal=0;accountOffset=0;masterOffset=0;try{await _accounts(0);await _masters(0);}catch(_){selectedTenant=previous;accounts=const [];records=const [];accountTotal=0;masterTotal=0;accountOffset=0;masterOffset=0;rethrow;}});
 Future<void> selectCategory(String value)=>execute(() async {if(!categories.contains(value))throw const AuthFailure('Unknown category',code:'error.invalidRequest');final previous=category;category=value;try{await _masters(0);}catch(_){category=previous;rethrow;}});
 Future<void> provisionTenant(String name,String slug)=>execute(() async {final data=await request('POST','/admin/control/tenants',body:{'name':name,'slug':slug});selectedTenant=AdminTenant.fromJson(Map<String,dynamic>.from(data['tenant'] as Map));accounts=const [];records=const [];accountTotal=0;masterTotal=0;tenantOffset=0;accountOffset=0;masterOffset=0;eventOffset=0;await _refresh();});
 Future<void> provisionAccount(String email,String role,String password)=>execute(() async {if(selectedTenant==null)throw const AuthFailure('Select tenant',code:'error.invalidRequest');await request('POST','/admin/control/accounts',body:{'tenantId':selectedTenant!.id,'email':email,'role':role,'password':password});accountOffset=0;eventOffset=0;await _refresh();});
 Future<void> saveMaster(String code,Map<String,String> labels,String status,{AdminMasterRecord? record})=>execute(() async {await request(record==null?'POST':'PUT',record==null?'/admin/control/masters':'/admin/control/masters/${Uri.encodeComponent(record.id)}',body:record==null?{'tenantId':selectedTenant?.id,'category':category,'code':code,'labels':labels,'status':status}:{'labels':labels,'status':status});masterOffset=0;eventOffset=0;await _refresh();});
}
