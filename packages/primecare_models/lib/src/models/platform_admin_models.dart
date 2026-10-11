import 'base_entity.dart';

Map<String,dynamic> _map(dynamic value) { if(value is! Map)throw const FormatException('Invalid platform response');return Map<String,dynamic>.from(value); }
String _text(dynamic value){if(value is! String||value.isEmpty)throw const FormatException('Invalid platform field');return value;}
String _status(dynamic value){if(value!='active'&&value!='inactive')throw const FormatException('Invalid status');return value as String;}
class AdminTenant extends BaseEntity<String> {
 final String name,slug,status;
 const AdminTenant({required super.id,required this.name,required this.slug,required this.status});
 factory AdminTenant.fromJson(Map<String,dynamic> data)=>AdminTenant(id:_text(data['id']),name:_text(data['name']),slug:_text(data['slug']),status:_text(data['status']));
}
class AdminMasterRecord extends BaseEntity<String> {
 final String? tenantId;
 final String category,code,status;
 final Map<String,String> labels;
 const AdminMasterRecord({required super.id,required this.tenantId,required this.category,required this.code,required this.status,required this.labels});
 String label(String language)=>labels[language]??labels['en']!;
 factory AdminMasterRecord.fromJson(Map<String,dynamic> data){final values=_map(data['labels']);if(values.length!=3||!['en','es','fr'].every(values.containsKey))throw const FormatException('Invalid labels');return AdminMasterRecord(id:_text(data['id']),tenantId:data['tenantId']==null?null:_text(data['tenantId']),category:_text(data['category']),code:_text(data['code']),status:_status(data['status']),labels:Map<String,String>.unmodifiable(values.map((key,value)=>MapEntry(key,_text(value)))));}
}
class AdminControlEvent extends BaseEntity<String> {
 final String actor,target,action;
 final DateTime createdAt;
 const AdminControlEvent({required super.id,required this.actor,required this.target,required this.action,required this.createdAt});
 factory AdminControlEvent.fromJson(Map<String,dynamic> data){if(!['tenant_created','account_created','master_created','master_updated'].contains(data['action']))throw const FormatException('Invalid event');return AdminControlEvent(id:_text(data['id']),actor:_text(data['actor']),target:_text(data['target']),action:_text(data['action']),createdAt:DateTime.parse(_text(data['createdAt'])));}
}
class AdminPlatformSnapshot extends BaseEntity<String> {
 static const metrics=['tenantsTotal','tenantsActive','usersTotal','usersActive','sessionsActive','mastersTotal','mastersActive'];
 final Map<String,int> counts;
 final DateTime sampledAt;
 const AdminPlatformSnapshot({required this.counts,required this.sampledAt}):super(id:'platform');
 factory AdminPlatformSnapshot.fromJson(Map<String,dynamic> data){final values=<String,int>{};for(final key in metrics){final value=data[key];if(value is! int||value<0)throw const FormatException('Invalid metric');values[key]=value;}for(final entity in ['tenants','users','masters']){if(values['${entity}Active']!>values['${entity}Total']!)throw const FormatException('Invalid count');}return AdminPlatformSnapshot(counts:Map.unmodifiable(values),sampledAt:DateTime.parse(_text(data['sampledAt'])));}
}
