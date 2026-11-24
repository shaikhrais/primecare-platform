import 'package:flutter/material.dart';

import 'prime_shell_metrics.dart';

/// Paints the focus of the existing popup trigger without adding a tab stop.
class PrimeAccountTriggerFocusFrame extends StatefulWidget {
  const PrimeAccountTriggerFocusFrame({
    super.key,
    required this.radius,
    required this.surface,
    required this.child,
  });

  final BorderRadius radius;
  final Color surface;
  final Widget child;

  static const outlineKey = ValueKey('account-trigger-focus-outline');

  @override
  State<PrimeAccountTriggerFocusFrame> createState() =>
      _PrimeAccountTriggerFocusFrameState();
}

class _PrimeAccountTriggerFocusFrameState
    extends State<PrimeAccountTriggerFocusFrame> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addHighlightModeListener(_highlightModeChanged);
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(_highlightModeChanged);
    super.dispose();
  }

  void _highlightModeChanged(FocusHighlightMode mode) {
    if (_focused) setState(() {});
  }

  @override
  Widget build(BuildContext context) => Focus(
    canRequestFocus: false,
    skipTraversal: true,
    includeSemantics: false,
    onFocusChange: (focused) => setState(() => _focused = focused),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            focusColor: PrimeShellMetrics.transparentInteractionInk,
          ),
          child: widget.child,
        ),
        if (_focused &&
            FocusManager.instance.highlightMode ==
                FocusHighlightMode.traditional)
          Positioned.fill(
            left: -PrimeShellMetrics.accountFocusOutlineExtent,
            top: -PrimeShellMetrics.accountFocusOutlineExtent,
            right: -PrimeShellMetrics.accountFocusOutlineExtent,
            bottom: -PrimeShellMetrics.accountFocusOutlineExtent,
            child: IgnorePointer(
              child: DecoratedBox(
                key: PrimeAccountTriggerFocusFrame.outlineKey,
                decoration: PrimeShellMetrics.accountFocusDecoration(
                  Theme.of(context),
                  widget.radius,
                  widget.surface,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

/// Retains the menu's keyboard highlight when its trigger uses an outline.
class PrimeAccountMenuItem<T> extends PopupMenuItem<T> {
  const PrimeAccountMenuItem({
    super.key,
    required this.menuTheme,
    super.padding,
    super.height,
    super.value,
    required super.child,
  });

  final ThemeData menuTheme;

  @override
  PopupMenuItemState<T, PrimeAccountMenuItem<T>> createState() =>
      _PrimeAccountMenuItemState<T>();
}

class _PrimeAccountMenuItemState<T>
    extends PopupMenuItemState<T, PrimeAccountMenuItem<T>> {
  @override
  Widget build(BuildContext context) => Theme(
    data: widget.menuTheme,
    child: Builder(builder: super.build),
  );
}
