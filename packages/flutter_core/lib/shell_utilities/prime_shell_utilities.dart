import 'package:flutter/material.dart';import 'package:flutter/services.dart';
import 'shell_utilities_controller.dart';
/// Registered labels/identifiers are supplied by the host's verified metadata export.
class ShellUtilityLabels {
 final Map<String,String> text,ids;
 ShellUtilityLabels(Map<String,String> text,Map<String,String> ids):text=Map.unmodifiable(text),ids=Map.unmodifiable(ids){for(final k in ['open','close','events','notes','settings','notifications','favourites','search','refresh','markRead','markUnread','save','retry','acceptRemote','keepLocal','fullscreen','area','items','favouriteToggle','status']){if(text[k]?.trim().isNotEmpty!=true||ids[k]?.trim().isNotEmpty!=true)throw ArgumentError('Registered utility labels required');}for(final k in ['exitFullscreen','loading','empty','unavailable','error','offline','conflict','saved','dirty']){if(text[k]?.trim().isNotEmpty!=true)throw ArgumentError('Registered utility state labels required');}}
 String call(String key)=>text[key]??text['error']!;
}
class PrimeShellUtilities extends StatefulWidget {
 final ShellUtilitiesController controller;final ShellUtilityLabels labels;final double maxWidth;final TextDirection direction;final Future<bool> Function(bool)? setFullscreen;
 const PrimeShellUtilities({super.key,required this.controller,required this.labels,required this.maxWidth,this.direction=TextDirection.ltr,this.setFullscreen});
 @override State<PrimeShellUtilities> createState()=>_PrimeShellUtilitiesState();
}
class _PrimeShellUtilitiesState extends State<PrimeShellUtilities> {
 DialogRoute<void>? _route;NavigatorState? _navigator;final _openerFocus=FocusNode();
 void _retire(){final route=_route,nav=_navigator;_route=null;_navigator=null;if(route!=null&&nav!=null)WidgetsBinding.instance.addPostFrameCallback((_){if(nav.mounted&&route.isActive)nav.removeRoute(route);});}
 @override void didUpdateWidget(covariant PrimeShellUtilities old){super.didUpdateWidget(old);if(old.controller!=widget.controller)_retire();}
 @override void dispose(){_retire();_openerFocus.dispose();super.dispose();}
 Future<void> _open()async{if(_route!=null)return;final controller=widget.controller,labels=widget.labels,fullscreen=widget.setFullscreen,direction=widget.direction,width=widget.maxWidth,nav=Navigator.of(context);if(!width.isFinite||width<=0)throw ArgumentError('Registered utility width required');_navigator=nav;
 final route=DialogRoute<void>(context:context,barrierLabel:labels('close'),builder:(context)=>Directionality(textDirection:direction,child:Dialog(alignment:AlignmentDirectional.centerEnd,insetPadding:EdgeInsets.zero,constraints:BoxConstraints(maxWidth:width),child:SafeArea(child:_UtilityPanel(controller:controller,labels:labels,setFullscreen:fullscreen)))));_route=route;await nav.push(route);if(_route==route){_route=null;_navigator=null;if(mounted&&widget.controller==controller)_openerFocus.requestFocus();}}
 @override Widget build(BuildContext context)=>Directionality(textDirection:widget.direction,child:Semantics(identifier:widget.labels.ids['open'],label:widget.labels('open'),child:TextButton(focusNode:_openerFocus,onPressed:_open,child:Text(widget.labels('open')))));
}
class _UtilityPanel extends StatefulWidget {
 final ShellUtilitiesController controller;final ShellUtilityLabels labels;final Future<bool> Function(bool)? setFullscreen;
 const _UtilityPanel({required this.controller,required this.labels,this.setFullscreen});
 @override State<_UtilityPanel> createState()=>_UtilityPanelState();
}
class _UtilityPanelState extends State<_UtilityPanel> {
 String selected='notifications',query='';bool error=false,fullscreen=false,fullscreenBusy=false;final scroll=ScrollController();
 @override void initState(){super.initState();widget.controller.addListener(_changed);Future<void>.microtask(()async{await widget.controller.favourites.load();if(mounted)await _select(selected);});}
 void _changed(){if(mounted)setState((){});}
 @override void dispose(){widget.controller.removeListener(_changed);scroll.dispose();super.dispose();}
 Future<void> _run(Future<void> Function() action)async{try{if(mounted)setState(()=>error=false);await action();}catch(_){if(mounted)setState(()=>error=true);}}
 Future<void> _select(String key)async{if(!mounted)return;setState(()=>selected=key);if(key!='favourites')await _run(()=>widget.controller.load(key));}
 Widget button(String key,VoidCallback? action,{String? label,String suffix='',bool? pressed})=>Semantics(identifier:widget.labels.ids[key]!+suffix,label:label??widget.labels(key),toggled:pressed,child:TextButton(onPressed:action,child:Text(label??widget.labels(key))));
 String _preferenceStatus(Map<String,dynamic> f){final status=f['status'];return status=='clean'?'saved':['loading','saving'].contains(status)?'loading':['dirty','offline','conflict','error'].contains(status)?status as String:'empty';}
 @override Widget build(BuildContext context){final c=widget.controller,l=widget.labels,f=c.favourites.current,busy=['loading','saving'].contains(f['status']);final content=<Widget>[];String status='empty';
 if(selected=='favourites'){content.add(Semantics(identifier:l.ids['search'],child:TextField(maxLength:100,decoration:InputDecoration(labelText:l('search')),onChanged:(s)=>setState(()=>query=s))));final draft=f['draft'] as Map?,ids=List<String>.from(draft?['screenIds'] as List? ?? const []);for(final n in c.search(query)){content.add(Row(key:ValueKey(n.id),children:[Expanded(child:button('items',n.disabled?null:()=>c.open(n.id),label:n.title,suffix:'-${n.id}')),button('favouriteToggle',n.disabled||f['loaded']!=true||busy?null:()=>_run(()=>c.toggle(n.id)),label:'${l('favouriteToggle')} ${n.title}',suffix:'-${n.id}',pressed:ids.contains(n.id))]));}final actions=<String,Future<void> Function()>{'save':c.favourites.save,'retry':c.favourites.retryPending,'acceptRemote':c.favourites.acceptRemote,'keepLocal':c.favourites.keepLocal};content.add(Wrap(children:[for(final e in actions.entries)button(e.key,busy||f['loaded']!=true||e.key=='save'&&(f['pending']!=null||f['status']=='conflict')||e.key=='retry'&&f['pending']==null||['acceptRemote','keepLocal'].contains(e.key)&&f['remote']==null?null:()=>_run(e.value))]));status=_preferenceStatus(f);
 }else{final s=c.current[selected];if(s!=null){status=s.status=='ready'?(s.items.isEmpty?'empty':''):s.status=='idle'?'empty':s.status;for(final item in s.items){content.add(Column(key:ValueKey(item.id),crossAxisAlignment:CrossAxisAlignment.start,children:[Text(item.title,style:Theme.of(context).textTheme.titleMedium),Text(item.detail),if(item.status!=null)Text(item.status!),if(c.canActivate(selected))button('items',()=>c.activate(selected,item.id),label:item.title,suffix:'-${item.id}'),if(item.read!=null)button('markRead',s.busy||!c.canMarkRead(selected)?null:()=>_run(()=>c.markRead(selected,item.id,!item.read!)),label:l(item.read!?'markUnread':'markRead'),suffix:'-${item.id}')]));}content.add(button('refresh',s.busy||s.status=='unavailable'?null:()=>_run(()=>c.load(selected))));}}
 return CallbackShortcuts(bindings:{const SingleActivator(LogicalKeyboardKey.escape):()=>Navigator.of(context).pop()},child:Column(children:[Align(alignment:AlignmentDirectional.centerEnd,child:button('close',()=>Navigator.of(context).pop())),Wrap(children:[for(final key in [...utilityKinds,'favourites'])Semantics(selected:selected==key,child:button(key,()=>_select(key)))]),Expanded(child:Scrollbar(controller:scroll,scrollbarOrientation:Directionality.of(context)==TextDirection.rtl?ScrollbarOrientation.left:ScrollbarOrientation.right,child:ListView(controller:scroll,children:content))),Semantics(identifier:l.ids['status'],liveRegion:true,child:Text(error?l('error'):status.isEmpty?'':l(status))),button('fullscreen',widget.setFullscreen==null||fullscreenBusy?null:()=>_run(()async{setState(()=>fullscreenBusy=true);try{final expected=!fullscreen,actual=await widget.setFullscreen!(expected);if(actual!=expected)throw StateError('fullscreen_rejected');if(mounted)setState(()=>fullscreen=actual);}finally{if(mounted)setState(()=>fullscreenBusy=false);}}),label:l(fullscreen?'exitFullscreen':'fullscreen'))]));
 }
}
/// Route-keyed scrolling is owned here; ordinary rebuilds preserve current scroll and child state.
class PrimeShellScrollRegion extends StatefulWidget {
 final String routeKey;final Widget child;const PrimeShellScrollRegion({super.key,required this.routeKey,required this.child});
 @override State<PrimeShellScrollRegion> createState()=>_PrimeShellScrollRegionState();
}
class _PrimeShellScrollRegionState extends State<PrimeShellScrollRegion>{final controller=ScrollController();@override void didUpdateWidget(covariant PrimeShellScrollRegion old){super.didUpdateWidget(old);if(old.routeKey!=widget.routeKey)WidgetsBinding.instance.addPostFrameCallback((_){if(mounted&&controller.hasClients)controller.jumpTo(0);});}@override void dispose(){controller.dispose();super.dispose();}@override Widget build(BuildContext context)=>Scrollbar(controller:controller,scrollbarOrientation:Directionality.of(context)==TextDirection.rtl?ScrollbarOrientation.left:ScrollbarOrientation.right,child:SingleChildScrollView(controller:controller,child:widget.child));}
