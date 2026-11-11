import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('icon action preserves compact geometry, disabled style and tooltip', (tester) async {
    for (final brightness in Brightness.values) {
      for (final enabled in [true, false]) {
        var taps=0;
        final VoidCallback? action=enabled ? () { taps++; } : null;
        final theme=ThemeData(brightness:brightness);
        await tester.pumpWidget(MaterialApp(theme:theme,home:Scaffold(body:Column(children:[
          IconButton(key:const Key('original'),icon:const Icon(Icons.close,size:16),
            onPressed:action,tooltip:'Close',visualDensity:VisualDensity.compact,
            padding:EdgeInsets.zero,constraints:const BoxConstraints()),
          PrimeIconButton(key:const Key('shared'),icon:const PrimeIcon(Icons.close,size:16),
            onPressed:action,tooltip:'Close',visualDensity:VisualDensity.compact,
            padding:EdgeInsets.zero,constraints:const BoxConstraints()),
        ]))));
        final original=find.byKey(const Key('original'));
        final shared=find.byKey(const Key('shared'));
        expect(tester.getSize(shared),tester.getSize(original));
        final delegate=tester.widget<IconButton>(find.descendant(of:shared,matching:find.byType(IconButton)));
        expect(delegate.tooltip,'Close');
        expect(delegate.visualDensity,VisualDensity.compact);
        expect(delegate.padding,EdgeInsets.zero);
        expect(delegate.constraints,const BoxConstraints());
        RichText rendered(Finder root)=>tester.widget<RichText>(find.descendant(of:root,matching:find.byType(RichText)));
        expect(rendered(shared).text.style,rendered(original).text.style);
        await tester.tap(shared);await tester.pumpAndSettle();
        expect(taps,enabled ? 1 : 0);
        expect(tester.takeException(),isNull);
      }
    }
  });

  testWidgets('shared icon action forwards focus identity and autofocus', (tester) async {
    final focus=FocusNode();addTearDown(focus.dispose);
    await tester.pumpWidget(MaterialApp(home:Scaffold(body:PrimeIconButton(
      icon:const PrimeIcon(Icons.menu),onPressed:(){},focusNode:focus,
      autofocus:true,tooltip:'Open navigation'))));
    await tester.pumpAndSettle();
    final delegate=tester.widget<IconButton>(find.byType(IconButton));
    expect(delegate.focusNode,same(focus));expect(delegate.autofocus,isTrue);
    expect(focus.hasFocus,isTrue);expect(tester.takeException(),isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('text semantics label is preserved without changing visible text', (tester) async {
    final semantics=tester.ensureSemantics();
    await tester.pumpWidget(const MaterialApp(home:Scaffold(body:PrimeText('5',
      semanticsLabel:'Tuesday, November fifth',textAlign:TextAlign.end))));
    expect(find.text('5'),findsOneWidget);
    expect(find.bySemanticsLabel('Tuesday, November fifth'),findsOneWidget);
    final delegate=tester.widget<Text>(find.byType(Text));
    expect(delegate.semanticsLabel,'Tuesday, November fifth');
    expect(delegate.textAlign,TextAlign.end);
    semantics.dispose();
  });

  testWidgets('rich text retains exact caller spans and recognizer callbacks', (tester) async {
    var taps=0;
    final recognizer=TapGestureRecognizer()..onTap=(){taps++;};
    addTearDown(recognizer.dispose);
    final span=TextSpan(children:[const TextSpan(text:'Read '),
      TextSpan(text:'clinical reference',recognizer:recognizer,
        style:const TextStyle(decoration:TextDecoration.underline))]);
    await tester.pumpWidget(MaterialApp(home:Scaffold(body:MediaQuery(
      data:const MediaQueryData(textScaler:TextScaler.linear(1.5)),
      child:DefaultTextStyle(style:const TextStyle(color:Colors.cyan,fontSize:18),
        child:PrimeRichText(text:span,textAlign:TextAlign.center))))));
    final delegate=tester.widget<RichText>(find.byType(RichText));
    final inherited=delegate.text as TextSpan;
    expect(inherited.children!.single,same(span));
    expect(inherited.style!.color,Colors.cyan);
    expect(inherited.style!.fontSize,18);
    expect(delegate.textScaler.scale(18),27);
    expect(delegate.textAlign,TextAlign.center);
    expect(span.children![1],isA<TextSpan>());
    // The same recognizer receives actual pointer input through the shared view.
    await tester.tap(find.byType(PrimeRichText));await tester.pump();
    expect(taps,1);expect(tester.takeException(),isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
