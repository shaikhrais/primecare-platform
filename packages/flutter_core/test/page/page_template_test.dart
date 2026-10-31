import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/page_template.dart';
import 'package:flutter_core/workspace.dart';

const labels=PageTemplateLabels(breadcrumbs:'Breadcrumbs',openLeft:'Open left',closeLeft:'Close left',openRight:'Open right',closeRight:'Close right');
const metrics=PageTemplateMetrics(headerPadding:EdgeInsets.all(16),contentPadding:EdgeInsets.all(16),gap:16,runGap:8,breakpoint:1024,drawerEdgeGap:44,sidebarFraction:.28);
List<Map<String,dynamic>> fixtures()=>(jsonDecode(File('test/page/fixtures/web.json').readAsStringSync()) as List<dynamic>).cast<Map<String,dynamic>>();
PageRouteRegistry registry(Map<String,dynamic> f){final a=f['authority'] as Map<String,dynamic>;return PageRouteRegistry.fromJson(f['routes'],allowedIds:(a['ids'] as List<dynamic>).cast<String>(),allowedRoutes:(a['routes'] as List<dynamic>).cast<String>());}
RegisteredPageRoute route({String template='simple',String scroll='content',String left='permanent',String right='permanent',bool open=true,String id='page_one',String path='/one',PageChrome chrome=const PageChrome()}){
 final f=fixtures().first,raw=(jsonDecode(jsonEncode((f['routes'] as List<dynamic>).first)) as Map<String,dynamic>);raw['id']=id;raw['route']=path;final layout=raw['layout'] as Map<String,dynamic>;layout['template']=template;layout['scroll']=scroll;layout['left']={'mode':left,'width':280,'open':open};layout['right']={'mode':right,'width':240,'open':open};layout['chrome']=chrome.toJson();return PageRouteRegistry.fromJson([raw],allowedIds:['page_one','page_two','home','current'],allowedRoutes:['/one','/two?tab=details','/']).routes.single;
}
void main(){
 test('96 route/layout cases match web and export independent native normalization',(){
  final out=<Map<String,Object?>>[];for(final f in fixtures()){final r=registry(f);expect(r.toJson(),f['expected']);expect(r.resolve(f['current'] as String)?.id,f['resolved']);out.add({'routes':r.toJson(),'resolved':r.resolve(f['current'] as String)?.id});}File('test/page/fixtures/native.json').writeAsStringSync(jsonEncode(out));
  expect(()=>PageLayout.fromJson({...PageLayout.defaults().toJson(),'permissions':['admin']}),throwsFormatException);
 });
 testWidgets('simple/carded and all scroll modes retain supplied form and independently toggle sidebars in LTR RTL',(tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final routes=<String>[];
  Future<void> mount(String template,String scroll,TextDirection dir)async{final page=PrimePageTemplate(route:route(template:template,scroll:scroll),scope:'actor',labels:labels,metrics:metrics,content:const Column(children:[TextField(key:ValueKey('main-form')),SizedBox(height:1500)]),left:const TextField(key:ValueKey('left-form')),right:const Text('Right content'),onNavigate:routes.add);await tester.pumpWidget(MaterialApp(home:Directionality(textDirection:dir,child:Scaffold(body:scroll=='normal'?SingleChildScrollView(child:page):page))));await tester.pumpAndSettle();}
  await mount('simple','content',TextDirection.ltr);await tester.enterText(find.byKey(const ValueKey('main-form')),'Unsaved main');await tester.enterText(find.byKey(const ValueKey('left-form')),'Unsaved sidebar');
  // Normal scrolling is tested in a separate parent-owned host below; switching its ancestor deliberately remounts the host.
  for(final dir in [TextDirection.ltr,TextDirection.rtl])for(final template in ['simple','carded'])for(final scroll in ['content','page']){
   await mount(template,scroll,dir);expect(find.text('Unsaved main'),findsOneWidget);expect(find.text('Unsaved sidebar'),findsOneWidget);expect(find.text('PRIVATE breadcrumb'),findsNothing);
   await tester.tap(find.byKey(const ValueKey('page-toggle-left')));await tester.pumpAndSettle();expect(find.byKey(const ValueKey('left-form')),findsNothing);expect(find.text('Right content'),findsOneWidget);
   await tester.tap(find.byKey(const ValueKey('page-toggle-left')));await tester.pumpAndSettle();expect(find.text('Unsaved sidebar'),findsOneWidget);expect(tester.takeException(),isNull);
  }
  await mount('carded','normal',TextDirection.rtl);expect(find.byKey(const ValueKey('main-form')),findsOneWidget);expect(tester.takeException(),isNull);
 });
 testWidgets('responsive drawer retains sidebar state, Escape restores trigger focus, route changes reset scroll and revoke callbacks',(tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final routes=<String>[];Future<void> mount(RegisteredPageRoute? r,{String scope='actor'})async{await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimePageTemplate(route:r,scope:scope,labels:labels,metrics:metrics,content:const Column(children:[TextField(key:ValueKey('main')),SizedBox(height:1500)]),left:const TextField(key:ValueKey('side')),right:const Text('Right'),onNavigate:routes.add))));await tester.pumpAndSettle();}
  await mount(route(left:'responsive',right:'temporary'));await tester.enterText(find.byKey(const ValueKey('side')),'Sidebar draft');final old=tester.widget<TextButton>(find.byKey(const ValueKey('page-breadcrumb-home'))).onPressed!;
  tester.view.physicalSize=const Size(390,844);await tester.pumpAndSettle();await tester.tap(find.byKey(const ValueKey('page-toggle-left')));await tester.pumpAndSettle();expect(find.text('Sidebar draft'),findsOneWidget);await tester.sendKeyEvent(LogicalKeyboardKey.escape);await tester.pumpAndSettle();expect(find.byType(Drawer),findsNothing);expect(tester.widget<TextButton>(find.byKey(const ValueKey('page-toggle-left'))).focusNode!.hasFocus,true);
  tester.view.physicalSize=const Size(1500,960);await tester.pumpAndSettle();final scroll=tester.widget<SingleChildScrollView>(find.byKey(const ValueKey('page-content-scroll'))).controller!;scroll.jumpTo(300);await tester.pumpAndSettle();
  await mount(route(id:'page_two',path:'/two?tab=details',left:'responsive',right:'temporary'),scope:'other');old();expect(routes,isEmpty);expect(scroll.offset,0);expect(find.text('Sidebar draft'),findsNothing);expect(tester.takeException(),isNull);
  await mount(null,scope:'denied');expect(find.byKey(const ValueKey('main')),findsNothing);
 });
 testWidgets('route chrome hides geometry and focus without changing saved workspace preferences',(tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final c=WorkspaceController(scope:WorkspaceScope(tenant:'t',user:'u',role:'r'),panelIds:[]);addTearDown(c.dispose);final before=c.current.exportJson();
  Future<void> mount(PageChrome chrome)async{await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimeWorkspaceLayout(controller:c,navigationVisible:chrome.navigation,toolbarVisible:chrome.toolbar,footerVisible:chrome.footer,navigation:TextButton(onPressed:(){},child:const Text('Navigation')),toolbar:TextButton(onPressed:(){},child:const Text('Toolbar')),footer:TextButton(onPressed:(){},child:const Text('Footer')),main:const TextField(key:ValueKey('existing')),panels:const {}))));await tester.pumpAndSettle();}
  await mount(const PageChrome());await tester.enterText(find.byKey(const ValueKey('existing')),'Retained');
  for(final navigation in [true,false])for(final toolbar in [true,false])for(final footer in [true,false]){
   await mount(PageChrome(navigation:navigation,toolbar:toolbar,footer:footer));expect(find.text('Navigation'),navigation?findsOneWidget:findsNothing);expect(find.text('Toolbar'),toolbar?findsOneWidget:findsNothing);expect(find.text('Footer'),footer?findsOneWidget:findsNothing);expect(find.text('Retained'),findsOneWidget);expect(c.current.exportJson(),before);expect(tester.getTopLeft(find.byKey(const ValueKey('existing'))).dx,navigation?c.current.navigationWidth.toDouble():0);expect(tester.takeException(),isNull);
  }

 });
}
