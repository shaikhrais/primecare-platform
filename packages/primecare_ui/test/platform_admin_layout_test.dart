import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
 final uri=Uri.parse(path);
 if(uri.path.endsWith('monitor'))return {'sampledAt':'2026-10-11T00:00:00Z',for(final key in AdminPlatformSnapshot.metrics)key:0,'categories':['services'],'assignableRoles':['client']};
 return {'items':<Map<String,dynamic>>[],'total':0,'offset':0,'limit':25,if(uri.path.endsWith('masters'))...{'category':'services','tenantId':null}};
}
void main(){
 tearDown(()=>applicationLanguage.selectLanguage(SupportedLanguage.en));
 for(final language in SupportedLanguage.values){
  for(final width in [320.0,600.0,1024.0,1920.0,3840.0]){
   testWidgets('Platform sections fit ${language.name} at $width',(tester) async {
    tester.view.physicalSize=Size(width,900);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    applicationLanguage.selectLanguage(language);final strings=AppStrings(language.name);
    await tester.pumpWidget(MaterialApp(locale:Locale(language.name),supportedLocales:AppStrings.locales,localizationsDelegates:AppStrings.delegates,home:PlatformAdminScreen(request:request)));await tester.pumpAndSettle();expect(tester.takeException(),isNull);
    for(final key in ['control.tenants','control.accounts','control.masters','control.audit','control.monitor']){
     final button=find.widgetWithText(TextButton,strings.text(key));await tester.ensureVisible(button);await tester.tap(button);await tester.pumpAndSettle();expect(tester.takeException(),isNull);
    }
   });
  }
 }
}
