import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIconButton;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextButton;
import '../original_assets.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'workspace_navigation_model.dart';

class WorkspaceNavigationLabels {
  final String navigation,open,close,pin,unpin;
  const WorkspaceNavigationLabels({required this.navigation,required this.open,required this.close,required this.pin,required this.unpin});
}
/// Opt-in native navigation. The model intersects only the host's server authority.
class PrimeWorkspaceNavigation extends StatefulWidget {
  final WorkspaceNavigationModel model;
  final String scope,currentRoute,family,mode;
  final bool? pinned;
  final WorkspaceNavigationLabels labels;
  final ValueChanged<String> onNavigate;
  final ValueChanged<bool>? onExpandedChanged;
  final Widget Function(String)? iconBuilder;
  const PrimeWorkspaceNavigation({super.key,required this.model,required this.scope,required this.currentRoute,
    required this.labels,required this.onNavigate,this.family='vertical',this.mode='expanded',this.pinned,this.iconBuilder,this.onExpandedChanged});
  @override State<PrimeWorkspaceNavigation> createState()=>_PrimeWorkspaceNavigationState();
}
class _PrimeWorkspaceNavigationState extends State<PrimeWorkspaceNavigation> {
  final _expanded=<String>{};
  final _menuController=MenuController();
  final _submenus=<String,MenuController>{};
  final _menuEntryFocus=FocusNode(debugLabel:'workspace-navigation-menu-entry');
  final _focus=<(String,String),FocusNode>{};
  final _dialogUpdates=ValueNotifier<int>(0);
  bool _pinned=true,_hover=false,_focused=false;
  String? _selected,_activeId;
  DialogRoute<void>? _dialog;
  NavigatorState? _navigator;
  int _generation=0;
  bool? _reported;
  @override void initState(){super.initState();_pinned=widget.pinned??true;_select();}
  void _mutate(VoidCallback work){setState(work);_dialogUpdates.value++;}
  bool get _narrow=>MediaQuery.sizeOf(context).width<=1024;
  bool get _wide=>_pinned||_hover||_focused;
  FocusNode _node(String id,{String prefix=''})=>_focus.putIfAbsent((prefix,id),()=>FocusNode(debugLabel:'workspace-navigation-$prefix$id'));
  FocusNode _boundNode(String id,KeyEventResult Function(KeyEvent) handler,{String prefix=''}){final node=_node(id,prefix:prefix);node.onKeyEvent=(_,event)=>handler(event);return node;}
  void _select(){
    final groups=widget.model.nodes.where((n)=>n.kind=='group'&&!n.disabled).toList();
    if(groups.any((n)=>n.id==_selected))return;
    final active=widget.model.active(widget.currentRoute);
    bool contains(WorkspaceNavigationNode n)=>n.id==active||n.children.any(contains);
    _selected=null;for(final n in groups){if(contains(n)){_selected=n.id;break;}}_selected??=groups.firstOrNull?.id;
  }
  @override void didUpdateWidget(PrimeWorkspaceNavigation oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.scope!=widget.scope||jsonEncode(oldWidget.model.toJson())!=jsonEncode(widget.model.toJson())){
      _generation++;_closeDialogLater();_expanded.removeWhere((id)=>widget.model.find(id)?.kind!='group');
      if(oldWidget.scope!=widget.scope){_expanded.clear();_selected=null;_pinned=widget.pinned??true;_hover=false;_focused=false;}
    }
    if(oldWidget.currentRoute!=widget.currentRoute)_selected=null;
    if(widget.pinned!=null&&oldWidget.pinned!=widget.pinned)_pinned=widget.pinned!;_select();
  }
  void _closeDialogLater(){final route=_dialog,nav=_navigator;_dialog=null;_navigator=null;
    if(route!=null&&nav!=null)WidgetsBinding.instance.addPostFrameCallback((_){if(nav.mounted&&route.isActive)nav.removeRoute(route);});
  }
  @override void dispose(){_menuEntryFocus.dispose();_generation++;_closeDialogLater();for(final n in _focus.values)n.dispose();_dialogUpdates.dispose();super.dispose();}
  void _activate(String id,int generation){
    if(!mounted||generation!=_generation)return;final node=widget.model.find(id);
    if(node==null||node.disabled||node.route==null)return;
    final route=_dialog,nav=_navigator;_dialog=null;_navigator=null;if(route!=null&&nav!=null&&route.isActive)nav.removeRoute(route);
    widget.onNavigate(node.route!);
  }
  Widget _label(WorkspaceNavigationNode n,{bool folded=false}){
    final icon=n.icon!=null?widget.iconBuilder?.call(n.icon!):null;
    return Row(mainAxisSize:MainAxisSize.min,children:[
      if(icon!=null)...[SizedBox(width:24,height:24,child:icon),if(!folded)const SizedBox(width:8)],
      if(folded&&icon==null)const PrimeOriginalAsset('placeholder-circle',size:20),
      if(!folded)Flexible(child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[PrimeText(n.label),if(n.subtitle!=null)PrimeText(n.subtitle!,style:Theme.of(context).textTheme.labelSmall)])),
      if(!folded&&n.badge!=null)...[const SizedBox(width:8),PrimeText(n.badge!)],
    ]);
  }
  List<WorkspaceNavigationNode> _visible(List<WorkspaceNavigationNode> list){return [for(final n in list)...[if(!n.disabled)n,if(n.kind=='group'&&_expanded.contains(n.id))..._visible(n.children)]];}
  void _focusAfter(String id,{String prefix=''}){
    final node=widget.model.find(id);if(node==null||node.disabled)return;
    final focus=_node(id,prefix:prefix);
    if(focus.context!=null&&focus.context!.mounted&&focus.canRequestFocus){focus.requestFocus();return;}
    final generation=_generation;
    WidgetsBinding.instance.addPostFrameCallback((_){final current=widget.model.find(id);if(mounted&&generation==_generation&&current!=null&&!current.disabled)_node(id,prefix:prefix).requestFocus();});
    WidgetsBinding.instance.ensureVisualUpdate();
  }
  KeyEventResult _keys(String id,KeyEvent event,List<WorkspaceNavigationNode> roots,{String prefix=''}){
    final node=widget.model.find(id);if(node==null||node.disabled)return KeyEventResult.ignored;
    if([LogicalKeyboardKey.enter,LogicalKeyboardKey.space].contains(event.logicalKey)){
      if(event is KeyDownEvent){if(node.kind=='group')_mutate(()=>_expanded.contains(id)?_expanded.remove(id):_expanded.add(id));else _activate(id,_generation);}return KeyEventResult.handled;
    }
    if(event is! KeyDownEvent&&event is! KeyRepeatEvent)return KeyEventResult.ignored;
    final rtl=Directionality.of(context)==TextDirection.rtl,forward=rtl?LogicalKeyboardKey.arrowLeft:LogicalKeyboardKey.arrowRight,back=rtl?LogicalKeyboardKey.arrowRight:LogicalKeyboardKey.arrowLeft;
    if(event.logicalKey==forward&&node.kind=='group'){
      _mutate(()=>_expanded.add(id));final child=node.children.where((n)=>!n.disabled).firstOrNull;if(child!=null)_focusAfter(child.id,prefix:prefix);return KeyEventResult.handled;
    }
    if(event.logicalKey==back||event.logicalKey==LogicalKeyboardKey.escape){
      if(_expanded.contains(id)){_mutate(()=>_expanded.remove(id));return KeyEventResult.handled;}
      WorkspaceNavigationNode? parent;for(final n in widget.model.flattened){if(n.children.any((c)=>c.id==id)){parent=n;break;}}
      if(parent!=null){_mutate(()=>_expanded.remove(parent!.id));_focusAfter(parent.id,prefix:prefix);return KeyEventResult.handled;}
    }
    final items=_visible(roots),index=items.indexWhere((n)=>n.id==id);if(index<0)return KeyEventResult.ignored;
    var next=-1;
    if(event.logicalKey==LogicalKeyboardKey.arrowDown)next=(index+1)%items.length;
    if(event.logicalKey==LogicalKeyboardKey.arrowUp)next=(index-1+items.length)%items.length;
    if(event.logicalKey==LogicalKeyboardKey.home)next=0;
    if(event.logicalKey==LogicalKeyboardKey.end)next=items.length-1;
    if(next<0)return KeyEventResult.ignored;_focusAfter(items[next].id,prefix:prefix);return KeyEventResult.handled;
  }
  Widget _vertical(List<WorkspaceNavigationNode> roots,{bool folded=false,String prefix=''}){
    Widget item(WorkspaceNavigationNode n,int depth){
      final open=_expanded.contains(n.id),active=_activeId==n.id,generation=_generation;
      final button=Focus(onKeyEvent:(_,e)=>_keys(n.id,e,roots,prefix:prefix),child:Semantics(expanded:n.kind=='group'?open:null,
        child:Tooltip(message:n.label,child:PrimeTextButton(focusNode:_boundNode(n.id,(event)=>_keys(n.id,event,roots,prefix:prefix),prefix:prefix),key:ValueKey('workspace-navigation-${n.id}'),
          style:PrimeTextButton.styleFrom(alignment:AlignmentDirectional.centerStart,minimumSize:const Size(44,44),backgroundColor:active?Theme.of(context).colorScheme.primaryContainer:null),
          onPressed:n.disabled?null:()=>n.kind=='group'?_mutate(()=>open?_expanded.remove(n.id):_expanded.add(n.id)):_activate(n.id,generation),
          child:Semantics(label:folded?n.label:null,child:_label(n,folded:folded))))));
      return Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.stretch,children:[Padding(padding:EdgeInsetsDirectional.only(start:folded?0:depth*12.0),child:button),
        if(n.kind=='group'&&open&&!folded)for(final child in n.children)item(child,depth+1)]);
    }
    return Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.stretch,children:[for(final n in roots)item(n,0)]);
  }
  Widget _horizontal(){
    final generation=_generation;
    Widget entry(WorkspaceNavigationNode n){
      if(n.kind=='group'&&n.disabled)return MenuItemButton(onPressed:null,child:_label(n));
      if(n.kind=='group')return SubmenuButton(controller:_submenus.putIfAbsent(n.id,()=>MenuController()),focusNode:_node(n.id,prefix:'menu:'),key:ValueKey('workspace-navigation-${n.id}'),
        onOpen:n.disabled?null:(){},menuChildren:n.children.map(entry).toList(),child:_label(n));
      return Semantics(selected:n.id==_activeId,child:MenuItemButton(focusNode:_node(n.id,prefix:'menu:'),key:ValueKey('workspace-navigation-${n.id}'),style:n.id==_activeId?ButtonStyle(backgroundColor:WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)):null,onPressed:n.disabled?null:()=>_activate(n.id,generation),child:_label(n)));
    }
    final enabled=widget.model.nodes.where((n)=>!n.disabled).toList();
    final groups=enabled.where((n)=>n.kind=='group').toList();
    final bar=groups.isNotEmpty?MenuBar(controller:_menuController,children:widget.model.nodes.map(entry).toList()):Row(mainAxisSize:MainAxisSize.min,children:[for(final n in widget.model.nodes)
      Focus(onKeyEvent:(_,event){
        if(enabled.isEmpty||event is! KeyDownEvent&&event is! KeyRepeatEvent)return KeyEventResult.ignored;
        final rtl=Directionality.of(context)==TextDirection.rtl,index=enabled.indexOf(n);var next=index;
        if(event.logicalKey==LogicalKeyboardKey.home){next=0;}else if(event.logicalKey==LogicalKeyboardKey.end){next=enabled.length-1;}
        else if(event.logicalKey==LogicalKeyboardKey.arrowRight){next=(index+(rtl?-1:1)+enabled.length)%enabled.length;}
        else if(event.logicalKey==LogicalKeyboardKey.arrowLeft){next=(index+(rtl?1:-1)+enabled.length)%enabled.length;}else{return KeyEventResult.ignored;}
        if(enabled.isNotEmpty)_focusAfter(enabled[next].id,prefix:'menu:');return KeyEventResult.handled;
      },child:Semantics(selected:n.id==_activeId,child:PrimeTextButton(key:ValueKey('workspace-navigation-${n.id}'),focusNode:_node(n.id,prefix:'menu:'),style:n.id==_activeId?ButtonStyle(backgroundColor:WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)):null,onPressed:n.disabled?null:()=>_activate(n.id,generation),child:_label(n))))]);
    return Focus(key:const ValueKey('workspace-navigation-menu-entry'),focusNode:_menuEntryFocus,
      onFocusChange:(_)=>setState((){}),onKeyEvent:(_,event){
        if(!_menuEntryFocus.hasPrimaryFocus||event is! KeyDownEvent)return KeyEventResult.ignored;
        if(![LogicalKeyboardKey.enter,LogicalKeyboardKey.space,LogicalKeyboardKey.arrowDown,LogicalKeyboardKey.arrowUp].contains(event.logicalKey))return KeyEventResult.ignored;
        final roots=widget.model.nodes.where((n)=>!n.disabled).toList();if(roots.isEmpty)return KeyEventResult.ignored;
        if(groups.isNotEmpty)_submenus[groups.first.id]!.open();_focusAfter(event.logicalKey==LogicalKeyboardKey.arrowUp?roots.last.id:roots.first.id,prefix:'menu:');return KeyEventResult.handled;
      },child:DecoratedBox(decoration:BoxDecoration(border:Border.all(color:_menuEntryFocus.hasPrimaryFocus?Theme.of(context).colorScheme.primary:Colors.transparent,width:2)),
        child:SingleChildScrollView(scrollDirection:Axis.horizontal,child:bar)));
  }
  KeyEventResult _railKey(String id,KeyEvent event){
    if(event is! KeyDownEvent&&event is! KeyRepeatEvent)return KeyEventResult.ignored;
    final rtl=Directionality.of(context)==TextDirection.rtl;
    final forward=rtl?LogicalKeyboardKey.arrowLeft:LogicalKeyboardKey.arrowRight,back=rtl?LogicalKeyboardKey.arrowRight:LogicalKeyboardKey.arrowLeft;
    final groups=widget.model.nodes.where((n)=>n.kind=='group'&&!n.disabled).toList(),key=event.logicalKey;
    final index=groups.indexWhere((n)=>n.id==id);if(index<0)return KeyEventResult.ignored;var next=-1;
    if(key==LogicalKeyboardKey.arrowDown||key==forward)next=(index+1)%groups.length;
    if(key==LogicalKeyboardKey.arrowUp||key==back)next=(index-1+groups.length)%groups.length;
    if(key==LogicalKeyboardKey.home)next=0;if(key==LogicalKeyboardKey.end)next=groups.length-1;
    if(next<0)return KeyEventResult.ignored;_mutate(()=>_selected=groups[next].id);_focusAfter(groups[next].id);return KeyEventResult.handled;
  }
  Widget _rail(){
    final groups=widget.model.nodes.where((n)=>n.kind=='group').toList();final selected=widget.model.find(_selected??'');
    return Row(crossAxisAlignment:CrossAxisAlignment.start,children:[SizedBox(width:72,child:Column(mainAxisSize:MainAxisSize.min,children:[for(final group in groups)
      Focus(onKeyEvent:(_,e)=>_railKey(group.id,e),child:Semantics(selected:group.id==_selected,child:Tooltip(message:group.label,child:PrimeIconButton(focusNode:_boundNode(group.id,(event)=>_railKey(group.id,event)),key:ValueKey('workspace-navigation-tab-${group.id}'),
        onPressed:group.disabled?null:(){_node(group.id).requestFocus();_mutate(()=>_selected=group.id);},icon:group.icon!=null?(widget.iconBuilder?.call(group.icon!)??const PrimeOriginalAsset('folder')):const PrimeOriginalAsset('folder')))))])),
      Expanded(child:Column(mainAxisSize:MainAxisSize.min,children:[if(selected!=null&&!selected.disabled)_vertical(selected.children),_vertical(widget.model.nodes.where((n)=>n.kind=='item').toList())])),
    ]);
  }
  Widget _panel({bool drawer=false}){
    final folded=!drawer&&widget.mode=='folded'&&!_wide;
    final contents=widget.mode=='rail'&&!drawer?_rail():_vertical(widget.model.nodes,folded:folded,prefix:drawer?'drawer:':'');
    return SizedBox(width:drawer?null:widget.mode=='rail'?340:folded?64:260,child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[
      if(drawer)Align(alignment:AlignmentDirectional.centerEnd,child:PrimeIconButton(tooltip:widget.labels.close,onPressed:(){final route=_dialog,nav=_navigator;if(route!=null&&nav!=null&&route.isActive)nav.removeRoute(route);_dialog=null;_navigator=null;},icon:const PrimeOriginalAsset('close'))),
      if(!drawer&&widget.mode=='folded')PrimeIconButton(tooltip:_pinned?widget.labels.unpin:widget.labels.pin,
        onPressed:()=>_mutate(()=>_pinned=!_pinned),icon:PrimeOriginalAsset('pin-panel',strokeScale:_pinned?1.4:1)),
      contents,
    ])));
  }
  void _openDrawer(){
    if(_dialog!=null)return;final nav=Navigator.of(context);final route=DialogRoute<void>(context:context,barrierDismissible:true,
      builder:(_)=>Align(alignment:AlignmentDirectional.centerStart,child:SizedBox(width:math.min(340,MediaQuery.sizeOf(context).width-44),child:Drawer(child:SafeArea(child:ValueListenableBuilder<int>(valueListenable:_dialogUpdates,builder:(_,value,child)=>_panel(drawer:true)))))));
    _dialog=route;_navigator=nav;nav.push(route).whenComplete((){if(identical(_dialog,route)){_dialog=null;_navigator=null;}});
  }
  @override Widget build(BuildContext context){
    if(_reported!=_wide){_reported=_wide;final expanded=_wide,generation=_generation;WidgetsBinding.instance.addPostFrameCallback((_){if(mounted&&generation==_generation)widget.onExpandedChanged?.call(expanded);});}
    if(widget.scope.trim().isEmpty||!['vertical','horizontal-header','horizontal-footer'].contains(widget.family)||!['expanded','folded','rail'].contains(widget.mode))throw StateError('Invalid navigation presentation');
    _activeId=widget.model.active(widget.currentRoute);
    if(!_narrow&&_dialog!=null)_closeDialogLater();
    if(_narrow)return PrimeIconButton(tooltip:widget.labels.open,onPressed:_openDrawer,icon:const PrimeOriginalAsset('menu'));
    return Semantics(label:widget.labels.navigation,container:true,child:KeyedSubtree(key:ValueKey('${widget.scope}:${jsonEncode(widget.model.toJson())}'),
      child:MouseRegion(onEnter:(_)=>_mutate(()=>_hover=true),onExit:(_)=>_mutate(()=>_hover=false),
        child:Focus(onFocusChange:(focused)=>_mutate(()=>_focused=focused),child:widget.family=='vertical'?_panel():_horizontal()))));
  }
}
