import '../workspace/workspace_layout.dart';

class WorkspaceNavigationNode {
  final String id, label, kind, match;
  final String? route, icon, subtitle, badge;
  final bool disabled;
  final List<WorkspaceNavigationNode> children;
  WorkspaceNavigationNode._(this.id, this.label, this.kind, this.match, this.route,
    this.icon, this.subtitle, this.badge, this.disabled, List<WorkspaceNavigationNode> children)
    : children = List.unmodifiable(children);
  Map<String, Object> toJson() => {'id':id,'label':label,'kind':kind,
    if(route!=null)'route':route!,if(icon!=null)'icon':icon!,if(subtitle!=null)'subtitle':subtitle!,
    if(badge!=null)'badge':badge!,'disabled':disabled,'match':match,'children':children.map((n)=>n.toJson()).toList()};
}
class WorkspaceNavigationModel {
  final List<WorkspaceNavigationNode> nodes;
  WorkspaceNavigationModel._(List<WorkspaceNavigationNode> nodes):nodes=List.unmodifiable(nodes);
  factory WorkspaceNavigationModel.fromJson(Object? raw, {required Iterable<String> allowedIds,
      required Iterable<String> allowedRoutes, required Iterable<String> registeredIcons}) {
    if(raw is! List<Object?> || raw.length>1000) throw const FormatException('Invalid navigation list');
    final ids=allowedIds.toSet(), routes=allowedRoutes.toSet(), icons=registeredIcons.toSet(),seen=<String>{};var count=0;
    List<WorkspaceNavigationNode> parse(List<Object?> list,int depth,bool parentDisabled) {
      if(depth>8)throw const FormatException('Navigation is too deep');final out=<WorkspaceNavigationNode>[];
      for(final raw in list){
        if(raw is! Map<String,Object?> || ++count>1000 || raw.keys.any((k)=>!['id','label','kind','route','icon','subtitle','badge','disabled','match','children'].contains(k)))throw const FormatException('Invalid navigation node');
        final id=_text(raw['id'],64),label=_text(raw['label'],200),kind=raw['kind'];
        if(!RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.:-]*$').hasMatch(id)||!seen.add(id)||!['item','group'].contains(kind))throw const FormatException('Invalid navigation identity');
        if(raw.containsKey('disabled')&&raw['disabled'] is! bool)throw const FormatException('Invalid disabled state');
        final disabled=parentDisabled||raw['disabled']==true,match=raw['match']??'exact';
        if(!['exact','prefix'].contains(match))throw const FormatException('Invalid route matching');
        String? optional(String key,int max)=>raw.containsKey(key)?_text(raw[key],max):null;
        final icon=optional('icon',64),subtitle=optional('subtitle',400),badge=optional('badge',40);
        if(icon!=null&&!icons.contains(icon))throw const FormatException('Unregistered icon');
        String? route;var children=<WorkspaceNavigationNode>[];
        if(kind=='item'){
          route=_text(raw['route'],512);navigationUri(route);
          if(raw.containsKey('children'))throw const FormatException('Item cannot contain children');
        }else{
          if(raw.containsKey('route')||raw['children'] is! List<Object?>)throw const FormatException('Invalid group');
          children=parse(raw['children']! as List<Object?>,depth+1,disabled);
        }
        if(!ids.contains(id)||(route!=null&&!routes.contains(route))||(kind=='group'&&children.isEmpty))continue;
        out.add(WorkspaceNavigationNode._(id,label,kind! as String,match as String,route,icon,subtitle,badge,disabled,children));
      }return out;
    }
    return WorkspaceNavigationModel._(parse(raw,0,false));
  }
  List<WorkspaceNavigationNode> get flattened {
    List<WorkspaceNavigationNode> walk(List<WorkspaceNavigationNode> nodes)=>[for(final n in nodes)...[n,...walk(n.children)]];
    return walk(nodes);
  }
  WorkspaceNavigationNode? find(String id) {for(final n in flattened){if(n.id==id)return n;}return null;}
  List<Map<String,Object>> toJson()=>nodes.map((n)=>n.toJson()).toList();
  String? active(String current) {
    final here=navigationUri(current);String path(Uri uri){final raw=uri.toString().substring('https://primecare.invalid'.length).split(RegExp(r'[?#]')).first;return raw=='/'?raw:raw.replaceFirst(RegExp(r'/$'),'');}
    String? best;var score=-1;
    for(final node in flattened){if(node.route==null||node.disabled)continue;
      final target=navigationUri(node.route!),a=path(target),b=path(here);
      if((node.match=='exact'?a==b:(a=='/'||a==b||b.startsWith('$a/')))&&
        (target.query.isEmpty||target.query==here.query)&&(target.fragment.isEmpty||target.fragment==here.fragment)){
        final rank=a.length+target.query.length+target.fragment.length+(target.query.isEmpty?0:1)+(target.fragment.isEmpty?0:1);
        if(rank>score){best=node.id;score=rank;}
      }
    }return best;
  }
}
Uri navigationUri(String value) {
  if(value.length>512||!value.startsWith('/')||value.startsWith('//')||RegExp(r'[\\\x00-\x20\x7f]').hasMatch(value))throw const FormatException('Invalid registered route');
  final uri=Uri.parse('https://primecare.invalid').resolve(value);
  if(uri.origin!='https://primecare.invalid')throw const FormatException('External route');return uri;
}
String _text(Object? value,int max) {
  if(value is! String||value.trim().isEmpty||value.length>max||RegExp(r'[\x00-\x1f\x7f]').hasMatch(value))throw const FormatException('Invalid navigation text');return value;
}
WorkspaceLayout navigationPreset(WorkspaceLayout profile,String family) {
  if(!['vertical','horizontal-header','horizontal-footer'].contains(family))throw const FormatException('Unknown navigation family');
  return profile.patch({'navigation':family=='vertical'?'left':family=='horizontal-header'?'top':'bottom','toolbar':'top'});
}
