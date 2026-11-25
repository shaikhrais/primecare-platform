import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextButton;
import 'package:primecare_layout/primecare_layout.dart';
import 'package:primecare_navigation/primecare_navigation.dart';

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
 testWidgets('horizontal direct links support keyboard entry and revoke old scope callbacks',(tester)async{
  tester.view.physicalSize=const Size(1500,960);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final m=WorkspaceNavigationModel.fromJson([{'id':'first','kind':'item','label':'First','route':'/first'},{'id':'second','kind':'item','label':'Second','route':'/second'},{'id':'disabled','kind':'item','label':'Disabled','route':'/disabled','disabled':true}],allowedIds:['first','second','disabled'],allowedRoutes:['/first','/second','/disabled'],registeredIcons:[]);
  final routes=<String>[];
  Future<void> mount(TextDirection dir,String scope)async{await tester.pumpWidget(MaterialApp(home:Directionality(textDirection:dir,child:Scaffold(body:PrimeWorkspaceNavigation(model:m,scope:scope,currentRoute:'/second',family:'horizontal-header',labels:labels,onNavigate:routes.add)))));await tester.pumpAndSettle();}
  for(final dir in [TextDirection.ltr,TextDirection.rtl]){
   await mount(dir,'actor');tester.widget<Focus>(find.byKey(const ValueKey('workspace-navigation-menu-entry'))).focusNode!.requestFocus();await tester.pumpAndSettle();await tester.sendKeyEvent(LogicalKeyboardKey.enter);await tester.pumpAndSettle();
   expect(tester.widget<PrimeTextButton>(find.byKey(const ValueKey('workspace-navigation-first'))).focusNode!.hasFocus,true);
   await tester.sendKeyEvent(dir==TextDirection.rtl?LogicalKeyboardKey.arrowLeft:LogicalKeyboardKey.arrowRight);await tester.pumpAndSettle();
   final second=tester.widget<PrimeTextButton>(find.byKey(const ValueKey('workspace-navigation-second')));expect(second.focusNode!.hasFocus,true);await tester.sendKeyEvent(LogicalKeyboardKey.enter);await tester.pumpAndSettle();expect(routes.last,'/second');
   final before=routes.length,old=second.onPressed!;await mount(dir,'other');old();expect(routes.length,before);expect(tester.takeException(),isNull);
  }
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
