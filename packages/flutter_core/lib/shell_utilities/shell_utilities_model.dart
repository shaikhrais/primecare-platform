class UtilityItem {
 final String id,title,detail;final bool? read;final String? status;
 const UtilityItem(this.id,this.title,this.detail,this.read,this.status);
 factory UtilityItem.fromJson(Object? raw){if(raw is! Map||raw.keys.toSet().difference({'id','title','detail','read','status'}).isNotEmpty||raw.length!=5)throw const FormatException('invalid_utility_response');final id=raw['id'],title=raw['title'],detail=raw['detail'],read=raw['read'],status=raw['status'];if(id is! String||!RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.:-]{0,199}$').hasMatch(id)||title is! String||title.trim().isEmpty||title.length>200||detail is! String||detail.length>4000||read!=null&&read is! bool||status!=null&&(status is! String||status.length>200))throw const FormatException('invalid_utility_response');return UtilityItem(id,title,detail,read as bool?,status as String?);}
 Map<String,Object?> toJson()=>{'id':id,'title':title,'detail':detail,'read':read,'status':status};
}
List<UtilityItem> utilityItems(Object? raw){if(raw is! List||raw.length>100)throw const FormatException('invalid_utility_response');final ids=<String>{},items=raw.map(UtilityItem.fromJson).toList();if(items.any((i)=>!ids.add(i.id)))throw const FormatException('invalid_utility_response');return List.unmodifiable(items);}
const utilityKinds=['events','notes','settings','notifications'];
class UtilityDestination {
 final String id,title,detail;final bool disabled;
 UtilityDestination(this.id,this.title,this.detail,{this.disabled=false}){if(!RegExp(r'^[1-9][0-9]{0,9}$').hasMatch(id)||title.trim().isEmpty||title.length>200||detail.length>400)throw const FormatException('invalid_utility_destination');}
}
class UtilityState {
 final String status;final List<UtilityItem> items;final bool busy;final String? error;
 const UtilityState(this.status,{this.items=const [],this.busy=false,this.error});
}
