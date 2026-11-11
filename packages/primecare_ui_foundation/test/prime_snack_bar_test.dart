import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  test('PrimeSnackBar preserves Material defaults and forwarded fields', () {
    final focus = AnimationController(vsync: const TestVSync());
    addTearDown(focus.dispose);
    var visible=false;
    final action=SnackBarAction(label:'Retry',onPressed:(){});
    final snack=PrimeSnackBar(
      key:const Key('shared-snack'),content:const PrimeText('Saved'),
      elevation:3,margin:const EdgeInsets.all(8),padding:const EdgeInsets.all(9),
      shape:const StadiumBorder(),hitTestBehavior:HitTestBehavior.opaque,
      behavior:SnackBarBehavior.floating,action:action,actionOverflowThreshold:.7,
      showCloseIcon:true,duration:const Duration(seconds:7),persist:true,
      animation:focus,onVisible:(){visible=true;},dismissDirection:DismissDirection.horizontal,
      clipBehavior:Clip.antiAlias,
    );
    expect(snack,isA<SnackBar>());expect(snack.key,const Key('shared-snack'));
    expect(snack.content,isA<PrimeText>());expect(snack.elevation,3);expect(snack.margin,const EdgeInsets.all(8));
    expect(snack.padding,const EdgeInsets.all(9));expect(snack.shape,isA<StadiumBorder>());
    expect(snack.hitTestBehavior,HitTestBehavior.opaque);expect(snack.behavior,SnackBarBehavior.floating);
    expect(snack.action,same(action));expect(snack.actionOverflowThreshold,.7);expect(snack.showCloseIcon,isTrue);
    expect(snack.duration,const Duration(seconds:7));expect(snack.persist,isTrue);expect(snack.animation,same(focus));
    snack.onVisible!();expect(visible,isTrue);expect(snack.dismissDirection,DismissDirection.horizontal);
    expect(snack.clipBehavior,Clip.antiAlias);
    const defaults=PrimeSnackBar(content:PrimeText('Default'));
    expect(defaults.duration,const Duration(milliseconds:4000));expect(defaults.persist,isFalse);
    expect(defaults.clipBehavior,Clip.hardEdge);
  });

  testWidgets('PrimeSnackBar inherits the active SnackBarTheme', (tester) async {
    const themed=Color(0xff335577);
    await tester.pumpWidget(MaterialApp(theme:ThemeData(snackBarTheme:const SnackBarThemeData(backgroundColor:themed)),home:Builder(builder:(context)=>Scaffold(body:TextButton(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const PrimeSnackBar(content:PrimeText('Themed'))),child:const Text('Show'))))));
    await tester.tap(find.text('Show'));await tester.pump();
    final material=tester.widgetList<Material>(find.byType(Material)).where((widget)=>widget.color==themed);
    expect(material,isNotEmpty);expect(find.text('Themed'),findsOneWidget);
  });
}
