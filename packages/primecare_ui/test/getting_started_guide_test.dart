import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/platform/platform_master_screen.dart';
import 'package:primecare_ui/src/features/training/getting_started_guide.dart';
void main(){
 testWidgets('guide explains organization and advances without domain mutations',(tester)async{
  await tester.pumpWidget(ProviderScope(overrides:[platformAdministrationAccessProvider.overrideWith((ref)async=>false)],child:const MaterialApp(home:GettingStartedGuide())));
  await tester.pumpAndSettle();expect(find.text('Welcome to your workspace'),findsOneWidget);
  await tester.ensureVisible(find.text('Next step'));await tester.tap(find.text('Next step'));await tester.pumpAndSettle();
  expect(find.text('Organization and tenants'),findsOneWidget);expect(find.text('Open dashboard'),findsNothing);
  await tester.ensureVisible(find.text('Back'));await tester.tap(find.text('Back'));await tester.pumpAndSettle();expect(find.text('Welcome to your workspace'),findsOneWidget);
 });
}
