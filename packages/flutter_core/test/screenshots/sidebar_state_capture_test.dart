@Tags(['visual-capture'])
library;

import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PointerDeviceKind, SemanticsFlag;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/providers/persistence_providers.dart';
import 'package:flutter_core/registry/platform_role.dart';
import 'package:flutter_core/registry/widgets/governance_master_layout.dart';
import 'package:flutter_core/theme/theme_settings_provider.dart';
import 'package:flutter_core/theme/personal_theme.dart';
import 'package:flutter_core/workspace/portal_workspace.dart';
import 'theme_center_capture_test.dart' show loadFonts, CaptureAuth;
import 'skeleton_shell_capture_test.dart' show ShellCaptureApplication;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadFonts);
  for (final mode in ['light', 'dark'])
    for (final state in ['left', 'folded', 'right', 'mobile']) {
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
              child: MaterialApp.router(routerConfig: router),
            ),
          );
          await tester.pumpAndSettle();
          final workspace = PortalWorkspaceScope.maybeOf(
            tester.element(find.byKey(const Key('app-shell'))),
          )!;
          workspace.patch({
            'navigation': state == 'right' ? 'right' : 'left',
            'navigationWidth': state == 'folded' ? 64 : 280,
            'footer': 'sticky',
          });
          await tester.pumpAndSettle();
          if (state == 'mobile') {
            tester
                .state<ScaffoldState>(
                  find.byWidgetPredicate((w) => w is Scaffold).first,
                )
                .openDrawer();
            await tester.pumpAndSettle();
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
          File('$path/$id.json').writeAsStringSync(
            jsonEncode({
              'case': id,
              'route': '/tenant-dashboard?enable-semantics=true',
              'selected': true,
              'keyboardReachable': true,
              'keyboardActivation': true,
              'sloganVisible': state != 'folded',
              'boxes': boxes,
              'states': ['selected', 'hover', 'focus'],
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
