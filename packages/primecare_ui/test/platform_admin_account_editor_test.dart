import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
void main(){
 WidgetController.hitTestWarningShouldBeFatal=true;
 tearDown(()=>applicationLanguage.selectLanguage(SupportedLanguage.en));
 for(final language in SupportedLanguage.values){
 testWidgets('Selected tenant editor preserves drafts on mobile/4K in ${language.name}',(tester) async {
  tester.view.physicalSize=const Size(320,640);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  var mutations=0;
  Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
   if(method!='GET')mutations++;
   final uri=Uri.parse(path),tenant=uri.queryParameters['tenantId'];
   if(uri.path.endsWith('monitor'))return {'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'categories':['services'],'assignableRoles':['client','rn']};
   final rows=<Map<String,dynamic>>[if(uri.path.endsWith('tenants')){'id':'tenant','name':'Organization','slug':'organization','status':'active'},if(uri.path.endsWith('accounts')){'id':'user','email':'user@example.invalid','role':'client','status':'active'}];
   return {'items':rows,'total':rows.length,'offset':0,'limit':25,if(uri.path.endsWith('accounts'))...{'search':uri.queryParameters['search']??'','status':uri.queryParameters['status']??'','active':1,'tenantId':tenant},if(uri.path.endsWith('masters'))...{'tenantId':tenant,'category':'services'}};
  }
  applicationLanguage.selectLanguage(language);final strings=AppStrings(language.name);
  await tester.pumpWidget(MaterialApp(locale:Locale(language.name),supportedLocales:AppStrings.locales,localizationsDelegates:AppStrings.delegates,builder:(context,child)=>MediaQuery(data:MediaQuery.of(context).copyWith(textScaler:TextScaler.linear(2)),child:child!),home:PlatformAdminScreen(request:request)));await tester.pumpAndSettle();
  Future<void> tap(Finder finder) async {if(finder.evaluate().isEmpty){await tester.scrollUntilVisible(finder,150,scrollable:find.descendant(of:find.byType(ListView),matching:find.byType(Scrollable)).first);}await tester.ensureVisible(finder);await tester.pumpAndSettle();await tester.tap(finder);await tester.pumpAndSettle();}
  await tap(find.widgetWithText(TextButton,strings.text('control.tenants')));
  await tap(find.widgetWithText(TextButton,strings.text('control.manageTenant')));
  await tap(find.byTooltip(strings.text('admin.editAccount',{'email':'user@example.invalid'})));
  expect(find.byType(AlertDialog),findsOneWidget);expect(find.byType(TextFormField),findsOneWidget);expect(tester.takeException(),isNull);
  await tester.enterText(find.byType(TextFormField),'draft@example.invalid');tester.view.physicalSize=const Size(3840,2160);await tester.pumpAndSettle();
  expect(find.text('draft@example.invalid'),findsOneWidget);expect(tester.takeException(),isNull);
  await tap(find.widgetWithText(TextButton,strings.text('cancel')));expect(mutations,0);
 });
 }
}
