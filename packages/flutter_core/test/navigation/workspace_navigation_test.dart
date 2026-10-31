import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/workspace.dart';
import 'package:flutter_core/workspace_navigation.dart';

List<Map<String,dynamic>> fixtures()=> (jsonDecode(File('test/navigation/fixtures/web.json').readAsStringSync()) as List<dynamic>).cast<Map<String,dynamic>>();
WorkspaceNavigationModel model(Map<String,dynamic> c,{bool denied=false}){
  final a=c['authority'] as Map<String,dynamic>;
  return WorkspaceNavigationModel.fromJson(c['items'],allowedIds:denied?[]:(a['ids'] as List<dynamic>).cast<String>(),allowedRoutes:(a['routes'] as List<dynamic>).cast<String>(),registeredIcons:(a['icons'] as List<dynamic>).cast<String>());
}
const labels=WorkspaceNavigationLabels(navigation:'Navigation',open:'Open navigation',close:'Close navigation',pin:'Pin navigation',unpin:'Unpin navigation');
void main(){
 test('21 authority and route cases match web; native output is independently checked by web',(){
  final out=<Map<String,Object?>>[];
  for(final f in fixtures()){final m=model(f);expect(m.toJson(),f['expected']);expect(m.active(f['current'] as String),f['active']);out.add({'nodes':m.toJson(),'active':m.active(f['current'] as String)});}
  File('test/navigation/fixtures/native.json').writeAsStringSync(jsonEncode(out));
  final profile=WorkspaceLayout.defaults(['note']);for(final family in ['vertical','horizontal-header','horizontal-footer']){expect(navigationPreset(profile,family).panels['note']!.toJson(),profile.panels['note']!.toJson());}
  expect(()=>WorkspaceNavigationModel.fromJson([{'id':'bad','kind':'item','label':'Bad','route':'//evil.invalid'}],allowedIds:['bad'],allowedRoutes:['//evil.invalid'],registeredIcons:[]),throwsFormatException);
 });
 testWidgets('three compositions preserve main state and nested menus support keyboard LTR RTL', (tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final c=WorkspaceController(scope:WorkspaceScope(tenant:'tenant',user:'actor',role:'staff'),panelIds:[]);addTearDown(c.dispose);
  final m=model(fixtures().first),routes=<String>[];
  Future<void> mount(String family,TextDirection dir)async{
   c.change(navigationPreset(c.current,family));
   await tester.pumpWidget(MaterialApp(home:Directionality(textDirection:dir,child:Scaffold(body:PrimeWorkspaceLayout(controller:c,
    navigation:PrimeWorkspaceNavigation(model:m,scope:'tenant:actor:role',currentRoute:'/app/people',family:family,labels:labels,onNavigate:routes.add),toolbar:const Text('Existing toolbar'),main:const TextField(key:ValueKey('existing-form')),panels:const {})))));await tester.pumpAndSettle();
  }
  await mount('vertical',TextDirection.ltr);await tester.enterText(find.byKey(const ValueKey('existing-form')),'Unsaved business form');
  for(final dir in [TextDirection.ltr,TextDirection.rtl])for(final family in ['vertical','horizontal-header','horizontal-footer']){
   await mount(family,dir);expect(find.text('Unsaved business form'),findsOneWidget);expect(find.textContaining('PRIVATE'),findsNothing);
   final before=routes.length;
   final group=find.byKey(const ValueKey('workspace-navigation-work'));await tester.ensureVisible(group);
   final forward=dir==TextDirection.rtl?LogicalKeyboardKey.arrowLeft:LogicalKeyboardKey.arrowRight;
   if(family=='vertical'){
    tester.widget<TextButton>(group).focusNode!.requestFocus();await tester.pump();
    await tester.sendKeyEvent(forward);await tester.pumpAndSettle();
    expect(tester.widget<TextButton>(find.byKey(const ValueKey('workspace-navigation-home'))).focusNode!.hasFocus,true);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);await tester.pumpAndSettle();expect(tester.widget<TextButton>(find.byKey(const ValueKey('workspace-navigation-team'))).focusNode!.hasFocus,true,reason:'Nested group focus');await tester.sendKeyEvent(forward);await tester.pumpAndSettle();expect(tester.widget<TextButton>(find.byKey(const ValueKey('workspace-navigation-people'))).focusNode!.hasFocus,true,reason:'Nested destination focus');
   }else{
    await tester.tap(group);await tester.pumpAndSettle();await tester.sendKeyEvent(LogicalKeyboardKey.home);await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);await tester.sendKeyEvent(forward);await tester.pumpAndSettle();
   }
   await tester.sendKeyEvent(LogicalKeyboardKey.enter);await tester.pumpAndSettle();expect(routes.length,before+1,reason:'$family $dir focus=${tester.binding.focusManager.primaryFocus?.debugLabel}');expect(routes.last,'/app/people');expect(tester.takeException(),isNull);
  }
 });
 testWidgets('folded composition changes visual width without rewriting the saved profile',(tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final c=WorkspaceController(scope:WorkspaceScope(tenant:'tenant',user:'actor',role:'staff'),panelIds:[]);addTearDown(c.dispose);
  final m=model(fixtures().first);var width=64.0;
  await tester.pumpWidget(MaterialApp(home:Scaffold(body:StatefulBuilder(builder:(context,setFrame)=>PrimeWorkspaceLayout(controller:c,navigationVisualWidth:width,
   navigation:PrimeWorkspaceNavigation(model:m,scope:'actor',currentRoute:'/app',mode:'folded',pinned:false,labels:labels,onNavigate:(_){},onExpandedChanged:(expanded){final next=expanded?248.0:64.0;if(next!=width)setFrame(()=>width=next);}),
   toolbar:const Text('Toolbar'),main:const TextField(key:ValueKey('form')),panels:const {})))));await tester.pumpAndSettle();
  expect(tester.getSize(find.byType(PrimeWorkspaceNavigation)).width,64);
  tester.widget<TextButton>(find.byKey(const ValueKey('workspace-navigation-work'))).focusNode!.requestFocus();await tester.pumpAndSettle();expect(tester.getSize(find.byType(PrimeWorkspaceNavigation)).width,248);
  await tester.tap(find.byKey(const ValueKey('form')));await tester.pumpAndSettle();expect(tester.getSize(find.byType(PrimeWorkspaceNavigation)).width,64);expect(c.current.navigationWidth,248);
 });
 testWidgets('rail keyboard, folded pin and mobile drawer revoke old destinations', (tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final m=model(fixtures().first),routes=<String>[];
  Future<void> mount({String mode='expanded',String scope='actor',bool denied=false,double width=1500})async{
   tester.view.physicalSize=Size(width,960);
   await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimeWorkspaceNavigation(model:denied?model(fixtures().first,denied:true):m,
    scope:scope,currentRoute:'/app/people',mode:mode,pinned:false,labels:labels,onNavigate:routes.add))));await tester.pumpAndSettle();
  }
  await mount(mode:'rail');final tab=find.byKey(const ValueKey('workspace-navigation-tab-work'));await tester.tap(tab);await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);await tester.pumpAndSettle();expect(find.text('Report'),findsOneWidget);expect(find.text('Home'),findsNothing);
  await mount(mode:'folded');await tester.tap(find.byTooltip('Pin navigation'));await tester.pumpAndSettle();expect(find.byTooltip('Unpin navigation'),findsOneWidget);
  await mount(width:390);await tester.tap(find.byTooltip('Open navigation'));await tester.pumpAndSettle();await tester.tap(find.byKey(const ValueKey('workspace-navigation-work')));await tester.pumpAndSettle();expect(find.text('Home'),findsOneWidget);
  await mount(width:390,scope:'other',denied:true);expect(find.text('Home'),findsNothing);expect(routes,isEmpty);expect(tester.takeException(),isNull);
 });
}
