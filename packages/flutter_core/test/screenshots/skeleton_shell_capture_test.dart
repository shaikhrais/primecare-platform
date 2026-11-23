@Tags(['visual-capture'])
library;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/models/domain_governance.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/prime_shell_metrics.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
import 'theme_center_capture_test.dart' show loadFonts, CaptureAuth;
class ShellCaptureApplication extends PlatformApplication {
 @override String get appId=>'shell-capture-only';
 @override String get name=>'Shell capture only';
 @override PlatformTenant get tenant=>PrimeCareTenant();
 @override List<PlatformRoleDefinition> get roleDefinitions=>[];
 @override List<PlatformModule> getAuthorizedModules(PlatformRole role)=>[];
}
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();setUpAll(loadFonts);
 for(final family in ['1','2','3'])for(final view in [('desktop',1440.0,1000.0),('tablet',820.0,1180.0),('mobile',390.0,844.0)])for(final mode in ['light','dark']){
  testWidgets('actual full native host $family ${view.$1} $mode',(tester)async{
   tester.view.physicalSize=Size(view.$2,view.$3);tester.view.devicePixelRatio=1;
   addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
   SharedPreferences.setMockInitialValues({});final prefs=await SharedPreferences.getInstance();
   final container=ProviderContainer(overrides:[sharedPreferencesProvider.overrideWithValue(prefs),authProvider.overrideWith(CaptureAuth.new)]);addTearDown(container.dispose);
   container.read(themeSettingsProvider);
   await container.read(themeSettingsProvider.notifier).updateLayoutStyle(family=='1'?LayoutStyle.verticalLeft:LayoutStyle.horizontal);
   await container.read(themeSettingsProvider.notifier).updatePreset(mode=='dark'?'defaultDark':'default');
   final resourceErrors=<String>[];final previous=FlutterError.onError;
   FlutterError.onError=(details){if(details.library=='image resource service'){resourceErrors.add(details.exception.runtimeType.toString());}else{previous?.call(details);}};
   addTearDown(()=>FlutterError.onError=previous);
   await tester.pumpWidget(UncontrolledProviderScope(container:container,child:MaterialApp(home:RepaintBoundary(key:const Key('full-shell-proof'),child:GovernanceMasterLayout(application:ShellCaptureApplication(),activeRole:PlatformRole.admin,child:const SizedBox.expand())))));
   await tester.pumpAndSettle();
   final workspace=PortalWorkspaceScope.maybeOf(tester.element(find.byKey(const Key('app-shell'))))!;
   workspace.patch({'navigation':family=='1'?'left':'top','toolbar':family=='1'?'top':'belowNavigation','toolbarStyle':family=='1'?'sticky':'static','scroll':family=='3'?'content':'page','footer':'sticky'});
   await tester.pumpAndSettle();expect(tester.takeException(),isNull);
   final avatar=find.descendant(of:find.byKey(const Key('topbar-user-menu')),matching:find.byType(CircleAvatar));
   expect(avatar,findsOneWidget);
   expect(tester.widget<CircleAvatar>(avatar).foregroundImage,isNotNull);
   expect(tester.widget<CircleAvatar>(avatar).child,isNotNull);
   expect(resourceErrors,isEmpty,reason:'The deliberate failed-image path must show the user fallback without an unhandled image error');
   Directory('test/screenshots/shell-captures').createSync(recursive:true);final id='layout$family-${view.$1}-$mode';
   Map<String,double>? barBox(bool top){final f=find.byWidgetPredicate((w)=>w is PrimeShellBarFrame&&w.top==top);if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   Map<String,double>? box(String key){final f=find.byKey(Key(key));if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   File('test/screenshots/shell-captures/$id.json').writeAsStringSync(jsonEncode({'case':id,'boxes':{'shell':box('app-shell'),'toolbar':barBox(false),'toolbarInner':box('app-topbar'),'footer':barBox(true),'sidebar':box('app-sidebar'),'content':box('app-content-slot')},'fixture':'empty authorized-module set; synthetic local account; not production','referenceStateAligned':false,'imageResourceErrors':resourceErrors,'visualAcceptance':false}));
   await expectLater(find.byKey(const Key('full-shell-proof')),matchesGoldenFile('shell-captures/primecare-shell-$id.png'));
  });
 }
}
