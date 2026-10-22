import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/features/auth/mfa_management_controller.dart';
import 'package:primecare_ui/src/features/auth/mfa_management_form.dart';
import 'package:primecare_ui/src/features/auth/mfa_form.dart';
import 'package:primecare_ui/src/features/auth/auth_lifecycle_catalog.g.dart';
import 'package:primecare_ui/src/features/auth/mfa_catalog.g.dart';
import 'auth_design_test.dart' show localized, GuestAuth;

class ManagedPresentationAuth extends AuthNotifier {
  Completer<Map<String,dynamic>?>? pending;
  @override
  AuthState build()=>AuthState(isInitialized:true,isAuthenticated:true,role:'code_admin',userId:'owner',token:List.filled(43,'s').join());
  @override
  Future<Map<String,dynamic>?> manageMfa(MfaManagementAction action,String password,String code)async{
    if(pending!=null)return pending!.future;
    return action==MfaManagementAction.recoveryCodes
      ? {'status':'recovery_codes_issued','recoveryCodes':List.generate(10,(i)=>String.fromCharCode(65+i)+List.filled(25,'A').join())}
      : {'status':'mfa_replacement_required','challenge':List.filled(43,'r').join(),'setupKey':List.filled(32,'B').join()};
  }
}
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(()async{SharedPreferences.setMockInitialValues({});await EasyLocalization.ensureInitialized();});
  for(final locale in ['en','fr','es']){
    testWidgets('MFA lifecycle fits 320px scaled text and saved-code acknowledgement clears secrets in $locale',(tester)async{
      tester.view.physicalSize=const Size(320,1200);tester.view.devicePixelRatio=1;
      addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
      final c=ProviderContainer(overrides:[authProvider.overrideWith(ManagedPresentationAuth.new)]);try {
      await tester.pumpWidget(UncontrolledProviderScope(container:c,child:localized(const Scaffold(body:SingleChildScrollView(child:MediaQuery(data:MediaQueryData(textScaler:TextScaler.linear(2)),child:NativeMfaManagementForm()))),language:locale)));
      await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      expect(find.text(authLifecycleText[locale]!['title']!),findsOneWidget);
      final controller=c.read(mfaManagementProvider.notifier);controller.onPasswordChanged('synthetic-password');controller.onFactorChanged('123456');
      await controller.issueCodes();await tester.pumpAndSettle();expect(tester.takeException(),isNull);
      expect(c.read(mfaManagementProvider).password,isEmpty);expect(c.read(mfaManagementProvider).factor,isEmpty);
      expect(find.byType(SelectableText),findsOneWidget);expect(c.read(mfaManagementProvider).recoveryCodes,hasLength(10));
      controller.saved();await tester.pumpAndSettle();expect(find.byType(SelectableText),findsNothing);
      expect(c.read(mfaManagementProvider).recoveryCodes,isEmpty);expect(find.text(authLifecycleText[locale]!['done']!),findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());await tester.pump();
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);
    }
    });
  }
  testWidgets('leaving management disposes saved codes and drops a late response',(tester)async{
    final auth=ManagedPresentationAuth()..pending=Completer<Map<String,dynamic>?>();
    final c=ProviderContainer(overrides:[authProvider.overrideWith(()=>auth)]);try {
    await tester.pumpWidget(UncontrolledProviderScope(container:c,child:localized(const Scaffold(body:NativeMfaManagementForm()))));await tester.pumpAndSettle();
    final controller=c.read(mfaManagementProvider.notifier);controller.onPasswordChanged('synthetic-password');controller.onFactorChanged('123456');
    final pending=controller.issueCodes();await tester.pump();
    expect(find.byWidgetPredicate((widget)=>widget is Cy&&widget.id=='mfa-lifecycle-working'),findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());await tester.pumpAndSettle();
    auth.pending!.complete({'status':'recovery_codes_issued','recoveryCodes':List.filled(10,List.filled(26,'A').join())});
    await pending;expect(tester.takeException(),isNull);
    expect(c.read(mfaManagementProvider).recoveryCodes,isEmpty);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);
  }
  });
  testWidgets('leaving saved-code view clears secrets before the same route reopens',(tester)async{
    final c=ProviderContainer(overrides:[authProvider.overrideWith(ManagedPresentationAuth.new)]);try {
    Widget screen()=>UncontrolledProviderScope(container:c,child:localized(const Scaffold(body:NativeMfaManagementForm())));
    await tester.pumpWidget(screen());await tester.pumpAndSettle();
    final controller=c.read(mfaManagementProvider.notifier);controller.onPasswordChanged('synthetic-password');controller.onFactorChanged('123456');
    await controller.issueCodes();await tester.pumpAndSettle();expect(find.byType(SelectableText),findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());await tester.pumpAndSettle();
    await tester.pumpWidget(screen());await tester.pumpAndSettle();
    expect(c.read(mfaManagementProvider).recoveryCodes,isEmpty);expect(find.byType(SelectableText),findsNothing);
    expect(c.read(mfaManagementProvider).working,false);expect(find.byType(TextFormField),findsNWidgets(2));
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);
  }
  });
  testWidgets('recovery clears entered codes and keeps replacement proof transient until a factor is verified',(tester)async{
    final c=ProviderContainer(overrides:[authProvider.overrideWith(GuestAuth.new)]);try {
    final controller=c.read(mfaControllerProvider.notifier);
    final prompt=controller.request({'purpose':'verify','challenge':List.filled(43,'a').join()},(code)async=>false,
      recover:(code)async=>{'purpose':'replace','status':'mfa_replacement_required','challenge':List.filled(43,'r').join(),'setupKey':List.filled(32,'B').join()});
    await tester.pumpWidget(UncontrolledProviderScope(container:c,child:localized(const Scaffold(body:SingleChildScrollView(child:NativeMfaForm())))));await tester.pumpAndSettle();
    controller.showRecovery();await tester.pumpAndSettle();controller.onRecoveryCodeChanged(List.filled(26,'A').join());
    await controller.recover();await tester.pumpAndSettle();
    expect(c.read(mfaControllerProvider).recoveryCode,isEmpty);expect(c.read(mfaControllerProvider).challenge?['purpose'],'replace');
    expect(c.read(authProvider).isAuthenticated,false);expect(find.byType(SelectableText),findsOneWidget);
    controller.cancel();await prompt;await tester.pumpAndSettle();expect(find.byType(SelectableText),findsNothing);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);
  }
  });
  testWidgets('challenge expiry removes setup key code and pending login prompt',(tester)async{
    final c=ProviderContainer(overrides:[authProvider.overrideWith(GuestAuth.new)]);try {
    final controller=c.read(mfaControllerProvider.notifier);
    final prompt=controller.request({'purpose':'enroll','challenge':List.filled(43,'a').join(),'setupKey':List.filled(32,'A').join()},(code)async=>false);
    await tester.pumpWidget(UncontrolledProviderScope(container:c,child:localized(const Scaffold(body:SingleChildScrollView(child:NativeMfaForm())))));await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds:nativeMfaChallengeLifetimeSeconds+1));await prompt;await tester.pumpAndSettle();
    expect(c.read(mfaControllerProvider).pending,false);expect(c.read(mfaControllerProvider).code,isEmpty);
    expect(find.byType(SelectableText),findsNothing);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());c.dispose();await tester.pump(Duration.zero);
  }
  });
}
