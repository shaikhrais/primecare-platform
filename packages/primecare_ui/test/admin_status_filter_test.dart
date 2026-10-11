import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  tearDown(()=>applicationLanguage.selectLanguage(SupportedLanguage.en));
  for(final language in SupportedLanguage.values) {
    testWidgets('Inherited status filter uses localized labels and canonical values in ${language.name}', (tester) async {
      tester.view.physicalSize=const Size(1200,1200);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      applicationLanguage.selectLanguage(language);final strings=AppStrings(language.name);final paths=<String>[];
      Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async {
        paths.add(path);final uri=Uri.parse(path);
        return {'organization':{'name':'Organization'},'users':<Map<String,dynamic>>[],'assignableRoles':['client'],'total':0,'active':0,'offset':0,'limit':25,'search':uri.queryParameters['search']??'','status':uri.queryParameters['status']??''};
      }
      await tester.pumpWidget(MaterialApp(locale:Locale(language.name),supportedLocales:AppStrings.locales,localizationsDelegates:AppStrings.delegates,home:AdminScreen(request:request)));await tester.pumpAndSettle();
      expect(find.text(strings.text('admin.statusFilter')),findsOneWidget);
      await tester.tap(find.byType(DropdownButtonFormField<String>));await tester.pumpAndSettle();
      await tester.tap(find.text(strings.text('inactive')).last);await tester.pumpAndSettle();
      expect(Uri.parse(paths.last).queryParameters['status'],'inactive');
      await tester.tap(find.byType(DropdownButtonFormField<String>));await tester.pumpAndSettle();
      await tester.tap(find.text(strings.text('admin.allStatuses')).last);await tester.pumpAndSettle();
      expect(Uri.parse(paths.last).queryParameters.containsKey('status'),false);
    });
  }
}
