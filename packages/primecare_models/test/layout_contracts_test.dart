import 'package:primecare_models/primecare_models.dart';
import 'package:test/test.dart';

void main() {
  test('breakpoint edges and high pixel density retain their exact rules', () {
    expect(ScreenBreakpointPolicy.getTier(767.99), ResolutionTier.mob);
    expect(ScreenBreakpointPolicy.getTier(768), ResolutionTier.tab);
    expect(ScreenBreakpointPolicy.getTier(1024), ResolutionTier.oneK);
    expect(ScreenBreakpointPolicy.getTier(1440), ResolutionTier.twoK);
    expect(ScreenBreakpointPolicy.getTier(2560), ResolutionTier.threeK);
    expect(ScreenBreakpointPolicy.getTier(3840), ResolutionTier.fourK);
    expect(ScreenBreakpointPolicy.getTier(5120), ResolutionTier.mega);
    expect(
      ScreenBreakpointPolicy.getTier(3840, pixelRatio: 4),
      ResolutionTier.mega,
    );
    expect(
      ScreenBreakpointPolicy.getTier(3839, pixelRatio: 4),
      ResolutionTier.threeK,
    );
  });

  test('sidebar modes preserve columns, fixed width and grid units', () {
    final expanded = LayoutConfig.fromWidth(1440);
    final collapsed = LayoutConfig.fromWidth(1440, mode: SidebarMode.minimal);
    final hidden = LayoutConfig.fromWidth(1440, mode: SidebarMode.hidden);
    expect(
      [
        expanded.totalColumns,
        expanded.sidebarColumns,
        expanded.sidebarWidth,
        expanded.gridUnitWidth,
      ],
      [16, 3, 260, 90],
    );
    expect([collapsed.sidebarColumns, collapsed.sidebarWidth], [2, 80]);
    expect([hidden.sidebarColumns, hidden.sidebarWidth], [0, 0]);
    expect(expanded.isExtended, isTrue);
    expect(collapsed.isMinimal, isTrue);
    expect(hidden.isHidden, isTrue);
    expect(AdaptiveScalingConfig.getGridColumns(ResolutionTier.twoK), 16);
  });

  test('direct constructors preserve portal and layout defaults', () {
    const portal = PortalConfig(title: 'Client', brandingName: 'PrimeCare');
    expect(portal.isPlain, isTrue);
    const layout = LayoutConfig(
      tier: ResolutionTier.oneK,
      scaleFactor: 1,
      sidebarWidth: 260,
      spacingMultiplier: 1,
    );
    expect(
      [layout.totalColumns, layout.sidebarColumns, layout.screenWidth],
      [12, 2, 1024],
    );
    expect(layout.sidebarMode, SidebarMode.extended);
  });
}
