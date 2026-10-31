import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page_template_model.dart';

class PageTemplateMetrics {
  final EdgeInsets headerPadding,contentPadding;
  final double gap,runGap,breakpoint,drawerEdgeGap,sidebarFraction;
  const PageTemplateMetrics({required this.headerPadding,required this.contentPadding,required this.gap,required this.runGap,required this.breakpoint,required this.drawerEdgeGap,required this.sidebarFraction});
}
class PageTemplateLabels {
  final String breadcrumbs,openLeft,closeLeft,openRight,closeRight;
  const PageTemplateLabels({required this.breadcrumbs,required this.openLeft,required this.closeLeft,required this.openRight,required this.closeRight});
}
/// Presentation slots only. The host supplies current server-authorized route metadata and content.
class PrimePageTemplate extends StatefulWidget {
  final RegisteredPageRoute? route;
  final String scope;
  final PageTemplateLabels labels;
  final PageTemplateMetrics metrics;
  final Widget content;
  final Widget? header,actions,left,right;
  final ValueChanged<String> onNavigate;
  final ScrollController? parentScrollController;
  const PrimePageTemplate({super.key,required this.route,required this.scope,required this.labels,required this.metrics,required this.content,required this.onNavigate,this.header,this.actions,this.left,this.right,this.parentScrollController});
  @override State<PrimePageTemplate> createState()=>_PrimePageTemplateState();
}
class _PrimePageTemplateState extends State<PrimePageTemplate> {
  final _keys=<String,GlobalKey>{};
  final _pageScroll=ScrollController(),_contentScroll=ScrollController();
  final _headingFocus=FocusNode(debugLabel:'page-heading');
  final _triggers={'left':FocusNode(debugLabel:'page-left-trigger'),'right':FocusNode(debugLabel:'page-right-trigger')};
  final _updates=ValueNotifier<int>(0);
  final _open=<String,bool>{'left':false,'right':false};
  DialogRoute<void>? _dialog;NavigatorState? _navigator;String? _modalSide;
  bool? _narrow;int _generation=0;
  String identity(PrimePageTemplate w)=>jsonEncode([w.scope,w.route?.id,w.route?.route]);
  @override void initState(){super.initState();_defaults();_resetScroll();}
  void _defaults(){_open['left']=widget.route!=null&&widget.route!.layout.left.mode!='temporary'&&widget.route!.layout.left.open;_open['right']=widget.route!=null&&widget.route!.layout.right.mode!='temporary'&&widget.route!.layout.right.open;}
  void _resetScroll(){WidgetsBinding.instance.addPostFrameCallback((_){if(!mounted)return;for(final c in [_pageScroll,_contentScroll,if(widget.parentScrollController!=null)widget.parentScrollController!]){if(c.hasClients)c.jumpTo(0);}_headingFocus.requestFocus();});}
  @override void didUpdateWidget(PrimePageTemplate oldWidget){super.didUpdateWidget(oldWidget);
    if(identity(oldWidget)!=identity(widget)){_generation++;_keys.clear();_defaults();_closeLater();_resetScroll();}
    else if(widget.route!=null){for(final side in ['left','right']){final old=side=='left'?oldWidget.route?.layout.left:oldWidget.route?.layout.right;if(_config(side).mode=='temporary'&&old?.mode!='temporary')_open[side]=false;}if(_dialog!=null){WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)_updates.value++;});}}
  }
  @override void dispose(){_generation++;final nav=_navigator,route=_dialog;if(nav!=null&&route!=null)WidgetsBinding.instance.addPostFrameCallback((_){if(nav.mounted&&route.isActive)nav.removeRoute(route);});_pageScroll.dispose();_contentScroll.dispose();_headingFocus.dispose();for(final f in _triggers.values)f.dispose();_updates.dispose();super.dispose();}
  PageSidebar _config(String side)=>side=='left'?widget.route!.layout.left:widget.route!.layout.right;
  Widget? _child(String side)=>side=='left'?widget.left:widget.right;
  bool _temporary(String side)=>_config(side).mode=='temporary'||_config(side).mode=='responsive'&&_narrow==true;
  String _label(String side,bool open)=>side=='left'?(open?widget.labels.closeLeft:widget.labels.openLeft):(open?widget.labels.closeRight:widget.labels.openRight);
  Widget _slot(String id,Widget child,{bool hidden=false})=>ExcludeFocus(excluding:hidden,child:Offstage(offstage:hidden,child:KeyedSubtree(key:_keys.putIfAbsent(id,()=>GlobalKey()),child:child)));
  void _closeLater(){if(_dialog!=null)WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)_closeDrawer(reset:false);});}
  void _closeDrawer({bool reset=true}){final nav=_navigator,route=_dialog,side=_modalSide;_dialog=null;_navigator=null;_modalSide=null;if(route!=null&&nav!=null&&route.isActive)nav.removeRoute(route);if(mounted)setState((){if(reset&&side!=null)_open[side]=false;});if(reset&&side!=null)_triggers[side]?.requestFocus();}
  void _toggle(String side){if(widget.route==null||_child(side)==null||_config(side).mode=='none')return;
    if(_modalSide==side){_closeDrawer();return;}
    if(_temporary(side)){if(_dialog!=null)_closeDrawer();_showDrawer(side);}else{setState(()=>_open[side]=!_open[side]!);}
  }
  void _showDrawer(String side){
    final nav=Navigator.of(context);final generation=_generation;
    final route=DialogRoute<void>(context:context,barrierDismissible:false,builder:(_)=>PopScope<void>(canPop:false,onPopInvokedWithResult:(didPop,result){if(!didPop)_closeDrawer();},child:Focus(onKeyEvent:(_,event){if(event is KeyDownEvent&&event.logicalKey==LogicalKeyboardKey.escape){_closeDrawer();return KeyEventResult.handled;}return KeyEventResult.ignored;},child:Align(alignment:side=='left'?Alignment.centerLeft:Alignment.centerRight,child:SizedBox(width:math.min(_config(side).width.toDouble(),MediaQuery.sizeOf(context).width-widget.metrics.drawerEdgeGap),child:Drawer(child:SafeArea(child:ValueListenableBuilder<int>(valueListenable:_updates,builder:(_,value,child)=>Column(children:[Align(alignment:AlignmentDirectional.centerEnd,child:IconButton(autofocus:true,tooltip:_label(side,true),onPressed:_closeDrawer,icon:const Icon(Icons.close))),Expanded(child:SingleChildScrollView(child:_slot(side,_child(side)??const SizedBox.shrink())))])))))))));
    setState((){_dialog=route;_navigator=nav;_modalSide=side;_open[side]=true;});
    nav.push(route).whenComplete((){if(mounted&&generation==_generation&&identical(_dialog,route)){setState((){_dialog=null;_navigator=null;_modalSide=null;_open[side]=false;});}});
  }
  void _navigate(PageBreadcrumb crumb,int generation){if(!mounted||generation!=_generation||crumb.route==null||!(widget.route?.breadcrumbs.any((c)=>c.id==crumb.id&&c.route==crumb.route)??false))return;widget.onNavigate(crumb.route!);}
  Widget _header(){final route=widget.route!,generation=_generation;
    return Padding(padding:widget.metrics.headerPadding,child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
      Focus(focusNode:_headingFocus,skipTraversal:true,child:Semantics(header:true,child:Text(route.title,style:Theme.of(context).textTheme.headlineSmall))),
      Semantics(label:widget.labels.breadcrumbs,container:true,child:Wrap(children:[for(final crumb in route.breadcrumbs)if(crumb.route!=null)TextButton(key:ValueKey('page-breadcrumb-${crumb.id}'),onPressed:()=>_navigate(crumb,generation),child:Text(crumb.label))else Text(crumb.label)])),
      if(widget.header!=null)_slot('header',widget.header!),
      Wrap(spacing:widget.metrics.gap,runSpacing:widget.metrics.runGap,children:[if(widget.actions!=null)_slot('actions',widget.actions!),for(final side in ['left','right'])if(_child(side)!=null&&_config(side).mode!='none')TextButton(key:ValueKey('page-toggle-$side'),focusNode:_triggers[side],onPressed:()=>_toggle(side),child:Text(_label(side,_open[side]!)))])
    ]));
  }
  @override Widget build(BuildContext context){
    if(!widget.metrics.breakpoint.isFinite||widget.metrics.breakpoint<=0||!widget.metrics.drawerEdgeGap.isFinite||widget.metrics.drawerEdgeGap<0||!widget.metrics.sidebarFraction.isFinite||widget.metrics.sidebarFraction<=0||widget.metrics.sidebarFraction>=.5)throw StateError('Invalid page metrics');
    if(widget.scope.trim().isEmpty)throw StateError('Page actor scope required');final route=widget.route;if(route==null)return const SizedBox.shrink();
    return Title(title:route.title,color:Theme.of(context).colorScheme.primary,child:LayoutBuilder(builder:(context,constraints){
      final narrow=MediaQuery.sizeOf(context).width<=widget.metrics.breakpoint;
      if(_narrow==null||_narrow!=narrow){for(final side in ['left','right'])if(_config(side).mode=='responsive'&&narrow)_open[side]=false;_closeLater();}_narrow=narrow;
      final contentScroll=route.layout.scroll=='content',pageScroll=route.layout.scroll=='page';
      if((contentScroll||pageScroll)&&!constraints.hasBoundedHeight)throw FlutterError('Page/content scrolling requires a bounded page host');
      final width=constraints.hasBoundedWidth?constraints.maxWidth:MediaQuery.sizeOf(context).width;
      Widget content() {final child=Padding(padding:widget.metrics.contentPadding,child:_slot('content',widget.content));return route.layout.template=='carded'?Card(margin:EdgeInsets.zero,child:child):child;}
      bool inline(String side)=>_modalSide!=side&&_child(side)!=null&&_config(side).mode!='none'&&_open[side]!&&!_temporary(side);
      Widget sidebar(String side)=>SizedBox(width:math.min(_config(side).width.toDouble(),width*widget.metrics.sidebarFraction),child:contentScroll?SingleChildScrollView(child:_slot(side,_child(side)!)):_slot(side,_child(side)!));
      final row=Row(textDirection:TextDirection.ltr,crossAxisAlignment:contentScroll?CrossAxisAlignment.stretch:CrossAxisAlignment.start,children:[if(inline('left'))sidebar('left'),Expanded(child:contentScroll?SingleChildScrollView(key:ValueKey('page-content-scroll'),controller:_contentScroll,child:content()):content()),if(inline('right'))sidebar('right')]);
      final body=contentScroll?Column(children:[_header(),Expanded(child:row)]):Column(mainAxisSize:MainAxisSize.min,children:[_header(),row]);
      return Stack(children:[if(pageScroll)SingleChildScrollView(key:const ValueKey('page-scroll'),controller:_pageScroll,child:body)else body,
        for(final side in ['left','right'])if(_child(side)!=null&&!inline(side)&&_modalSide!=side)_slot(side,_child(side)!,hidden:true),
      ]);
    }));
  }
}
