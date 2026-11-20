import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main(){
  testWidgets('compact radios and switches retain label and keyboard input',(tester)async{
    var selected='a',enabled=false;final focus=FocusNode();addTearDown(focus.dispose);
    await tester.pumpWidget(MaterialApp(home:Scaffold(body:StatefulBuilder(builder:(context,setState)=>Column(children:[
      RadioGroup<String>(groupValue:selected,onChanged:(value)=>setState(()=>selected=value!),child:Column(children:[
        PrimeSettingsRadio(value:'a',label:const Text('Left'),onSelected:()=>setState(()=>selected='a')),
        PrimeSettingsRadio(value:'b',label:const Text('Right'),onSelected:()=>setState(()=>selected='b')),
      ])),
      PrimeSettingsSwitch(label:'Display',focusNode:focus,value:enabled,onChanged:(value)=>setState(()=>enabled=value)),
    ])))));
    await tester.tap(find.text('Right'));await tester.pump();expect(selected,'b');
    focus.requestFocus();await tester.pump();await tester.sendKeyEvent(LogicalKeyboardKey.space);await tester.pump();expect(enabled,isTrue);
    await tester.tap(find.byType(Switch));await tester.pump();expect(enabled,isFalse);expect(tester.takeException(),isNull);
  });
}
