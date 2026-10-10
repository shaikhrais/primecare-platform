import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  final data=jsonDecode(File('../contracts/admin-tasks.json').readAsStringSync()) as Map<String,dynamic>;
  final tasks=(data['tasks'] as List<dynamic>).map((row)=>AdminTask.fromJson(Map<String,dynamic>.from(row as Map))).toList();
  tearDown(()=>applicationLanguage.selectLanguage(SupportedLanguage.en));
  for(final language in SupportedLanguage.values) {
    testWidgets('Inherited task overview describes every task in ${language.name}', (tester) async {
      tester.view.physicalSize=const Size(1200,2400);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      applicationLanguage.selectLanguage(language);final strings=AppStrings(language.name);
      await tester.pumpWidget(MaterialApp(locale:Locale(language.name),supportedLocales:AppStrings.locales,localizationsDelegates:AppStrings.delegates,home:AdminTasksScreen(tasks:tasks)));await tester.pumpAndSettle();
      expect(find.text(strings.text('admin.tasks')),findsOneWidget);
      for(final task in tasks){expect(find.text(strings.text(task.titleKey)),findsOneWidget);expect(find.text(strings.text(task.descriptionKey)),findsOneWidget);}
    });
  }
  testWidgets('Unsupported task translations show a localized error without crashing', (tester) async {
    await tester.pumpWidget(const MaterialApp(home:AdminTasksScreen(tasks:[AdminTask(id:'future',titleKey:'task.future.title',descriptionKey:'task.future.description',operation:'workspace.read')])));await tester.pumpAndSettle();
    expect(find.text(const AppStrings('en').text('error.invalidResponse')),findsOneWidget);expect(tester.takeException(),isNull);
  });
}
