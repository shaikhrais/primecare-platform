import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/src/localization/live_screen_text.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));
  test('download persists across restart without automatic network access', () async {
    int requests = 0;
    int version = 0;
    bool offline = false;
    http.Client client() => MockClient((request) async {
      requests++;
      if (offline) throw Exception('offline');
      if (request.url.path.endsWith('/screen-text')) return http.Response(jsonEncode({'screens':[{'id':'fixture','version':version}]}),200);
      return http.Response(jsonEncode({'screen':'fixture','version':version,'locales':{
        for(final language in ['en','fr','es'])language:{'title':'Downloaded $version $language'}
      }}),200);
    });
    final first = LiveScreenTextStore(client:client(),baseUrl:'https://cached');
    await first.initialize();
    expect(requests,2);
    await first.saveLocal('fixture',{for(final language in ['en','fr','es'])language:{'title':'Local $language'}});
    expect(requests,2);
    expect(first.localHistory('fixture').length,1);
    first.dispose();
    offline = true;
    requests = 0;
    final restarted = LiveScreenTextStore(client:client(),baseUrl:'https://cached');
    addTearDown(restarted.dispose);
    await restarted.initialize();
    expect(requests,0);
    expect(restarted.localHistory('fixture').length,1);
    expect(restarted.text('fixture','fr','title'),'Local fr');
    await restarted.refresh();
    expect(restarted.text('fixture','fr','title'),'Local fr');
    offline = false;
    version = 1;
    await restarted.refresh();
    expect(restarted.text('fixture','es','title'),'Downloaded 1 es');
    final other = LiveScreenTextStore(client:client(),baseUrl:'https://other');
    addTearDown(other.dispose);
    offline = true;
    await other.initialize();
    expect(other.text('fixture','en','title'),isNull);
  });
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
