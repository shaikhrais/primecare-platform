import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'workspace_controller.dart';
import 'workspace_layout.dart';

/// Labels must come from the host's registered, localized resources.
class WorkspaceHandleLabels {
  final String move, resize, instructions;
  const WorkspaceHandleLabels({required this.move, required this.resize, required this.instructions});
}

/// Optional shared renderer. It does not discover routes, grant access, create
/// business panels, or activate an editor on a production host.
class PrimeWorkspaceLayout extends StatefulWidget {
  final WorkspaceController controller;
  final Widget navigation, toolbar, main;
  final Widget? footer;
  final Map<String, Widget> panels;
  final Map<String, WorkspaceHandleLabels> handleLabels;
  final double toolbarExtent, footerExtent, horizontalNavigationExtent;
  PrimeWorkspaceLayout({super.key, required this.controller, required this.navigation,
    required this.toolbar, required this.main, this.footer, required Map<String, Widget> panels,
    Map<String, WorkspaceHandleLabels> handleLabels = const {}, this.toolbarExtent = 56,
    this.footerExtent = 48, this.horizontalNavigationExtent = 144})
      : panels = Map.unmodifiable(panels), handleLabels = Map.unmodifiable(handleLabels);
  @override State<PrimeWorkspaceLayout> createState() => _PrimeWorkspaceLayoutState();
}

