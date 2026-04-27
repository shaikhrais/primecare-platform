// Layer: 01_INFRASTRUCTURE
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';

import 'package:primecare_ui/primecare_ui.dart';

void main() {
  group('Secondary Layout Scaling Verification (Mega-Display Tier)', () {
    testWidgets('AuthSplitLayout card width scales proportionally', (
      tester,
    ) async {
      // Set surface size to avoid MaterialApp scaling
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      // 1. OneK Tier (Baseline - 1.0x Scale)
      final oneKContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.oneK,
              scaleFactor: 1.0,
              sidebarWidth: 280,
              spacingMultiplier: 1.0,
            ),
          ),
        ],
      );

      // Use a placeholder image to avoid network calls in tests
      final placeholderImage = MemoryImage(
        Uint8List.fromList([
          0x47,
          0x49,
          0x46,
          0x38,
          0x39,
          0x61,
          0x01,
          0x00,
          0x01,
          0x00,
          0x80,
          0x00,
          0x00,
          0xFF,
          0xFF,
          0xFF,
          0x00,
          0x00,
          0x00,
          0x21,
          0xf9,
          0x04,
          0x01,
          0x00,
          0x00,
          0x00,
          0x00,
          0x2c,
          0x00,
          0x00,
          0x00,
          0x00,
          0x01,
          0x00,
          0x01,
          0x00,
          0x00,
          0x02,
          0x02,
          0x44,
          0x01,
          0x00,
          0x3b,
        ]),
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: oneKContainer,
          child: MaterialApp(
            home: AuthSplitLayout(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
              backgroundImage: placeholderImage,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      final authPanelFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container && widget.constraints?.maxWidth == 480.0,
      );

      expect(authPanelFinder, findsOneWidget);
      final oneKBox = tester.widget<Container>(authPanelFinder);
      final oneKMaxWidth = oneKBox.constraints?.maxWidth;

      // 2. Mega Tier (3.0x Scale)
      tester.view.physicalSize = const Size(7680, 4320);
      final megaContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.mega,
              scaleFactor: 3.0,
              sidebarWidth: 840,
              spacingMultiplier: 3.0,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: megaContainer,
          child: MaterialApp(
            home: AuthSplitLayout(
              title: 'Test Title',
              subtitle: 'Test Subtitle',
              backgroundImage: placeholderImage,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      final megaPanelFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container && widget.constraints?.maxWidth == 1440.0,
      );

      expect(megaPanelFinder, findsOneWidget);
      final megaBox = tester.widget<Container>(megaPanelFinder);
      final megaMaxWidth = megaBox.constraints?.maxWidth;

      expect(megaMaxWidth, equals(oneKMaxWidth! * 3.0));
    });

    testWidgets('MasterDetailLayout master pane width scales proportionally', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      // 1. OneK Tier
      final oneKContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.oneK,
              scaleFactor: 1.0,
              sidebarWidth: 280,
              spacingMultiplier: 1.0,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: oneKContainer,
          child: MaterialApp(
            home: MasterDetailLayout(
              masterList: const SizedBox(),
              detailView: const SizedBox(),
              isDetailActive: false,
              onBackToMaster: () {},
            ),
          ),
        ),
      );

      final oneKWidthFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container && widget.constraints?.maxWidth == 350.0,
      );
      expect(oneKWidthFinder, findsOneWidget);
      final oneKWidth = 350.0;

      // 2. Mega Tier
      tester.view.physicalSize = const Size(7680, 4320);
      final megaContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.mega,
              scaleFactor: 3.0,
              sidebarWidth: 840,
              spacingMultiplier: 3.0,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: megaContainer,
          child: MaterialApp(
            home: MasterDetailLayout(
              masterList: const SizedBox(),
              detailView: const SizedBox(),
              isDetailActive: false,
              onBackToMaster: () {},
            ),
          ),
        ),
      );

      final megaMasterPaneFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container && widget.constraints?.maxWidth == 1050.0,
      );
      expect(megaMasterPaneFinder, findsOneWidget);

      final megaMasterPane = tester.widget<Container>(megaMasterPaneFinder);
      final megaWidth = megaMasterPane.constraints?.maxWidth;
      expect(megaWidth, equals(oneKWidth * 3.0));
    });

    testWidgets('DesktopPaneWrapper maxWidth scales proportionally', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      // 1. OneK Tier
      final oneKContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.oneK,
              scaleFactor: 1.0,
              sidebarWidth: 280,
              spacingMultiplier: 1.0,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: oneKContainer,
          child: const MaterialApp(home: DesktopPaneWrapper(child: SizedBox())),
        ),
      );

      final constrainedBoxFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ConstrainedBox && widget.constraints.maxWidth == 1400.0,
      );
      expect(constrainedBoxFinder, findsOneWidget);

      final oneKBox = tester.widget<ConstrainedBox>(constrainedBoxFinder);
      final oneKMaxWidth = oneKBox.constraints.maxWidth;

      // 2. Mega Tier
      tester.view.physicalSize = const Size(7680, 4320);
      final megaContainer = ProviderContainer(
        overrides: [
          layoutProvider.overrideWith(
            (ref) => const LayoutConfig(
              tier: ResolutionTier.mega,
              scaleFactor: 3.0,
              sidebarWidth: 840,
              spacingMultiplier: 3.0,
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: megaContainer,
          child: const MaterialApp(home: DesktopPaneWrapper(child: SizedBox())),
        ),
      );

      final megaConstrainedBoxFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ConstrainedBox && widget.constraints.maxWidth == 4200.0,
      );
      expect(megaConstrainedBoxFinder, findsOneWidget);

      final megaBox = tester.widget<ConstrainedBox>(megaConstrainedBoxFinder);
      final megaMaxWidth = megaBox.constraints.maxWidth;
      expect(megaMaxWidth, equals(oneKMaxWidth * 3.0));
    });
  });
}
