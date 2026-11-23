@Tags(['visual-capture'])
library;
import 'dart:convert';
import 'dart:io';
import 'dart:ui' show ImageByteFormat, PointerDeviceKind, SemanticsFlag;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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
   final compareNavbar = family == '2' && view.$1 == 'desktop';
   final application = ShellCaptureApplication();
   const role = PlatformRole.admin;
   Widget shell(Widget child) => RepaintBoundary(
    key: const Key('full-shell-proof'),
    child: GovernanceMasterLayout(
     application: application,
     activeRole: role,
     child: child,
    ),
   );
   final router = compareNavbar ? GoRouter(
    routes: [
     ShellRoute(
      // The nested navigator has only blank fixture pages. Keep them out of
      // traversal so Tab starts with the visible PrimeCare shell controls.
      builder: (_, _, child) => shell(ExcludeFocus(child: child)),
      routes: [
       GoRoute(path: '/', builder: (_, _) => const SizedBox.expand()),
       GoRoute(path: '/tenant-dashboard', builder: (_, _) => const SizedBox.expand()),
      ],
     ),
    ],
   ) : null;
   if (router != null) addTearDown(router.dispose);
   await tester.pumpWidget(
    UncontrolledProviderScope(
     container: container,
     child: RepaintBoundary(
      key: const Key('shell-overlay-proof'),
      child: router == null
       ? MaterialApp(debugShowCheckedModeBanner: false, home: shell(const SizedBox.expand()))
       : MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: router),
     ),
    ),
   );
   await tester.pumpAndSettle();
   final workspace=PortalWorkspaceScope.maybeOf(tester.element(find.byKey(const Key('app-shell'))))!;
   workspace.patch({'navigation':family=='1'?'left':'top','toolbar':family=='1'?'top':'belowNavigation','toolbarStyle':family=='1'?'sticky':'static','scroll':family=='3'?'content':'page','footer':'sticky'});
   await tester.pumpAndSettle();expect(tester.takeException(),isNull);
   final accountKey=family=='1'&&view.$1=='desktop'?const Key('sidebar-user-menu'):const Key('topbar-user-menu');
   final avatar=find.descendant(of:find.byKey(accountKey),matching:find.byType(CircleAvatar));
   expect(avatar,findsOneWidget);
   expect(tester.widget<CircleAvatar>(avatar).foregroundImage,isNull);
   expect(tester.widget<CircleAvatar>(avatar).child,isNotNull);
   if(family=='1'&&view.$1=='desktop') {
    expect(find.text('Tenant dashboard'),findsOneWidget);
    expect(find.text('TENANT DASHBOARD'),findsNothing,reason:'A lone module must not add a duplicate group caption');
    final item=find.ancestor(of:find.text('Tenant dashboard'),matching:find.byWidgetPredicate((w)=>w is ListTile));
    expect(tester.getRect(item).top,64);expect(tester.getSize(item).height,32);
    expect(find.text('PrimeCare'),findsOneWidget,reason:'The navbar owns the brand; the toolbar must not duplicate it');
    expect(find.text('Home service'),findsOneWidget);
    expect(find.byTooltip('Text scale'),findsOneWidget,reason:'Fuse Layout 1 exposes text size in the desktop toolbar');
    expect(find.byKey(const Key('sidebar-user-menu')),findsOneWidget,reason:'The vertical Fuse account trigger belongs at the sidebar footer');
    expect(find.byKey(const Key('topbar-user-menu')),findsNothing,reason:'Desktop vertical layout must not duplicate the account in the toolbar');
    expect(find.text(PlatformRole.admin.displayName),findsOneWidget,reason:'Role and account share one Fuse-style menu trigger');
    final sidebar=find.byKey(const Key('app-sidebar'));
    final surface=tester.widget<Container>(find.descendant(of:sidebar,matching:find.byType(Container)).first);
    expect((surface.decoration as BoxDecoration).color,Theme.of(tester.element(sidebar)).scaffoldBackgroundColor);
   }
   expect(resourceErrors,isEmpty,reason:'The local account mark must not issue a network image request');
   Directory('test/screenshots/shell-captures').createSync(recursive:true);final id='layout$family-${view.$1}-$mode';
   if (compareNavbar && mode == 'light') {
    final account = container.read(authProvider);
    final activeContext = tester.element(find.byKey(const Key('app-shell')));
    final entries = [
     for (final module in application.getAuthorizedModules(role))
      for (final screen in module.screens)
       if (screen.requiredRole == null || screen.requiredRole == role) {
        'route': screen.route,
        'label': screen.title,
        'icon': screen.icon == LucideIcons.star ? 'lucide:star' : null,
       },
    ];
    expect(entries, hasLength(1));
    expect(account.isAuthenticated, isTrue);
    expect(account.role, role.name);
    File('test/screenshots/shell-captures/navigation-fixture.json').writeAsStringSync(
     jsonEncode({
      'version': 1,
      'fixtureOnly': true,
      'account': {'role': role.name, 'displayName': role.displayName},
      'language': Localizations.localeOf(activeContext).languageCode,
      'entries': entries,
     }),
    );
   }
   Map<String,double>? barBox(bool top){final f=find.byWidgetPredicate((w)=>w is PrimeShellBarFrame&&w.top==top);if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   Map<String,double>? box(String key){final f=find.byKey(Key(key));if(f.evaluate().length!=1)return null;final b=tester.getRect(f);return {'x':b.left,'y':b.top,'width':b.width,'height':b.height};}
   File('test/screenshots/shell-captures/$id.json').writeAsStringSync(jsonEncode({'case':id,'boxes':{'shell':box('app-shell'),'toolbar':barBox(false),'toolbarInner':box('app-topbar'),'footer':barBox(true),'sidebar':box('app-sidebar'),'content':box('app-content-slot')},'fixture':'existing registered /tenant-dashboard route sample; fixture-only policy and synthetic account; not production','referenceStateAligned':false,'imageResourceErrors':resourceErrors,'visualAcceptance':false}));
   await expectLater(find.byKey(const Key('full-shell-proof')),matchesGoldenFile('shell-captures/primecare-shell-$id.png'));
   if (compareNavbar) {
    final accountProof = find.byKey(const Key('shell-overlay-proof'));
    await tester.tap(find.byKey(const Key('topbar-user-menu')));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(PopupMenuItem<String>, 'Switch role'), findsNothing);
    expect(find.text('Sign out'), findsOneWidget);
    await expectLater(accountProof, matchesGoldenFile('shell-captures/primecare-shell-$id-account-menu-open.png'));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('Sign out'), findsNothing);
    final moduleLabel = find.text('Tenant dashboard');
    final brand = find.text('PrimeCare').first;
    expect(find.text('PrimeCare'), findsOneWidget);
    expect(tester.getTopLeft(brand).dy, lessThan(64));
    expect(tester.getCenter(moduleLabel).dx, greaterThan(view.$2 / 2));
    final toolbar = tester.getRect(find.byKey(const Key('app-topbar')));
    expect(toolbar.left, 192);
    expect(toolbar.right, 1248);
    expect(tester.getTopLeft(find.byType(PrimeHorizontalChrome).first).dx, 0);
    expect(find.byType(PrimeSidebarFoldButton), findsNothing);
    expect(find.byTooltip('Text scale'), findsOneWidget);
    expect(find.text(PlatformRole.admin.displayName), findsOneWidget);
    final semantics = tester.ensureSemantics();
    try {
     final triggerFinder = find.ancestor(of: moduleLabel, matching: find.byType(TextButton));
     expect(triggerFinder, findsOneWidget);
     expect(tester.getSize(triggerFinder).height, PrimeShellMetrics.horizontalNavigationRowHeight);
     final link = find.ancestor(of: triggerFinder, matching: find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.link == true,
     ));
     expect(tester.getSemantics(link).hasFlag(SemanticsFlag.isLink), isTrue);
     final proof = find.byKey(const Key('shell-overlay-proof'));
     final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
     await mouse.addPointer(location: const Offset(1, 1));
     await mouse.moveTo(tester.getCenter(moduleLabel));
     await tester.pumpAndSettle();
     await expectLater(
      proof,
      matchesGoldenFile('shell-captures/primecare-shell-$id-hover.png'),
     );
     await mouse.removePointer();
     await tester.pumpAndSettle();
     final trigger = tester.element(triggerFinder);
     bool keyboardFocused() {
      var found = false;
      FocusManager.instance.primaryFocus?.context?.visitAncestorElements((element) {
       found = element == trigger;
       return !found;
      });
      return found;
     }
     for (var i = 0; i < 20 && !keyboardFocused(); i++) {
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
     }
     expect(keyboardFocused(), isTrue);
     await tester.pumpAndSettle();
     await expectLater(
      proof,
      matchesGoldenFile('shell-captures/primecare-shell-$id-focus.png'),
     );
     await tester.sendKeyEvent(LogicalKeyboardKey.enter);
     await tester.pumpAndSettle();
     expect(find.widgetWithText(PopupMenuItem<String>, 'Tenant dashboard'), findsNothing);
     expect(tester.getSemantics(link).hasFlag(SemanticsFlag.isSelected), isTrue);
     final selectedStyle = tester.widget<TextButton>(triggerFinder).style!;
     final selectedColor = selectedStyle.backgroundColor?.resolve({});
     expect(selectedColor, isNotNull);
     const focusedState = {WidgetState.focused};
     expect(selectedStyle.overlayColor?.resolve(focusedState), Colors.transparent);
     expect(selectedStyle.side?.resolve(focusedState), isNull);
     expect(selectedStyle.shape?.resolve(focusedState),
       const RoundedRectangleBorder(borderRadius: BorderRadius.zero));
     final selectedBounds = tester.getRect(triggerFinder);
     final paintedButton = find.descendant(
      of: triggerFinder, matching: find.byType(Material),
     );
     expect(tester.getSize(paintedButton).height,
         PrimeShellMetrics.horizontalDestinationPaintHeight);
     expect(tester.getSize(paintedButton).width, closeTo(151.953125, 0.1));
     expect(selectedBounds.height, PrimeShellMetrics.horizontalNavigationRowHeight);
     expect(selectedBounds.left, closeTo(1096.046875, 0.1));
     expect(selectedBounds.right, closeTo(1248, 0.1));
     final boundary = tester.renderObject<RenderRepaintBoundary>(proof);
     final paintPoint = boundary.globalToLocal(
      Offset(selectedBounds.left + 4, selectedBounds.center.dy),
     );
     final paintedArgb = await tester.runAsync(() async {
      final image = await boundary.toImage();
      try {
       final bytes = (await image.toByteData(format: ImageByteFormat.rawRgba))!;
       final offset = (paintPoint.dy.floor() * image.width + paintPoint.dx.floor()) * 4;
       return (bytes.getUint8(offset + 3) << 24) |
           (bytes.getUint8(offset) << 16) |
           (bytes.getUint8(offset + 1) << 8) |
           bytes.getUint8(offset + 2);
      } finally {
       image.dispose();
      }
     });
     expect(paintedArgb, selectedColor!.toARGB32(),
         reason: 'Keyboard focus preserves the painted selection');
     final destination = router!.routeInformationProvider.value.uri.path;
     expect(destination, '/tenant-dashboard');
     // The registered router keeps its shell mounted when a child route changes.
     final activatedWorkspace = PortalWorkspaceScope.maybeOf(
      tester.element(find.byKey(const Key('app-shell'))),
     );
     expect(activatedWorkspace, same(workspace));
     expect(tester.getTopLeft(brand).dy, lessThan(64));
     await expectLater(
      proof,
      matchesGoldenFile('shell-captures/primecare-shell-$id-activated.png'),
     );
     File('test/screenshots/shell-captures/$id-activation.json').writeAsStringSync(
      jsonEncode({
       'keyboardActivation': true,
       'destination': destination,
       'directDestination': true,
       'shellLayoutPreserved': true,
       'selected': true,
       'selectedColorArgb': selectedColor.toARGB32(),
       'selectedPaintedArgb': paintedArgb,
       'selectedPaintHeight': tester.getSize(paintedButton).height,
       'selectedBounds': {
        'x': selectedBounds.left,
        'y': selectedBounds.top,
        'width': selectedBounds.width,
        'height': selectedBounds.height,
       },
      }),
     );
     await tester.tap(find.byTooltip('Change Language'));
     await tester.pumpAndSettle();
     expect(find.text('English (EN)'), findsOneWidget);
     expect(find.text('Français (FR)'), findsOneWidget);
     expect(find.text('Español (ES)'), findsOneWidget);
     await expectLater(proof, matchesGoldenFile('shell-captures/primecare-shell-$id-language-open.png'));
     await tester.sendKeyEvent(LogicalKeyboardKey.escape);
     await tester.pumpAndSettle();
     await tester.tap(find.byTooltip('Text scale'));
     await tester.pumpAndSettle();
     expect(find.text('125%'), findsOneWidget);
     await expectLater(proof, matchesGoldenFile('shell-captures/primecare-shell-$id-text-size-open.png'));
     await tester.tap(find.text('125%'));
     await tester.pumpAndSettle();
     expect(container.read(themeSettingsProvider).theme.fontScale, 1.25);
     expect(container.read(themeSettingsProvider).sectionThemes['navbar']?.preset,
       mode == 'dark' ? 'defaultDark' : 'defaultNavbar');
     await tester.tap(find.byTooltip('Save'));
     await tester.pumpAndSettle();
     expect(prefs.getString(workspace.scope.storageKey), workspace.exportJson());
     expect(find.text('Layout saved on this device.'), findsOneWidget);
     await expectLater(proof, matchesGoldenFile('shell-captures/primecare-shell-$id-layout-saved.png'));
    } finally {
     semantics.dispose();
    }
   }
  });
 }
}
