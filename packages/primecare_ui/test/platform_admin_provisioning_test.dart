import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
void main(){
 tearDown(()=>applicationLanguage.selectLanguage(SupportedLanguage.en));
 for(final language in SupportedLanguage.values){
 testWidgets('Tenant and localized reference provisioning in ${language.name}',(tester) async {
  tester.view.physicalSize=const Size(1200,1400);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
  final calls=<Map<String,dynamic>>[];Map<String,dynamic>? tenant,record;
  Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
   final uri=Uri.parse(path);
   if(method=='POST'){
    calls.add({'path':uri.path,...body!});
    if(uri.path.endsWith('tenants')){tenant={'id':'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',...body,'status':'active'};return {'tenant':tenant};}
    if(uri.path.endsWith('masters')){record={'id':'record',...body};return {'record':record};}
   }
   if(uri.path.endsWith('monitor'))return {'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'categories':['services'],'assignableRoles':['client']};
   return {'items':[if(uri.path.endsWith('tenants')&&tenant!=null)tenant,if(uri.path.endsWith('masters')&&record!=null)record],'total':uri.path.endsWith('tenants')&&tenant!=null||uri.path.endsWith('masters')&&record!=null?1:0,'offset':0,'limit':25,if(uri.path.endsWith('accounts'))...{'search':uri.queryParameters['search']??'','status':uri.queryParameters['status']??'','active':0,'tenantId':uri.queryParameters['tenantId']},if(uri.path.endsWith('masters'))...{'category':'services','tenantId':uri.queryParameters['tenantId']}};
  }
  applicationLanguage.selectLanguage(language);final strings=AppStrings(language.name);
  await tester.pumpWidget(MaterialApp(locale:Locale(language.name),supportedLocales:AppStrings.locales,localizationsDelegates:AppStrings.delegates,home:PlatformAdminScreen(request:request)));await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(TextButton,strings.text('control.tenants')));await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton,strings.text('control.createTenant')));await tester.pumpAndSettle();
  await tester.enterText(find.widgetWithText(TextFormField,strings.text('control.field.name')),'New organization');await tester.enterText(find.widgetWithText(TextFormField,strings.text('control.field.slug')),'new-organization');
  await tester.tap(find.widgetWithText(FilledButton,strings.text('control.save')));await tester.pumpAndSettle();expect(find.text('New organization'),findsOneWidget);
  await tester.tap(find.widgetWithText(TextButton,strings.text('control.masters')));await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton,strings.text('control.createMaster')));await tester.pumpAndSettle();
  for(final entry in {'code':'care','en':'Care','es':'Cuidado','fr':'Soins'}.entries){await tester.enterText(find.widgetWithText(TextFormField,strings.text('control.field.${entry.key}')),entry.value);}
  await tester.tap(find.widgetWithText(FilledButton,strings.text('control.save')));await tester.pumpAndSettle();
  expect(calls.last['tenantId'],tenant!['id']);expect(calls.last['labels'],{'en':'Care','es':'Cuidado','fr':'Soins'});expect(find.text({'en':'Care','es':'Cuidado','fr':'Soins'}[language.name]!),findsOneWidget);expect(tester.takeException(),isNull);
 });
 }
}
