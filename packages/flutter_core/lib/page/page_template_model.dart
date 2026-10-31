import '../navigation/workspace_navigation_model.dart' show navigationUri;

class PageSidebar {
  final String mode;
  final int width;
  final bool open;
  const PageSidebar._(this.mode,this.width,this.open);
  Map<String,Object> toJson()=>{'mode':mode,'width':width,'open':open};
}
class PageChrome {
  final bool navigation,toolbar,footer;
  const PageChrome({this.navigation=true,this.toolbar=true,this.footer=true});
  Map<String,Object> toJson()=>{'navigation':navigation,'toolbar':toolbar,'footer':footer};
}
class PageLayout {
  final String template,scroll;
  final PageSidebar left,right;
  final PageChrome chrome;
  const PageLayout._(this.template,this.scroll,this.left,this.right,this.chrome);
  factory PageLayout.defaults()=>PageLayout.fromJson({'version':1,'template':'simple','scroll':'normal','left':{'mode':'none','width':280,'open':false},'right':{'mode':'none','width':280,'open':false},'chrome':{'navigation':true,'toolbar':true,'footer':true}});
  factory PageLayout.fromJson(Object? raw){
    final v=_object(raw,['version','template','scroll','left','right','chrome']);if(v['version']!=1)throw const FormatException('Unknown page version');
    PageSidebar side(Object? raw){final s=_object(raw,['mode','width','open']),width=s['width'];if(width is! num||!width.isFinite||width%1!=0||width<180||width>400)throw const FormatException('Invalid sidebar width');return PageSidebar._(_choice(s['mode'],['none','permanent','temporary','responsive']),width.toInt(),_bool(s['open']));}
    final c=_object(v['chrome'],['navigation','toolbar','footer']);return PageLayout._(_choice(v['template'],['simple','carded']),_choice(v['scroll'],['normal','page','content']),side(v['left']),side(v['right']),PageChrome(navigation:_bool(c['navigation']),toolbar:_bool(c['toolbar']),footer:_bool(c['footer'])));
  }
  Map<String,Object> toJson()=>{'version':1,'template':template,'scroll':scroll,'left':left.toJson(),'right':right.toJson(),'chrome':chrome.toJson()};
}
class PageBreadcrumb {
  final String id,label;
  final String? route;
  const PageBreadcrumb._(this.id,this.label,this.route);
  Map<String,Object> toJson()=>{'id':id,'label':label,if(route!=null)'route':route!};
}
class RegisteredPageRoute {
  final String id,route,title;
  final List<PageBreadcrumb> breadcrumbs;
  final PageLayout layout;
  RegisteredPageRoute._(this.id,this.route,this.title,List<PageBreadcrumb> breadcrumbs,this.layout):breadcrumbs=List.unmodifiable(breadcrumbs);
  Map<String,Object> toJson()=>{'id':id,'route':route,'title':title,'breadcrumbs':breadcrumbs.map((c)=>c.toJson()).toList(),'layout':layout.toJson()};
}
String pageRouteKey(String route){navigationUri(route);return route.split('#').first;}
class PageRouteRegistry {
  final List<RegisteredPageRoute> routes;
  PageRouteRegistry._(List<RegisteredPageRoute> routes):routes=List.unmodifiable(routes);
  factory PageRouteRegistry.fromJson(Object? raw,{required Iterable<String> allowedIds,required Iterable<String> allowedRoutes}){
    if(raw is! List<Object?>||raw.length>1000)throw const FormatException('Invalid page list');
    final ids=allowedIds.toSet(),routes=allowedRoutes.toSet(),seen=<String>{},destinations=<String>{},out=<RegisteredPageRoute>[];
    for(final input in raw){
      final v=_object(input,['id','route','title','breadcrumbs','layout']),id=_id(v['id']),route=_text(v['route'],512),binding=pageRouteKey(route);
      if(!seen.add(id)||!destinations.add(binding))throw const FormatException('Duplicate page binding');
      final title=_text(v['title'],200),layout=PageLayout.fromJson(v['layout']),rawCrumbs=v['breadcrumbs'];if(rawCrumbs is! List<Object?>||rawCrumbs.length>12)throw const FormatException('Invalid breadcrumbs');
      final breadcrumbs=<PageBreadcrumb>[],crumbIds=<String>{};
      for(final raw in rawCrumbs){
        if(raw is! Map<String,Object?>)throw const FormatException('Invalid breadcrumb');final c=_object(raw,raw.containsKey('route')?['id','label','route']:['id','label']),key=_id(c['id']),label=_text(c['label'],200);
        if(!crumbIds.add(key))throw const FormatException('Duplicate breadcrumb');String? route;if(c.containsKey('route')){route=_text(c['route'],512);navigationUri(route);}
        if(ids.contains(key)&&(route==null||routes.contains(route)))breadcrumbs.add(PageBreadcrumb._(key,label,route));
      }
      if(ids.contains(id)&&routes.contains(route))out.add(RegisteredPageRoute._(id,route,title,breadcrumbs,layout));
    }return PageRouteRegistry._(out);
  }
  RegisteredPageRoute? resolve(String current){final key=pageRouteKey(current);for(final p in routes){if(pageRouteKey(p.route)==key)return p;}return null;}
  List<Map<String,Object>> toJson()=>routes.map((p)=>p.toJson()).toList();
}
Map<String,Object?> _object(Object? raw,List<String> keys){if(raw is! Map<String,Object?>||raw.length!=keys.length||!raw.keys.every(keys.contains))throw const FormatException('Unknown or missing page field');return raw;}
String _text(Object? raw,int max){if(raw is! String||raw.trim().isEmpty||raw.length>max||RegExp(r'[\x00-\x1f\x7f]').hasMatch(raw))throw const FormatException('Invalid page text');return raw;}
String _id(Object? raw){final id=_text(raw,64);if(!RegExp(r'^[A-Za-z0-9][A-Za-z0-9_.:-]*$').hasMatch(id))throw const FormatException('Invalid page identity');return id;}
bool _bool(Object? raw){if(raw is! bool)throw const FormatException('Invalid page flag');return raw;}
String _choice(Object? raw,List<String> values){if(raw is! String||!values.contains(raw))throw const FormatException('Invalid page choice');return raw;}
