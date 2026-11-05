import 'package:flutter/material.dart';

/// Presentation options shared by governed screens. Defaults preserve the
/// existing layout; application and screen owners may opt into individual options.
@immutable
class ScreenFeatureConfig {
  const ScreenFeatureConfig({this.padding = EdgeInsets.zero, this.safeArea = false, this.maxWidth})
      : assert(maxWidth == null || (maxWidth > 0 && maxWidth < double.infinity));

  final EdgeInsetsGeometry padding;
  final bool safeArea;
  final double? maxWidth;

  Widget wrap(Widget child) {
    var result = child;
    if (maxWidth != null) {
      result = Center(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: result));
    }
    if (padding != EdgeInsets.zero) result = Padding(padding: padding, child: result);
    if (safeArea) result = SafeArea(child: result);
    return result;
  }
}

/// Supplies presentation defaults without granting screen or API access.
class ScreenFeatureScope extends InheritedWidget {
  const ScreenFeatureScope({super.key, required this.features, required super.child});
  final ScreenFeatureConfig features;
  static ScreenFeatureConfig of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScreenFeatureScope>()?.features ?? const ScreenFeatureConfig();
  @override
  bool updateShouldNotify(ScreenFeatureScope oldWidget) =>
      features.padding != oldWidget.features.padding || features.safeArea != oldWidget.features.safeArea || features.maxWidth != oldWidget.features.maxWidth;
}

/// A screen may override the application defaults without changing its permissions.
mixin GovernedScreenFeatures {
  ScreenFeatureConfig? get screenFeatures => null;
  Widget applyScreenFeatures(BuildContext context, Widget child) =>
      (screenFeatures ?? ScreenFeatureScope.of(context)).wrap(child);
}
