import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  testWidgets('content grid retains complete scaled labels at narrow and wide widths', (tester) async {
    tester.view.physicalSize = const Size(1800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    for (final width in [320.0, 600.0, 1600.0]) {
      for (final scale in [1.0, 2.0, 3.0]) {
        await tester.pumpWidget(MaterialApp(home:Scaffold(body:MediaQuery(
          data:MediaQueryData(textScaler:TextScaler.linear(scale)),
          child:SingleChildScrollView(child:SizedBox(width:width,child:PrimeContentGrid(
            maxCrossAxisExtent:400,spacing:24,runSpacing:24,
            children:[for(var i=0;i<8;i++) Padding(padding:const EdgeInsets.all(24),
              child:Column(mainAxisSize:MainAxisSize.min,children:[
                PrimeText('Long accessible title for card $i',style:const TextStyle(fontSize:24)),
                PrimeText('Complete content remains visible at enlarged text sizes, card $i.'),
              ])),
            ],
          ))),
        ))));
        for(var i=0;i<8;i++)expect(find.text('Long accessible title for card $i'),findsOneWidget);
        expect(tester.takeException(),isNull,reason:'$width/$scale');
        final wrap=tester.renderObject<RenderBox>(find.byType(Wrap));
        expect(wrap.size.width,lessThanOrEqualTo(width));
      }
    }
  });
}
