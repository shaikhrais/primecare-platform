@Tags(['visual-capture'])
library;

import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PointerDeviceKind, SemanticsFlag;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' show debugDisableShadows;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/original_assets.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/theme/prime_shell_metrics.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'theme_center_capture_test.dart' show loadFonts, CaptureAuth;
import 'skeleton_shell_capture_test.dart' show ShellCaptureApplication;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadFonts);
  for (final mode in ['light', 'dark'])
    for (final state in [
      'left',
      'folded',
      'right',
      'mobile',
      'folded-tabbed',
    ]) {
      testWidgets('populated sidebar $state $mode selected hover focus', (
        tester,
      ) async {
        final semantics = tester.ensureSemantics();
        try {
          tester.view.physicalSize = Size(
            state == 'mobile' ? 390 : 1440,
            state == 'mobile' ? 844 : 1000,
          );
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          SharedPreferences.setMockInitialValues({});
          final prefs = await SharedPreferences.getInstance();
          final c = ProviderContainer(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(prefs),
              authProvider.overrideWith(CaptureAuth.new),
            ],
          );
          addTearDown(c.dispose);
          c.read(themeSettingsProvider);
          await c
              .read(themeSettingsProvider.notifier)
              .updatePreset(mode == 'dark' ? 'defaultDark' : 'default');
          final tabbed = state == 'folded-tabbed';
          if (tabbed) {
            await c
                .read(themeSettingsProvider.notifier)
                .updateNavigationStyle('tabbed');
          }
          await c
              .read(themeSettingsProvider.notifier)
              .updateSectionTheme(
                'navbar',
                PersonalTheme(
                  name: 'Reference Navbar',
                  preset: mode == 'dark' ? 'defaultDark' : 'defaultNavbar',
                ),
              );
          // Existing registered route, with the required accessibility query retained.
          var navigationAttempts = 0;
          final router = GoRouter(
            initialLocation: '/tenant-dashboard?enable-semantics=true',
            redirect: (context, state) {
              navigationAttempts++;
              // Capture harness keeps semantics enabled after real navigation.
              if (state.uri.queryParameters['enable-semantics'] != 'true')
                return state.uri
                    .replace(
                      queryParameters: {
                        ...state.uri.queryParameters,
                        'enable-semantics': 'true',
                      },
                    )
                    .toString();
              return null;
            },
            routes: [
              GoRoute(
                path: '/tenant-dashboard',
                builder: (context, s) => RepaintBoundary(
                  key: const Key('sidebar-state-proof'),
                  child: GovernanceMasterLayout(
                    application: ShellCaptureApplication(),
                    activeRole: PlatformRole.admin,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ],
          );
          addTearDown(router.dispose);
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: c,
              child: RepaintBoundary(
                key: const Key('sidebar-overlay-proof'),
                child: MaterialApp.router(
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          final workspace = PortalWorkspaceScope.maybeOf(
            tester.element(find.byKey(const Key('app-shell'))),
          )!;
          workspace.patch({
            'navigation': state == 'right' ? 'right' : 'left',
            'navigationWidth': state == 'folded' || tabbed ? 64 : 280,
            'footer': 'sticky',
          });
          await tester.pumpAndSettle();
          if (tabbed) {
            final rail = find.byType(PrimeTabbedNavigation);
            expect(tester.getSize(rail).width, 48);
            expect(workspace.current.navigationWidth, 64);
            expect(
              find.descendant(
                of: rail,
                matching: find.byType(PrimeOriginalAsset),
              ),
              findsOneWidget,
            );
            final trigger = find.descendant(
              of: rail,
              matching: find.byType(IconButton),
            );
            final semantics = find.ancestor(
              of: trigger,
              matching: find.byWidgetPredicate(
                (w) =>
                    w is Semantics && w.properties.label == 'Tenant dashboard',
              ),
            );
            expect(
              tester.getSemantics(semantics).label,
              contains('Tenant dashboard'),
            );
            expect(
              tester.getSemantics(semantics).hasFlag(SemanticsFlag.isLink),
              isTrue,
            );
            final proof = find.byKey(const Key('sidebar-overlay-proof'));
            Future<void> captureTabbed(String phase) => expectLater(
              proof,
              matchesGoldenFile(
                'sidebar-state-captures/folded-tabbed-$mode-$phase.png',
              ),
            );
            await captureTabbed('baseline');
            final pointer = await tester.createGesture(
              kind: PointerDeviceKind.mouse,
            );
            await pointer.addPointer(location: const Offset(1, 1));
            await pointer.moveTo(tester.getCenter(trigger));
            await tester.pumpAndSettle();
            await captureTabbed('hover');
            await pointer.removePointer();
            await tester.pumpAndSettle();
            final triggerElement = tester.element(trigger);
            bool focused() {
              var found = false;
              FocusManager.instance.primaryFocus?.context
                  ?.visitAncestorElements((element) {
                    found = element == triggerElement;
                    return !found;
                  });
              return found;
            }

            for (var i = 0; i < 20 && !focused(); i++) {
              await tester.sendKeyEvent(LogicalKeyboardKey.tab);
              await tester.pump();
            }
            expect(focused(), isTrue);
            await captureTabbed('focus');
            final before = navigationAttempts;
            await tester.sendKeyEvent(LogicalKeyboardKey.enter);
            await tester.pumpAndSettle();
            expect(navigationAttempts, greaterThan(before));
            expect(
              find.widgetWithText(PopupMenuItem<int>, 'Tenant dashboard'),
              findsNothing,
            );
            await captureTabbed('activated');
            File(
              'test/screenshots/sidebar-state-captures/folded-tabbed-$mode.json',
            ).writeAsStringSync(
              jsonEncode({
                'mode': mode,
                'variant': 'tabbed',
                'navigationWidth': 48,
                'directDestination': true,
                'route': router.routeInformationProvider.value.uri.path,
                'fixtureOnly': true,
              }),
            );
            return;
          }
          if (state == 'mobile') {
            expect(find.byType(PrimeSidebarFoldButton), findsNothing);
            final trigger = find.byType(PrimeSidebarDrawerButton);
            expect(trigger, findsOneWidget);
            expect(
              find.descendant(
                of: trigger,
                matching: find.byIcon(LucideIcons.panelLeft),
              ),
              findsOneWidget,
            );
            await tester.tap(trigger);
            await tester.pumpAndSettle();
            final drawer = tester.widget<DrawerController>(
              find.byWidgetPredicate(
                (widget) =>
                    widget is DrawerController &&
                    widget.alignment == DrawerAlignment.start,
              ),
            );
            expect(drawer.scrimColor, const Color(0x80000000));
            final scaffold = tester.state<ScaffoldState>(
              find.byType(Scaffold).first,
            );
            await tester.tapAt(const Offset(340, 500));
            await tester.pumpAndSettle();
            expect(scaffold.isDrawerOpen, isFalse);
            await tester.tap(trigger);
            await tester.pumpAndSettle();
            expect(scaffold.isDrawerOpen, isTrue);
          }
          final sidebar = find.byKey(const Key('app-sidebar'));
          expect(sidebar, findsOneWidget);
          final expectedWidth = state == 'folded' ? 48.0 : 280.0;
          expect(tester.getRect(sidebar).width, expectedWidth);
          if (state == 'folded') {
            expect(workspace.current.navigationWidth, 64);
          }
          if (state == 'right') {
            expect(tester.getRect(sidebar).left, 1160);
          }

          final item = find
              .descendant(
                of: sidebar,
                matching: find.byWidgetPredicate((w) => w is ListTile),
              )
              .first;
          expect(
            tester.widget<ListTile>(item).selected,
            isTrue,
            reason: 'Accessibility query must not break selected-route styling',
          );
          expect(
            tester
                .getSemantics(item)
                .getSemanticsData()
                .hasFlag(SemanticsFlag.isSelected),
            isTrue,
          );
          expect(tester.getSemantics(item).label, contains('Tenant dashboard'));
          if (state == 'folded') {
            expect(tester.getRect(item).top, 60);
            expect(tester.getRect(item).height, 32);
          }
          expect(
            find.descendant(of: sidebar, matching: find.text('Home service')),
            state == 'folded' ? findsNothing : findsOneWidget,
          );
          final path = 'test/screenshots/sidebar-state-captures';
          Directory(path).createSync(recursive: true);
          final id = '$state-$mode';
          final boxes = <String, Object>{};
          Map<String, double> box(Finder f) {
            final b = tester.getRect(f);
            return {
              'x': b.left,
              'y': b.top,
              'width': b.width,
              'height': b.height,
            };
          }

          boxes['sidebar'] = box(sidebar);
          boxes['item'] = box(item);
          Future<void> capture(String name) async {
            await expectLater(
              find.byKey(const Key('sidebar-state-proof')),
              matchesGoldenFile('sidebar-state-captures/$id-$name.png'),
            );
          }

          await capture('selected');
          final accountTrigger = find.byKey(const Key('sidebar-user-menu'));
          expect(accountTrigger, findsOneWidget);
          final accountTriggerRect = tester.getRect(accountTrigger);
          final accountInfo = find.descendant(
            of: accountTrigger,
            matching: find.byIcon(LucideIcons.info),
          );
          if (state == 'folded') {
            expect(accountInfo, findsNothing);
          } else {
            expect(tester.getSize(accountInfo), const Size.square(16));
          }
          expect(accountTriggerRect.width, state == 'folded' ? 40 : 255);
          expect(
            accountTriggerRect.height,
            state == 'folded'
                ? PrimeShellMetrics.foldedAccountHeight
                : PrimeShellMetrics.sidebarAccountHeight,
          );
          expect(
            find.descendant(of: sidebar, matching: accountTrigger),
            findsOneWidget,
            reason:
                'Vertical account actions must stay inside the sidebar or drawer',
          );
          final previousShadowMode = debugDisableShadows;
          debugDisableShadows = false;
          try {
            await tester.tap(accountTrigger);
            await tester.pumpAndSettle();
          } finally {
            debugDisableShadows = previousShadowMode;
          }
          expect(
            find.widgetWithText(PopupMenuItem<String>, 'Switch role'),
            findsNothing,
          );
          expect(find.text('Sign out'), findsOneWidget);
          final signOutLabel = tester.widget<Text>(find.text('Sign out'));
          expect(signOutLabel.style?.fontSize, 13);
          expect(signOutLabel.style?.fontWeight, FontWeight.w400);
          final signOutItem = find.widgetWithText(
            PopupMenuItem<String>,
            'Sign out',
          );
          expect(
            tester.getSize(signOutItem).height,
            state == 'mobile'
                ? PrimeShellMetrics.accountMenuMobileItemHeight
                : PrimeShellMetrics.accountMenuDesktopItemHeight,
          );
          final accountMenuSurface = find.byWidgetPredicate(
            (widget) =>
                widget is Material &&
                widget.shape == PrimeShellMetrics.accountMenuShape,
            description: 'account menu Material surface',
          );
          expect(accountMenuSurface, findsOneWidget);
          expect(tester.widget<Material>(accountMenuSurface).elevation, 2);
          final accountMenuRect = tester.getRect(accountMenuSurface);
          final signOutIcon = find.descendant(
            of: signOutItem,
            matching: find.byIcon(LucideIcons.squareArrowRightExit),
          );
          expect(tester.getRect(signOutIcon).left - accountMenuRect.left, 8);
          expect(
            accountMenuRect.width,
            PrimeShellMetrics.accountMenuConstraints.minWidth,
          );
          expect(
            accountMenuRect.height,
            state == 'mobile'
                ? PrimeShellMetrics.accountMenuMobileItemHeight
                : PrimeShellMetrics.accountMenuDesktopItemHeight,
          );
          final expectedAccountMenuOrigin = switch (state) {
            'left' => const Offset(267, 932),
            'folded' => const Offset(44, 952),
            'right' => const Offset(1296, 932),
            'mobile' => const Offset(246, 776),
            _ => throw StateError('Unhandled account menu state: $state'),
          };
          expect(accountMenuRect.topLeft, expectedAccountMenuOrigin);
          boxes['accountTrigger'] = box(accountTrigger);
          boxes['accountMenu'] = box(accountMenuSurface);
          await expectLater(
            find.byKey(const Key('sidebar-overlay-proof')),
            matchesGoldenFile(
              'sidebar-state-captures/$id-account-menu-open.png',
            ),
          );
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();
          expect(find.text('Sign out'), findsNothing);
          final selectedShape =
              tester.widget<ListTile>(item).shape as RoundedRectangleBorder;
          expect(selectedShape.side, BorderSide.none);
          expect(
            selectedShape.borderRadius,
            BorderRadius.circular(
              state == 'folded'
                  ? PrimeShellMetrics.foldedSidebarCorner
                  : PrimeShellMetrics.sidebarCorner,
            ),
          );
          final mouse = await tester.createGesture(
            kind: PointerDeviceKind.mouse,
          );
          await mouse.addPointer(location: const Offset(1, 1));
          await mouse.moveTo(tester.getCenter(item));
          await tester.pumpAndSettle();
          await capture('hover');
          await mouse.removePointer();
          await tester.pumpAndSettle();
          bool focused() {
            bool found = false;
            FocusManager.instance.primaryFocus?.context?.visitAncestorElements((
              e,
            ) {
              if (e == tester.element(item)) found = true;
              return !found;
            });
            return found;
          }

          for (var i = 0; i < 20 && !focused(); i++) {
            await tester.sendKeyEvent(LogicalKeyboardKey.tab);
            await tester.pump();
          }
          expect(
            focused(),
            isTrue,
            reason: 'Navigation row must be keyboard reachable',
          );
          await tester.pumpAndSettle();
          await capture('focus');
          final focusedShape =
              tester.widget<ListTile>(item).shape as RoundedRectangleBorder;
          if (state == 'folded') {
            expect(focusedShape.side, BorderSide.none);
          } else {
            expect(
              focusedShape.side.width,
              PrimeShellMetrics.sidebarFocusOutlineWidth,
            );
            expect(
              focusedShape.side.color,
              mode == 'dark'
                  ? Colors.white.withValues(alpha: 0.12)
                  : const Color(0xffd1d5db),
            );
          }
          expect(tester.takeException(), isNull);
          final beforeActivation = navigationAttempts;
          await tester.sendKeyEvent(LogicalKeyboardKey.enter);
          await tester.pumpAndSettle();
          expect(
            router.routeInformationProvider.value.uri.path,
            '/tenant-dashboard',
          );
          expect(
            navigationAttempts,
            greaterThan(beforeActivation),
            reason:
                'Keyboard activation must invoke the existing navigation callback',
          );
          expect(
            router
                .routeInformationProvider
                .value
                .uri
                .queryParameters['enable-semantics'],
            'true',
          );
          if (state == 'mobile')
            expect(
              tester
                  .state<ScaffoldState>(
                    find.byWidgetPredicate((w) => w is Scaffold).first,
                  )
                  .isDrawerOpen,
              isFalse,
            );
          await capture('activated');
          if (state == 'left' || state == 'right') {
            workspace.patch({'navigationWidth': 312});
            await tester.pumpAndSettle();
            final toggle = find.byType(PrimeSidebarFoldButton);
            expect(toggle, findsOneWidget);
            expect(
              find.descendant(
                of: toggle,
                matching: find.byIcon(LucideIcons.panelLeft),
              ),
              findsOneWidget,
            );
            final toggleElement = tester.element(toggle);
            bool toggleFocused() {
              var found = false;
              FocusManager.instance.primaryFocus?.context
                  ?.visitAncestorElements((e) {
                    found = e == toggleElement;
                    return !found;
                  });
              return found;
            }

            for (var i = 0; i < 20 && !toggleFocused(); i++) {
              await tester.sendKeyEvent(LogicalKeyboardKey.tab);
              await tester.pump();
            }
            expect(toggleFocused(), isTrue);
            await tester.sendKeyEvent(LogicalKeyboardKey.enter);
            await tester.pumpAndSettle();
            expect(workspace.current.navigationWidth, 64);
            expect(
              find.descendant(
                of: toggle,
                matching: find.byIcon(LucideIcons.panelLeft),
              ),
              findsOneWidget,
            );
            expect(tester.getSize(sidebar).width, 48);
            await capture('toggle-folded');
            expect(toggleFocused(), isTrue);
            await tester.sendKeyEvent(LogicalKeyboardKey.enter);
            await tester.pumpAndSettle();
            expect(workspace.current.navigationWidth, 312);
            expect(tester.getSize(sidebar).width, 312);
          }
          File('$path/$id.json').writeAsStringSync(
            jsonEncode({
              'case': id,
              'route': '/tenant-dashboard?enable-semantics=true',
              'selected': true,
              'keyboardReachable': true,
              'keyboardActivation': true,
              'sloganVisible': state != 'folded',
              'boxes': boxes,
              'states': [
                'selected',
                'account-menu-open',
                'hover',
                'focus',
                'activated',
              ],
              'accountMenuAuthorized': true,
              'drawerClosedOnActivation': state == 'mobile' ? true : null,
              if (state == 'left' || state == 'right')
                'toggleRestoredWidth': 312,
              'fixtureOnly': true,
              'referenceAligned': false,
              'visualAcceptance': false,
            }),
          );
        } finally {
          semantics.dispose();
        }
      });
    }
}
