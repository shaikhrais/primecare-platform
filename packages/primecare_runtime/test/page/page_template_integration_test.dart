import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/workspace.dart';
import 'package:primecare_page_templates/primecare_page_templates.dart' show PageChrome;

void main(){
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
