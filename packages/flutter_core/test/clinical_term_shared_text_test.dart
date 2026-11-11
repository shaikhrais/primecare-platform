import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/widgets/clinical_term_highlighter.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('actual highlighter retains shared text during loading, empty and rich states', (tester) async {
    const text='Read Cardiology reference';
    final pending=Completer<List<String>>();
    await tester.pumpWidget(ProviderScope(key:const Key('loading'),overrides:[
      clinicalArticleTitlesProvider.overrideWith((ref)=>pending.future),
    ],child:const MaterialApp(home:Scaffold(body:ClinicalTermHighlighter(text:text)))));
    expect(find.byType(PrimeText),findsOneWidget);
    expect(find.text(text),findsOneWidget);
    pending.complete([]);await tester.pumpAndSettle();
    expect(find.byType(PrimeText),findsOneWidget);
    await tester.pumpWidget(ProviderScope(key:const Key('rich'),overrides:[
      clinicalArticleTitlesProvider.overrideWith((ref)async=>['Cardiology']),
    ],child:const MaterialApp(home:Scaffold(body:ClinicalTermHighlighter(text:text)))));
    await tester.pumpAndSettle();
    expect(find.byType(PrimeRichText),findsOneWidget);
    final shared=tester.widget<PrimeRichText>(find.byType(PrimeRichText));
    expect(shared.text.toPlainText(),text);
    final children=(shared.text as TextSpan).children!.whereType<TextSpan>().toList();
    final link=children.singleWhere((span)=>span.text=='Cardiology');
    expect(link.recognizer,isNotNull);expect(link.style!.decoration,TextDecoration.underline);
    expect(tester.takeException(),isNull);
  });
}
