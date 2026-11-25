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
          data: Theme.of(
            context,
          ).copyWith(focusColor: PrimeShellMetrics.transparentInteractionInk),
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

/// Anchors the wide leading drawer's menu at the trigger's outer top corner.
/// A full-width PopupMenuButton lets Material choose the opposite edge.
class PrimeWideDrawerAccountMenu extends StatefulWidget {
  const PrimeWideDrawerAccountMenu({
    super.key,
    required this.radius,
    required this.brightness,
    required this.tooltip,
    required this.itemBuilder,
    required this.onSelected,
    required this.child,
  });

  final BorderRadius radius;
  final Brightness brightness;
  final String tooltip;
  final PopupMenuItemBuilder<String> itemBuilder;
  final ValueChanged<String> onSelected;
  final Widget child;

  @override
  State<PrimeWideDrawerAccountMenu> createState() =>
      _PrimeWideDrawerAccountMenuState();
}

class _PrimeWideDrawerAccountMenuState
    extends State<PrimeWideDrawerAccountMenu> {
  bool _open = false;

  Future<void> _showMenu() async {
    if (_open) return;
    final trigger = context.findRenderObject();
    final overlay = Navigator.of(context).overlay?.context.findRenderObject();
    if (trigger is! RenderBox || overlay is! RenderBox) return;
    final items = widget.itemBuilder(context);
    if (items.isEmpty) return;

    Offset anchor = trigger.localToGlobal(
      trigger.size.topRight(Offset.zero),
      ancestor: overlay,
    );
    setState(() => _open = true);
    String? selected;
    try {
      selected = await showMenu<String>(
        context: context,
        positionBuilder: (_, constraints) {
          if (trigger.attached && overlay.attached) {
            anchor = trigger.localToGlobal(
              trigger.size.topRight(Offset.zero),
              ancestor: overlay,
            );
          }
          return RelativeRect.fromSize(anchor & Size.zero, constraints.biggest);
        },
        items: items,
        shape: PrimeShellMetrics.accountMenuShape,
        constraints: PrimeShellMetrics.accountMenuConstraints,
        menuPadding: PrimeShellMetrics.accountMenuPadding,
        clipBehavior: Clip.antiAlias,
        elevation: PrimeShellMetrics.accountMenuElevationFor(widget.brightness),
        shadowColor: PrimeShellMetrics.accountMenuShadowFor(widget.brightness),
        surfaceTintColor: PrimeShellMetrics.transparentInteractionInk,
      );
    } finally {
      if (mounted) setState(() => _open = false);
    }
    if (mounted && selected != null) widget.onSelected(selected);
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    expanded: _open,
    child: Tooltip(
      message: widget.tooltip,
      child: InkWell(
        borderRadius: widget.radius,
        onTap: _showMenu,
        child: widget.child,
      ),
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
    data: widget.menuTheme.copyWith(
      hoverColor: PrimeShellMetrics.accountMenuHoverFill(widget.menuTheme),
    ),
    child: Material(
      type: MaterialType.transparency,
      borderRadius: PrimeShellMetrics.accountMenuItemRadius,
      clipBehavior: Clip.antiAlias,
      child: Builder(builder: super.build),
    ),
  );
}
