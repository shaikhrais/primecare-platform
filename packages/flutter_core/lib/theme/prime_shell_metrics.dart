/// Fuse skeleton shell geometry. Tailwind md starts at 48rem (768px).
/// Source: ToolbarLayout1/2 and FooterLayout1/2 min-h-12 md:min-h-16;
/// NavbarLayout2 h-16. These are presentation sizes, never saved permissions.
abstract final class PrimeShellMetrics {
  static const desktopBreakpoint = 768.0;
  static const horizontalNavbarHeight = 64.0;
  static double barHeight(double viewportWidth) => viewportWidth >= desktopBreakpoint ? 64 : 48;
}
