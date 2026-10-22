import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/src/application/controllers/privileged_access_service.dart';
import 'package:primecare_ui/src/features/auth/auth_elevation_controller.dart';
import 'package:primecare_ui/src/features/auth/auth_elevation_form.dart';
import 'package:primecare_ui/src/features/auth/tenant_support_form.dart';
import 'package:primecare_ui/src/features/auth/auth_elevation_catalog.g.dart';
import 'auth_design_test.dart' show localized;
String id(int n)=>'${n.toString().padLeft(8,'0')}-1111-4111-8111-111111111111';
class SupportPresentationAuth extends AuthNotifier {
 @override
 AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,userId:id(1),role:'code_admin',token:List.filled(43,'a').join(),tenantId:id(11));
}
class SupportPresentationService extends Fake implements PrivilegedAccessService {
 bool elevatedActor=true,approvingActor=false,approved=false,revoked=false;
 int lists=0;
 Duration lifetime=const Duration(minutes:10);
 Completer<TemporaryElevation?>? pending;
 DateTime? deadline;
 @override
 bool get canElevate=>elevatedActor;
 @override
 bool get canApprove=>approvingActor;
 TenantSupportRequest get request=>TenantSupportRequest(id:id(22),requesterId:id(1),tenantId:id(12),ticket:'SYN-1',reason:'Synthetic tenant support',status:approved?'approved':'pending',expiresAt:deadline??DateTime.now().toUtc().add(lifetime));
 @override
 Future<TemporaryElevation?> elevate(String password,String code,String reason)async{
  if(pending!=null)return pending!.future;
  deadline=DateTime.now().toUtc().add(lifetime);return TemporaryElevation(id(21),deadline!);
 }
 @override
 Future<TenantSupportRequest?> requestSupport(TemporaryElevation elevation,String tenantId,String ticket,String reason)async=>request;
 @override
 Future<TenantSecuritySummary?> summary(TenantSupportRequest request)async=>TenantSecuritySummary(id(12),2,3,1);
 @override
 Future<bool> revokeSupport(TenantSupportRequest request,String password)async{revoked=true;return true;}
 @override
 Future<bool> revokeElevation(TemporaryElevation elevation)async=>true;
 @override
 Future<List<TenantSupportRequest>?> listRequests()async{lists++;return revoked?<TenantSupportRequest>[]:[request];}
 @override
 Future<bool> approve(TenantSupportRequest request,String password)async{approved=true;return true;}
}
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 setUpAll(()async{SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
 ProviderContainer fixture(SupportPresentationService service)=>ProviderContainer(overrides:[authProvider.overrideWith(SupportPresentationAuth.new),privilegedAccessServiceProvider.overrideWithValue(service)]);
 Widget screen(ProviderContainer c,Widget child,String locale)=>UncontrolledProviderScope(container:c,child:localized(Scaffold(body:SingleChildScrollView(child:MediaQuery(data:const MediaQueryData(textScaler:TextScaler.linear(2)),child:child))),language:locale));
 for(final locale in ['en','fr','es']){
  testWidgets('localized temporary support fits scaled 320px and clears proof and revoked data in $locale',(tester)async{
   tester.view.physicalSize=const Size(320,1200);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
   final service=SupportPresentationService(),c=fixture(service);
   try{
    await tester.pumpWidget(screen(c,const NativeAuthElevationForm(),locale));await tester.pumpAndSettle();expect(tester.takeException(),isNull);
    final controller=c.read(authElevationProvider.notifier);
    controller.password('synthetic-password');controller.factor('123456');controller.reason('Synthetic tenant support');await controller.elevate();await tester.pumpAndSettle();
    expect(c.read(authElevationProvider).password,isEmpty);expect(c.read(authElevationProvider).factor,isEmpty);expect(c.read(authElevationProvider).elevation,isNotNull);
    controller.tenant(id(12));controller.ticket('SYN-1');await controller.requestSupport();await tester.pumpAndSettle();
    expect(find.text(authElevationText[locale]!['pending']!),findsOneWidget);
    await controller.readSummary();await tester.pumpAndSettle();expect(find.text(authElevationText[locale]!['activeAccounts']!.replaceAll('{count}','2')),findsOneWidget);
    controller.password('synthetic-password');await controller.revokeSupport();await tester.pumpAndSettle();expect(c.read(authElevationProvider).summary,isNull);expect(c.read(authElevationProvider).request,isNull);
    await controller.end();await tester.pumpAndSettle();expect(c.read(authElevationProvider).elevation,isNull);expect(find.text(authElevationText[locale]!['expired']!),findsOneWidget);expect(tester.takeException(),isNull);
   }finally{await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);}
  });
  testWidgets('tenant approval refresh and revocation retain no password in $locale',(tester)async{
   tester.view.physicalSize=const Size(320,1600);tester.view.devicePixelRatio=1;addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
   final service=SupportPresentationService()..elevatedActor=false..approvingActor=true,c=fixture(service);
   try{
    await tester.pumpWidget(screen(c,const NativeTenantSupportForm(),locale));await tester.pumpAndSettle();expect(tester.takeException(),isNull);expect(service.lists,1);
    final controller=c.read(tenantSupportProvider.notifier),request=c.read(tenantSupportProvider).requests.single;
    await tester.enterText(find.byType(TextField),'synthetic-password');await controller.decide(request,approve:true);await tester.pumpAndSettle();
    expect(c.read(tenantSupportProvider).password,isEmpty);expect(tester.widget<TextField>(find.byType(TextField)).controller!.text,isEmpty);expect(c.read(tenantSupportProvider).requests.single.status,'approved');
    await tester.enterText(find.byType(TextField),'synthetic-password');await controller.decide(c.read(tenantSupportProvider).requests.single,approve:false);await tester.pumpAndSettle();
    expect(c.read(tenantSupportProvider).requests,isEmpty);expect(find.text(authElevationText[locale]!['none']!),findsOneWidget);expect(c.read(tenantSupportProvider).password,isEmpty);expect(tester.takeException(),isNull);
   }finally{await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);}
  });
 }
 testWidgets('leaving temporary support drops a late elevation receipt',(tester)async{
  final service=SupportPresentationService()..pending=Completer<TemporaryElevation?>(),c=fixture(service);
  try{
   await tester.pumpWidget(screen(c,const NativeAuthElevationForm(),'en'));await tester.pumpAndSettle();final controller=c.read(authElevationProvider.notifier);
   controller.password('synthetic-password');controller.factor('123456');controller.reason('Synthetic tenant support');final pending=controller.elevate();await tester.pump();
   await tester.pumpWidget(const SizedBox.shrink());await tester.pumpAndSettle();service.pending!.complete(TemporaryElevation(id(21),DateTime.now().toUtc().add(const Duration(minutes:10))));await pending;
   expect(c.read(authElevationProvider).elevation,isNull);expect(c.read(authElevationProvider).password,isEmpty);expect(tester.takeException(),isNull);
  }finally{await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);}
 });
 testWidgets('expiry clears elevation support reference and visible summary',(tester)async{
  final service=SupportPresentationService()..lifetime=const Duration(seconds:2),c=fixture(service);
  try{
   await tester.pumpWidget(screen(c,const NativeAuthElevationForm(),'en'));await tester.pumpAndSettle();final controller=c.read(authElevationProvider.notifier);
   controller.password('synthetic-password');controller.factor('123456');controller.reason('Synthetic tenant support');await controller.elevate();await tester.pump();expect(c.read(authElevationProvider).elevation,isNotNull);
   await tester.pump(const Duration(seconds:3));await tester.pumpAndSettle();expect(c.read(authElevationProvider).elevation,isNull);expect(c.read(authElevationProvider).request,isNull);expect(c.read(authElevationProvider).summary,isNull);expect(c.read(authElevationProvider).ended,true);
  }finally{await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);}
 });
 testWidgets('ordinary verified actor renders no privileged controls and issues no approval reads',(tester)async{
  final service=SupportPresentationService()..elevatedActor=false..approvingActor=false,c=fixture(service);
  try{
   await tester.pumpWidget(screen(c,const Column(children:[NativeAuthElevationForm(),NativeTenantSupportForm()]),'en'));await tester.pumpAndSettle();
   expect(find.byType(TextField),findsNothing);expect(find.byType(PrimeButton),findsNothing);expect(service.lists,0);
  }finally{await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);}
 });
}
