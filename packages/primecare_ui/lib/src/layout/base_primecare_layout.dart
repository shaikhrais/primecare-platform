import 'package:flutter/material.dart';

enum PrimecareWindowSize { mobile, tablet, desktop, wide, ultraWide }

/// One window policy for all inherited screens. Widths are logical pixels,
/// not device pixels or physical inches; accessibility scaling stays enabled.
@immutable
class PrimecareLayoutData {
  static const mobileBreakpoint = 600.0;
  final double width;
  const PrimecareLayoutData(this.width);
  PrimecareWindowSize get size => switch (width) {
    < mobileBreakpoint => PrimecareWindowSize.mobile,
    < 1024 => PrimecareWindowSize.tablet,
    < 1920 => PrimecareWindowSize.desktop,
    < 2560 => PrimecareWindowSize.wide,
    _ => PrimecareWindowSize.ultraWide,
  };
  double get padding => switch (size) {
    PrimecareWindowSize.mobile => 12,
    PrimecareWindowSize.tablet => 20,
    PrimecareWindowSize.desktop => 24,
    _ => 32,
  };
  double get maxContentWidth => switch (size) {
    PrimecareWindowSize.mobile || PrimecareWindowSize.tablet => width,
    PrimecareWindowSize.desktop => 1200,
    PrimecareWindowSize.wide => 1440,
    PrimecareWindowSize.ultraWide => 1600,
  };
  double get contentWidth => width.clamp(0, maxContentWidth).toDouble();
  double get fontSizeFactor => size == PrimecareWindowSize.ultraWide ? 1.2 : 1;
  double get dialogWidth => size == PrimecareWindowSize.ultraWide ? 560 : 420;
  EdgeInsets get pageInsets => EdgeInsets.all(padding);
  static bool hasLargeText(BuildContext context) => MediaQuery.textScalerOf(context).scale(16) > 24;
  static PrimecareLayoutData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_LayoutScope>()?.data ??
      PrimecareLayoutData(MediaQuery.sizeOf(context).width);
}

class _LayoutScope extends InheritedWidget {
  final PrimecareLayoutData data;
  const _LayoutScope({required this.data, required super.child});
  @override
  bool updateShouldNotify(_LayoutScope oldWidget) => data.width != oldWidget.data.width;
}

/// Presentation inheritance root. Resizing preserves child widget state.
abstract class BasePrimecareLayout extends StatelessWidget {
  const BasePrimecareLayout({super.key});
  Widget buildLayout(BuildContext context, PrimecareLayoutData layout);
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
    final layout = PrimecareLayoutData(constraints.maxWidth);
    final theme = Theme.of(context);
    return _LayoutScope(data: layout, child: Theme(
      data: theme.copyWith(textTheme: theme.textTheme.apply(fontSizeFactor: layout.fontSizeFactor)),
      child: Builder(builder: (context) => buildLayout(context, layout)),
    ));
  });
}

/// Detail text gets full width on narrow windows or large accessibility text.
/// Actions wrap below it instead of squeezing localized labels off screen.
class PrimecareDetailLayout extends StatelessWidget {
  final Widget details;
  final Widget actions;
  const PrimecareDetailLayout({super.key, required this.details, required this.actions});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, constraints) {
    final stacked = constraints.maxWidth < PrimecareLayoutData.mobileBreakpoint || PrimecareLayoutData.hasLargeText(context);
    return stacked
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [details, const SizedBox(height: 8), actions])
        : Row(children: [Expanded(child: details), const SizedBox(width: 12), actions]);
  });
}

/// Long translated titles and form fields scroll together on short windows.
/// Actions stay outside that scroll area and wrap through Material's dialog.
class PrimecareFormDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final List<Widget> actions;
  const PrimecareFormDialog({super.key, required this.title, required this.content, required this.actions});
  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    title: title,
    content: SizedBox(width: PrimecareLayoutData.of(context).dialogWidth, child: content),
    actions: actions,
  );
}
