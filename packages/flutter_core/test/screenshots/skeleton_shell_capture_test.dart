@Tags(['visual-capture'])
library;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/models/domain_governance.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/prime_shell_metrics.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
import 'theme_center_capture_test.dart' show loadFonts, CaptureAuth;
/// Rendering sample for existing registered host 2534 (/tenant-dashboard).
/// This local policy fixture does not grant a live user any permission.
class SidebarCaptureModule extends PlatformModule {
 @override String get moduleId=>'capture-existing-host';
 @override String get name=>'Tenant dashboard';
 @override IconData get icon=>LucideIcons.star;
 @override List<PlatformRole> get allowedRoles=>[PlatformRole.admin];
 @override List<PrimeCareScreen> get screens=>[PrimeCareScreen(title:'Tenant dashboard',route:'/tenant-dashboard',requiredRole:PlatformRole.admin,icon:LucideIcons.star)];
}
class ShellCaptureApplication extends PlatformApplication {
 @override String get appId=>'shell-capture-only';
 @override String get name=>'Shell capture only';
 @override PlatformTenant get tenant=>PrimeCareTenant();
 @override List<PlatformRoleDefinition> get roleDefinitions=>[];
 @override List<PlatformModule> getAuthorizedModules(PlatformRole role)=>role==PlatformRole.admin?[SidebarCaptureModule()]:[];
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
   await container.read(themeSettingsProvider.notifier).updateSectionTheme('navbar',PersonalTheme(name:'Reference Navbar',preset:mode=='dark'?'defaultDark':'defaultNavbar'));
   final resourceErrors=<String>[];final previous=FlutterError.onError;
   FlutterError.onError=(details){if(details.library=='image resource service'){resourceErrors.add(details.exception.runtimeType.toString());}else{previous?.call(details);}};
   addTearDown(()=>FlutterError.onError=previous);
   await tester.pumpWidget(
    UncontrolledProviderScope(
     container: container,
     child: RepaintBoundary(
      key: const Key('shell-overlay-proof'),
      child: MaterialApp(
       home: RepaintBoundary(
        key: const Key('full-shell-proof'),
        child: GovernanceMasterLayout(
         application: ShellCaptureApplication(),
         activeRole: PlatformRole.admin,
         child: const SizedBox.expand(),
        ),
       ),
      ),
     ),
    ),
   );
   await tester.pumpAndSettle();
   final workspace=PortalWorkspaceScope.maybeOf(tester.element(find.byKey(const Key('app-shell'))))!;
   workspace.patch({'navigation':family=='1'?'left':'top','toolbar':family=='1'?'top':'belowNavigation','toolbarStyle':family=='1'?'sticky':'static','scroll':family=='3'?'content':'page','footer':'sticky'});
   await tester.pumpAndSettle();expect(tester.takeException(),isNull);
   final avatar=find.descendant(of:find.byKey(const Key('topbar-user-menu')),matching:find.byType(CircleAvatar));
   expect(avatar,findsOneWidget);
   expect(tester.widget<CircleAvatar>(avatar).foregroundImage,isNotNull);
   expect(tester.widget<CircleAvatar>(avatar).child,isNotNull);
   if(family=='1'&&view.$1=='desktop') {
    expect(find.text('Tenant dashboard'),findsOneWidget);
    expect(find.text('TENANT DASHBOARD'),findsNothing,reason:'A lone module must not add a duplicate group caption');
    final item=find.ancestor(of:find.text('Tenant dashboard'),matching:find.byWidgetPredicate((w)=>w is ListTile));
    expect(tester.getRect(item).top,64);expect(tester.getSize(item).height,32);
    expect(find.text('PrimeCare'),findsNWidgets(2),reason:'Brand header and existing topbar tenant label');
    expect(find.text('Home service'),findsOneWidget);
    final sidebar=find.byKey(const Key('app-sidebar'));
    final surface=tester.widget<Container>(find.descendant(of:sidebar,matching:find.byType(Container)).first);
    expect((surface.decoration as BoxDecoration).color,Theme.of(tester.element(sidebar)).scaffoldBackgroundColor);
   }
   expect(resourceErrors,isEmpty,reason:'The deliberate failed-image path must show the user fallback without an unhandled image error');
   Directory('test/screenshots/shell-captures').createSync(recursive:true);final id='layout$family-${view.$1}-$mode';
   Map<String,double>? barBox(bool top){final f=find.byWidgetPredicate((w)=>w is PrimeShellBarFrame&&w.top==top);if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   Map<String,double>? box(String key){final f=find.byKey(Key(key));if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   File('test/screenshots/shell-captures/$id.json').writeAsStringSync(jsonEncode({'case':id,'boxes':{'shell':box('app-shell'),'toolbar':barBox(false),'toolbarInner':box('app-topbar'),'footer':barBox(true),'sidebar':box('app-sidebar'),'content':box('app-content-slot')},'fixture':'existing registered /tenant-dashboard route sample; fixture-only policy and synthetic account; not production','referenceStateAligned':false,'imageResourceErrors':resourceErrors,'visualAcceptance':false}));
   await expectLater(find.byKey(const Key('full-shell-proof')),matchesGoldenFile('shell-captures/primecare-shell-$id.png'));
   if (family == '2' && view.$1 == 'desktop') {
    final moduleLabel = find.text('Tenant dashboard');
    final brand = find.text('PrimeCare').first;
    expect(tester.getTopLeft(brand).dy, lessThan(64));
    expect(tester.getCenter(moduleLabel).dx, greaterThan(view.$2 / 2));
    final semantics = tester.ensureSemantics();
    try {
     expect(find.byTooltip('Tenant dashboard'), findsOneWidget);
     await tester.tap(moduleLabel);
     await tester.pumpAndSettle();
     final item = find.widgetWithText(PopupMenuItem<String>, 'Tenant dashboard');
     expect(item, findsOneWidget);
     expect(tester.widget<PopupMenuItem<String>>(item).value, '/tenant-dashboard');
     await expectLater(
      find.byKey(const Key('shell-overlay-proof')),
      matchesGoldenFile('shell-captures/primecare-shell-$id-menu-open.png'),
     );
     await tester.sendKeyEvent(LogicalKeyboardKey.escape);
     await tester.pumpAndSettle();
     expect(item, findsNothing);
    } finally {
     semantics.dispose();
    }
   }
  });
 }
}
