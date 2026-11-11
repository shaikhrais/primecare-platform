import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main(){
 test('PrimeCard forwards the reviewed Material Card fields',(){
  const child=PrimeText('Card');const shape=StadiumBorder();
  const card=PrimeCard(key:Key('shared-card'),color:Color(0xff112233),shadowColor:Color(0xff223344),surfaceTintColor:Color(0xff334455),elevation:4,shape:shape,borderOnForeground:false,margin:EdgeInsets.all(7),clipBehavior:Clip.antiAlias,semanticContainer:false,child:child);
  expect(card,isA<Card>());expect(card.key,const Key('shared-card'));expect(card.color,const Color(0xff112233));expect(card.shadowColor,const Color(0xff223344));expect(card.surfaceTintColor,const Color(0xff334455));expect(card.elevation,4);expect(card.shape,same(shape));expect(card.borderOnForeground,isFalse);expect(card.margin,const EdgeInsets.all(7));expect(card.clipBehavior,Clip.antiAlias);expect(card.semanticContainer,isFalse);expect(card.child,same(child));
  const defaults=PrimeCard();expect(defaults.borderOnForeground,isTrue);expect(defaults.clipBehavior,Clip.none);expect(defaults.semanticContainer,isTrue);
 });
 testWidgets('PrimeCard inherits the active CardTheme', (tester) async {
  const themed=Color(0xff335577);await tester.pumpWidget(MaterialApp(theme:ThemeData(cardTheme:const CardThemeData(color:themed,elevation:9)),home:const Scaffold(body:PrimeCard(child:PrimeText('Themed card')))));
  final material=tester.widgetList<Material>(find.byType(Material)).where((widget)=>widget.color==themed&&widget.elevation==9);expect(material,isNotEmpty);expect(find.text('Themed card'),findsOneWidget);
 });
}