class _PrimeWorkspaceLayoutState extends State<PrimeWorkspaceLayout> {
  final _surface = GlobalKey<State<StatefulWidget>>();
  final Map<String, GlobalKey<State<StatefulWidget>>> _keys = {};
  WorkspaceLayout? _gestureStart;
  Offset _origin = Offset.zero, _delta = Offset.zero;
  GlobalKey<State<StatefulWidget>> _key(String id) => _keys.putIfAbsent(id, () => GlobalKey<State<StatefulWidget>>());
  @override void didUpdateWidget(PrimeWorkspaceLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {_keys.clear(); _gestureStart = null;}
  }
  Widget _slot(String id, Widget child, {bool hidden = false}) => ExcludeFocus(
    excluding: hidden, child: Offstage(offstage: hidden,
      child: KeyedSubtree(key: _key(id), child: child)));
  Offset _position(String id) {
    final panel = _key('panel:$id').currentContext?.findRenderObject();
    final root = _surface.currentContext?.findRenderObject();
    return panel is RenderBox && root is RenderBox
      ? panel.localToGlobal(Offset.zero, ancestor: root) : Offset.zero;
  }
  void _start(String id) {
    widget.controller.beginGesture(); _gestureStart = widget.controller.current;
    _origin = _position(id); _delta = Offset.zero;
  }
  void _update(String id, bool resize, Offset delta) {
    final c = widget.controller, before = _gestureStart;
    if (!c.inGesture || before == null) return;
    _delta += delta; final p = before.panels[id]!;
    c.preview(before.panel(id, resize
      ? {'width': (p.width + _delta.dx).round().clamp(180, 1200), 'height': (p.height + _delta.dy).round().clamp(120, 1200)}
      : {'dock': 'floating', 'x': (_origin.dx + _delta.dx).round().clamp(0, 10000), 'y': (_origin.dy + _delta.dy).round().clamp(0, 10000)}));
  }
  void _end({bool cancel = false}) {
    if (widget.controller.inGesture) {
      if (cancel) {widget.controller.cancelGesture();} else {widget.controller.commitGesture();}
    }
    _gestureStart = null;
  }
  void _adjust(String id, bool resize, int dx, int dy, {String? dock}) {
    final c = widget.controller; if (c.inGesture) return;
    if (dock != null) {c.dock(id, dock); return;}
    final p = c.current.panels[id]!, origin = _position(id);
    c.change(c.current.panel(id, resize
      ? {'width': (p.width + dx).clamp(180, 1200), 'height': (p.height + dy).clamp(120, 1200)}
      : {'dock': 'floating', 'x': (origin.dx + dx).round().clamp(0, 10000), 'y': (origin.dy + dy).round().clamp(0, 10000)}));
  }
  Widget _handle(String id, bool resize, WorkspaceHandleLabels labels, bool narrow) {
    final label = resize ? labels.resize : labels.move;
    return Semantics(identifier: resize ? 'workspace-layout-resize' : 'workspace-layout-move',
      label: '$label. ${labels.instructions}', slider: true, enabled: !narrow,
      onIncrease: narrow ? null : () => _adjust(id, resize, 16, 0),
      onDecrease: narrow ? null : () => _adjust(id, resize, -16, 0),
      child: Tooltip(message: '$label. ${labels.instructions}', child: Focus(
        canRequestFocus: !narrow, onKeyEvent: (_, event) {
          if (narrow || (event is! KeyDownEvent && event is! KeyRepeatEvent)) return KeyEventResult.ignored;
          final direction = {
            LogicalKeyboardKey.arrowLeft: (-16, 0, 'left'), LogicalKeyboardKey.arrowRight: (16, 0, 'right'),
            LogicalKeyboardKey.arrowUp: (0, -16, 'top'), LogicalKeyboardKey.arrowDown: (0, 16, 'bottom'),
          }[event.logicalKey];
          if (direction == null) return KeyEventResult.ignored;
          final keyboard = HardwareKeyboard.instance;
          _adjust(id, resize || keyboard.isShiftPressed, direction.$1, direction.$2,
            dock: keyboard.isControlPressed || keyboard.isMetaPressed ? direction.$3 : null);
          return KeyEventResult.handled;
        }, child: GestureDetector(key: ValueKey('workspace-layout-${resize ? 'resize' : 'move'}-$id'),
          onPanStart: narrow ? null : (_) => _start(id),
          onPanUpdate: narrow ? null : (event) => _update(id, resize, event.delta),
          onPanEnd: narrow ? null : (_) => _end(), onPanCancel: narrow ? null : () => _end(cancel: true),
          child: SizedBox(width: 48, height: 48, child: Icon(resize ? Icons.open_in_full : Icons.drag_indicator)),
        ),
      )),
    );
  }
  Widget _panel(String id, Size viewport, bool narrow, {double? width, bool hidden = false}) {
    final p = widget.controller.current.panels[id]!, labels = widget.handleLabels[id];
    return _slot('panel:$id', SizedBox(
      width: width, height: math.min(p.height.toDouble(), viewport.height),
      child: Material(color: Theme.of(context).colorScheme.surface, clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).dividerColor)),
        child: Column(children: [if (labels != null) Row(children: [
          _handle(id, false, labels, narrow), _handle(id, true, labels, narrow),
        ]), Expanded(child: _slot('panel-content:$id', widget.panels[id]!))]),
      ),
    ), hidden: hidden);
  }
  @override Widget build(BuildContext context) {
    final expected = widget.controller.current.panels.keys.toSet();
    if (widget.panels.length != expected.length || !widget.panels.keys.every(expected.contains) ||
        !widget.handleLabels.keys.every(expected.contains)) {
      throw StateError('Workspace slots must exactly match the current authorized panel registry');
    }
    return AnimatedBuilder(animation: widget.controller, builder: (context, _) =>
      SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        final media = MediaQuery.sizeOf(context), narrow = media.width <= 1024;
        final available = Size(constraints.hasBoundedWidth ? constraints.maxWidth : media.width,
          constraints.hasBoundedHeight ? constraints.maxHeight : media.height);
        final p = widget.controller.current;
        final width = p.container == 'boxed' ? math.min(available.width, p.maxWidth.toDouble()) : available.width;
        final viewport = Size(width, available.height);
        final vertical = !narrow && ['left', 'right'].contains(p.navigation);
        final navWidth = math.min(p.navigationWidth.toDouble(), width * .4);
        final stageWidth = width - (vertical ? navWidth : 0);
        final navHeight = math.min(widget.horizontalNavigationExtent, viewport.height * .25);
        final toolHeight = math.min(widget.toolbarExtent, viewport.height * .2);
        final footHeight = math.min(widget.footerExtent, viewport.height * .2);
        final mainHeight = math.max(0.0, viewport.height - toolHeight - (widget.footer != null && p.footer != 'hidden' ? footHeight : 0)
          - (!vertical && p.navigation != 'hidden' ? navHeight : 0));
        Widget navigation() => SizedBox(width: vertical ? navWidth : null,
          height: vertical ? viewport.height : navHeight, child: _slot('navigation', widget.navigation));
        Widget toolbar() => SizedBox(height: toolHeight, child: _slot('toolbar', widget.toolbar));
        Widget footer() => SizedBox(height: footHeight, child: _slot('footer', widget.footer!));
        Widget dock(String dock) {
          final ids = p.panels.keys.where((id) => p.panels[id]!.dock == dock).toList();
          if (ids.isEmpty) return const SizedBox.shrink();
          final side = !narrow && ['left', 'right'].contains(dock);
          final dockWidth = side ? math.min(stageWidth * .25, ids.map((id) => p.panels[id]!.width.toDouble()).reduce(math.max)) : stageWidth;
          return SizedBox(width: dockWidth, child: Column(mainAxisSize: MainAxisSize.min,
            children: [for (final id in ids) _panel(id, viewport, narrow, width: dockWidth)]));
        }
        Widget main() => SizedBox(height: mainHeight, child: Align(alignment: Alignment.topCenter,
          child: ConstrainedBox(constraints: BoxConstraints(maxWidth: p.container == 'content' ? p.maxWidth.toDouble() : double.infinity),
            child: SizedBox.expand(child: _slot('main', widget.main)))));
        final stage = Column(mainAxisSize: MainAxisSize.min, children: [dock('top'),
          if (narrow) ...[dock('left'), main(), dock('right')]
          else Row(crossAxisAlignment: CrossAxisAlignment.start, children: [dock('left'), Expanded(child: main()), dock('right')]),
          dock('bottom'), if (narrow) dock('floating'),
        ]);
        final contentScroll = p.scroll == 'content';
        final toolOutside = contentScroll || p.toolbarStyle == 'sticky';
        final footOutside = contentScroll || p.footer == 'sticky';
        final hasFooter = widget.footer != null && p.footer != 'hidden';
        final scrollChildren = <Widget>[
          if (!toolOutside && p.toolbar == 'top') toolbar(),
          if (!contentScroll && ((!vertical && p.navigation == 'top') || narrow && ['left', 'right'].contains(p.navigation))) navigation(),
          stage,
          if (!contentScroll && !vertical && p.navigation == 'bottom') navigation(),
          if (hasFooter && !footOutside) footer(),
          if (!toolOutside && p.toolbar == 'bottom') toolbar(),
        ];
        final body = Column(children: [
          if (toolOutside && p.toolbar == 'top') toolbar(),
          if (contentScroll && ((!vertical && p.navigation == 'top') || narrow && ['left', 'right'].contains(p.navigation))) navigation(),
          Expanded(child: SingleChildScrollView(key: PageStorageKey('${widget.controller.scope.storageKey}:${p.scroll}'),
            child: Column(mainAxisSize: MainAxisSize.min, children: scrollChildren))),
          if (contentScroll && !vertical && p.navigation == 'bottom') navigation(),
          if (hasFooter && footOutside) footer(),
          if (toolOutside && p.toolbar == 'bottom') toolbar(),
        ]);
        final shell = vertical ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (p.navigation == 'left') navigation(), Expanded(child: body), if (p.navigation == 'right') navigation(),
        ]) : body;
        Widget floating(String id) {
          final panel = p.panels[id]!;
          final w = math.min(panel.width.toDouble(), viewport.width), h = math.min(panel.height.toDouble(), viewport.height);
          return Positioned(left: panel.x.toDouble().clamp(0, math.max(0, viewport.width - w)).toDouble(),
            top: panel.y.toDouble().clamp(0, math.max(0, viewport.height - h)).toDouble(), width: w, height: h,
            child: _panel(id, viewport, narrow, width: w));
        }
        return Align(alignment: Alignment.topCenter, child: SizedBox(key: _surface,
          width: width, height: viewport.height, child: ClipRect(child: Focus(onKeyEvent: (_, event) {
            if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape && widget.controller.inGesture) {
              _end(cancel: true); return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          }, child: Stack(children: [Positioned.fill(child: shell),
            if (p.navigation == 'hidden') _slot('navigation', widget.navigation, hidden: true),
            if (widget.footer != null && p.footer == 'hidden') _slot('footer', widget.footer!, hidden: true),
            for (final id in p.panels.keys)
              if (p.panels[id]!.dock == 'hidden') _panel(id, viewport, narrow, hidden: true)
              else if (!narrow && p.panels[id]!.dock == 'floating') floating(id),
          ]))),
        ));
      })),
    );
  }
}
