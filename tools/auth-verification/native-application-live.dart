// Explicit owned-production widget proof, copied to the UI package by its harness.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/application_modules.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_screen.dart';
import 'package:primecare_ui/src/features/tenant_applications/tenant_application_catalog.g.dart';
import 'package:primecare_ui/src/screens/screen_manager_catalog.dart';

class LiveAuth extends AuthNotifier {
  final Map<String,dynamic> actor;
  LiveAuth(this.actor);
  @override AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,
    userId:actor['id'] as String,tenantId:actor['tenant'] as String,role:'tenant_admin',token:actor['token'] as String);
  void logoutFixture(){state=AuthState(isInitialized:true);}
}
class _NetworkResult {
  final http.StreamedResponse? response;
  final Object? error;
  final StackTrace? stack;
  const _NetworkResult(this.response,this.error,this.stack);
}
class Wire extends http.BaseClient {
  final http.Client delegate;
  final List<Map<String,dynamic>> requests,events;
  final Zone networkZone;
  Wire(this.delegate,this.requests,this.events,this.networkZone);
  @override Future<http.StreamedResponse> send(http.BaseRequest request)async{
    if(request is http.Request && request.url.path=='/v1/user/preferences'){
      final body=Map<String,dynamic>.from(jsonDecode(request.body) as Map);
      // Never record headers, tokens or credentials.
      requests.add({'action':body['action'],'requestId':body['requestId'],'revision':body['revision'],'document':body['document']});
    }
    events.add({'path':request.url.path,'phase':'send'});
    // A value may cross the runner's error zones; an error Future may not.
    // Re-throw in the caller's zone so the real port owns cancellation cleanup.
    final result=await networkZone.run<Future<_NetworkResult>>(()async{
      try{final response=await delegate.send(request);events.add({'path':request.url.path,'status':response.statusCode,'length':response.contentLength});return _NetworkResult(response,null,null);}
      catch(error,stack){events.add({'path':request.url.path,'errorType':error.runtimeType.toString()});return _NetworkResult(null,error,stack);}
    });
    if(result.error!=null)Error.throwWithStackTrace(result.error!,result.stack!);
    return result.response!;
  }
  @override void close()=>delegate.close();
}
Future<void> until(WidgetTester tester,bool Function() ready,String phase,List<Map<String,dynamic>> events)async{
  await tester.runAsync(()async{
    final deadline=DateTime.now().add(const Duration(seconds:40));
    while(!ready()&&DateTime.now().isBefore(deadline)){
      await Future<void>.delayed(const Duration(milliseconds:100));await tester.pump();
    }
  });
  await tester.pump();if(!ready())print('PC10_NATIVE_WIRE '+jsonEncode({'phase':phase,'events':events,'pickerPresent':find.byType(PrimeApplicationShortcuts).evaluate().isNotEmpty}));
  expect(ready(),true,reason:'Owned native UI phase did not finish');
}
void main(){
  final fixturePath=Platform.environment['PC10_NATIVE_FIXTURE'];
  if(Platform.environment['PC10_OWNED_NATIVE_TEST']!='1'||fixturePath==null)throw StateError('Explicit owned production fixture required');
  final actors=(jsonDecode(File(fixturePath).readAsStringSync()) as List).map((e)=>Map<String,dynamic>.from(e as Map)).toList();
  if(actors.length!=3)throw StateError('Exact owned fixture count required');
  // Create actual IO transports before the widget binding installs its no-network
  // default. Only this explicitly opted-in production proof uses real networking.
  HttpOverrides.global=null;
  final networkZone=Zone.current;
  final clients=List.generate(18,(_)=>IOClient(HttpClient()));
  final available=[...clients];
  final results=<Map<String,dynamic>>[];
  tearDownAll((){for(final client in clients){client.close();}});
  for(final actor in actors){
    final locale=actor['locale'] as String,width=(actor['width'] as num).toDouble();
    testWidgets('owned native $locale live API save reload and retirement',(tester)async{
      SharedPreferences.setMockInitialValues({});
      await tester.binding.setSurfaceSize(Size(width,1800));addTearDown(()=>tester.binding.setSurfaceSize(null));
      final requests=<Map<String,dynamic>>[],events=<Map<String,dynamic>>[];
      final container=ProviderContainer(overrides:[authProvider.overrideWith(()=>LiveAuth(actor)),
        nativeApplicationClientProvider.overrideWithValue(()=>Wire(available.removeAt(0),requests,events,networkZone))]);
      addTearDown(container.dispose);
      Future<void> mount()async{
        await tester.pumpWidget(UncontrolledProviderScope(container:container,child:PrimeTheme(data:const PrimeThemeData(),
          child:MaterialApp(locale:Locale(locale),supportedLocales:const[Locale('en'),Locale('fr'),Locale('es')],
            localizationsDelegates:GlobalMaterialLocalizations.delegates,
            home:managedPrimeCarePage(nativeTenantApplicationRoute,(_)=>const TenantApplicationScreen())))));
        await until(tester,(){
          final picker=find.byType(PrimeApplicationShortcuts),choice=find.widgetWithText(TextButton,'Platform Administration');
          return picker.evaluate().isNotEmpty && choice.evaluate().length==1 &&
            tester.widget<PrimeApplicationShortcuts>(picker).editor.current['loaded']==true &&
            tester.widget<TextButton>(choice).onPressed!=null;
        },'mount-controls-enabled',events);
      }
      await mount();
      expect(requests.where((r)=>r['action']!='read'),isEmpty);
      await until(tester,()=>find.text(actor['id'] as String).evaluate().isNotEmpty,'profile',events);
      final choice=find.widgetWithText(TextButton,'Platform Administration');
      await tester.ensureVisible(choice);await tester.tap(choice);await tester.pump();
      final save=find.widgetWithText(TextButton,nativeApplicationShell['locales'][locale]['save'] as String);
      await until(tester,()=>save.evaluate().length==1&&tester.widget<TextButton>(save).onPressed!=null,'save-enabled',events);
      await tester.ensureVisible(save);await tester.tap(save);await tester.pump();
      await until(tester,(){
        final state=tester.widget<PrimeApplicationShortcuts>(find.byType(PrimeApplicationShortcuts)).editor.current;
        return state['status']=='clean'&&state['dirty']==false&&(state['base'] as Map)['revision']==1&&requests.where((r)=>r['action']=='read').length>=2;
      },'save',events);
      final written=requests.where((r)=>r['action']!='read').toList();
      expect(written.length,1);expect(written.single['document'],{'version':1,'screenIds':['2534','1269']});
      await tester.pumpWidget(const SizedBox());await tester.pump();
      await mount();
      final state=tester.widget<PrimeApplicationShortcuts>(find.byType(PrimeApplicationShortcuts)).editor.current;
      expect(state['selected'],['2534','1269']);expect(requests.where((r)=>r['action']!='read').length,1);
      (container.read(authProvider.notifier) as LiveAuth).logoutFixture();await tester.pump();
      expect(find.byType(PrimeApplicationShortcuts),findsNothing);expect(find.text(actor['id'] as String),findsNothing);
      expect(tester.takeException(),isNull);
      results.add({'locale':locale,'width':width,'userId':actor['id'],'tenantId':actor['tenant'],
        'profileRead':true,'saveReadback':true,'reloadWithoutReplay':true,'sessionRetired':true,'writes':1,'passed':true});
      final report=File('../../test-results/pc10-native/dart-owned.json');report.parent.createSync(recursive:true);
      report.writeAsStringSync(jsonEncode({'scope':'native-widget-real-production-API','cachePlatform':'SharedPreferences test platform; widget restart only','physicalDeviceTested':false,'humanReviewApproved':false,'results':results}));
      await tester.pumpWidget(const SizedBox());
    });
  }
}
