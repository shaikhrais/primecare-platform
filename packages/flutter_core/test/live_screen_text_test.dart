import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';

void main() {
  testWidgets('remote edits rebuild text while controllers retain user drafts; failures keep last text', (tester) async {
    int version=0;bool unavailable=false;
    final client=MockClient((request) async {
      if(unavailable)return http.Response('Unavailable',503);
      if(request.url.path.endsWith('/screen-text'))return http.Response(jsonEncode({'screens':[{'id':'fixture','version':version}]}),200);
      return http.Response(jsonEncode({'screen':'fixture','version':version,'locales':{
        for(final locale in ['en','fr','es'])locale:{'title':'Title $version','message':'{name} saved'}
      }}),200);
    });
    final store=LiveScreenTextStore(client:client,baseUrl:'https://test');addTearDown(store.dispose);
    final controller=TextEditingController();addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(home:LiveScreenTextScope(store:store,child:Builder(builder:(context)=>Scaffold(body:Column(children:[
      Text(liveScreenText(context,'fixture','en','title','Bundled')),
      Text(liveScreenText(context,'fixture','fr','message','{name}',args:{'name':'{name} literal'})),
      TextField(controller:controller),
    ]))))));
    await tester.pumpAndSettle();await store.refresh();await tester.pump();
    expect(find.text('Title 0'),findsOneWidget);
    expect(find.text('{name} literal saved'),findsOneWidget);
    await tester.enterText(find.byType(TextField),'Unsaved draft');
    version=1;await store.refresh();await tester.pump();expect(find.text('Title 1'),findsOneWidget);expect(controller.text,'Unsaved draft');
    unavailable=true;await store.refresh();await tester.pump();expect(find.text('Title 1'),findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
