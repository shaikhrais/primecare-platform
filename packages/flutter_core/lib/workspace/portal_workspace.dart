import 'workspace_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import '../theme/app_theme.dart' show GovernanceThemeColors;
import '../theme/prime_shell_metrics.dart';
import '../theme/theme_contrast.dart';
import '../theme/theme_center_options.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'workspace_controller.dart';
export 'workspace_controller.dart';
export 'workspace_preferences.dart';
export 'prime_workspace_layout.dart';

/// One controller per authenticated portal identity. Imported JSON is presentation
/// only: route authorization remains the responsibility of the master shell.
class PortalWorkspace extends StatefulWidget {
  final WorkspaceScope scope;
  final WorkspacePreferences? preferences;
  final String legacyLayoutStyle;
  final int? defaultNavigationWidth;
  final Widget Function(BuildContext, WorkspaceController) builder;
  const PortalWorkspace({super.key, required this.scope, this.preferences,
    required this.legacyLayoutStyle, required this.builder, this.defaultNavigationWidth});
  @override State<PortalWorkspace> createState() => _PortalWorkspaceState();
}
class _PortalWorkspaceState extends State<PortalWorkspace> {
  late WorkspaceController controller;
  @override void initState() {
    super.initState();
    _createController();
  }
  void _createController() {
    controller = WorkspaceController(scope: widget.scope, panelIds: const [],
      preferences: widget.preferences, legacyLayoutStyle: widget.legacyLayoutStyle, defaultNavigationWidth: widget.defaultNavigationWidth);
    if (widget.preferences != null) _restore();
  }
  @override void didUpdateWidget(PortalWorkspace oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scope.storageKey != widget.scope.storageKey ||
        (oldWidget.preferences == null) != (widget.preferences == null)) {
      controller.dispose();
      _createController();
    }
  }
  Future<void> _restore() async {
    final loading = controller;
    try { await loading.load(); } catch (_) {
      if (mounted && identical(loading, controller)) WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && identical(loading, controller)) ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          const PrimeSnackBar(content: PrimeText('Saved layout could not be restored.')));
      });
    }
  }
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => PortalWorkspaceScope(
    controller: controller,
    child: AnimatedBuilder(animation: controller,
      builder: (context, _) => widget.builder(context, controller)));
}
class PortalWorkspaceScope extends InheritedNotifier<WorkspaceController> {
  const PortalWorkspaceScope({super.key, required WorkspaceController controller,
    required super.child}) : super(notifier: controller);
  static WorkspaceController? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<PortalWorkspaceScope>()?.notifier;
}

Future<void> _operation(BuildContext context, Future<String> Function() action) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  try {
    final message = await action();
    if (context.mounted) messenger?.showSnackBar(PrimeSnackBar(content: PrimeText(message)));
  } catch (_) {
    if (context.mounted) messenger?.showSnackBar(
      const PrimeSnackBar(content: PrimeText('Layout operation failed. Your current layout is unchanged.')));
  }
}

/// Compact shared footer. Hidden footers can always be restored in Theme Center.
class PortalLayoutFooter extends StatelessWidget {
  const PortalLayoutFooter({super.key});
  @override Widget build(BuildContext context) {
    final c = PortalWorkspaceScope.maybeOf(context)!;
    return Material(color: Theme.of(context).colorScheme.surface,
      child: Row(children: [
        const SizedBox(width: 8),
        Expanded(child: PrimeText(c.preferences == null ? 'Layout · temporary' : 'Layout · this device',
          maxLines: 1, overflow: TextOverflow.ellipsis)),
        PrimeIconButton(tooltip: 'Undo layout', onPressed: c.canUndo ? c.undo : null,
          icon: const PrimeIcon(Icons.undo, size: 18)),
        PrimeIconButton(tooltip: 'Save layout', onPressed: c.preferences == null ? null : () =>
          _operation(context, () async { await c.save(); return 'Layout saved on this device.'; }),
          icon: const PrimeIcon(Icons.save_outlined, size: 18)),
        PrimeIconButton(tooltip: 'Theme and layout', onPressed: () => Scaffold.of(context).openEndDrawer(),
          icon: const PrimeIcon(Icons.tune, size: 18)),
      ]));
  }
}

class PortalLayoutEditor extends StatelessWidget {
  const PortalLayoutEditor({super.key});
  @override Widget build(BuildContext context) {
    final c = PortalWorkspaceScope.maybeOf(context)!;
    final layout = c.current;
    Widget choice(String label, String field, String value, List<String> values) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: PrimeDropdownButtonFormField<String>(
        initialValue: value, key: ValueKey('$field:$value'), isExpanded: true,
        decoration: InputDecoration(labelText: label, isDense: true, border: const OutlineInputBorder()),
        items: [for (final v in values) DropdownMenuItem(value: v, child: PrimeText(v))],
        onChanged: (v) { if (v != null) c.patch({field: v}); }));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const PrimeText('WORKSPACE LAYOUT'),
      Wrap(spacing: 8, children: [
        PrimeTextButton(onPressed: () => c.patch({'navigation':'left','navigationWidth':c.expandedNavigationWidth,
          'container':'content','maxWidth':1120,'toolbar':'top','toolbarStyle':'sticky','footer':'sticky','scroll':'page'}),
          child: const PrimeText('Vertical')),
        PrimeTextButton(onPressed: () => c.patch({'navigation':'top','container':'content','maxWidth':1120,
          'toolbar':'belowNavigation','toolbarStyle':'static','footer':'sticky','scroll':'page'}),
          child: const PrimeText('Horizontal · page')),
        PrimeTextButton(onPressed: () => c.patch({'navigation':'top','container':'content','maxWidth':1120,
          'toolbar':'belowNavigation','toolbarStyle':'static','footer':'sticky','scroll':'content'}),
          child: const PrimeText('Horizontal · content')),
      ]),
      choice('Navigation', 'navigation', layout.navigation, ['left','right','top','bottom','hidden']),
      choice('Toolbar position', 'toolbar', layout.toolbar, ['top','belowNavigation','bottom']),
      choice('Toolbar scrolling', 'toolbarStyle', layout.toolbarStyle, ['sticky','static']),
      choice('Footer', 'footer', layout.footer, ['sticky','static','hidden']),
      choice('Container', 'container', layout.container, ['fullwidth','boxed','content']),
      choice('Scrolling', 'scroll', layout.scroll, ['page','content']),
      PrimeSwitchListTile(title: const PrimeText('Fold navigation to icons'),
        value: layout.navigationWidth == 64,
        onChanged: (v) => c.patch({'navigationWidth': v ? 64 : c.expandedNavigationWidth})),
      PrimeText('Navigation width · ${layout.navigationWidth}px'),
      PrimeSlider(value: layout.navigationWidth.clamp(160, 400).toDouble(), min: 160, max: 400, divisions: 24,
        onChanged: layout.navigationWidth == 64 ? null : (v) => c.patch({'navigationWidth': v.round()})),
      PrimeText('Maximum content width · ${layout.maxWidth}px'),
      PrimeSlider(value: layout.maxWidth.toDouble(), min: 960, max: 1920, divisions: 24,
        onChanged: (v) => c.patch({'maxWidth': v.round()})),
      Wrap(spacing: 8, runSpacing: 4, children: [
        PrimeTextButton(onPressed: c.canUndo ? c.undo : null, child: const PrimeText('Undo')),
        PrimeTextButton(onPressed: c.canRedo ? c.redo : null, child: const PrimeText('Redo')),
        PrimeTextButton(onPressed: c.reset, child: const PrimeText('Reset')),
        PrimeTextButton(onPressed: c.preferences == null ? null : () => _operation(context, () async {
          await c.save(); return 'Layout saved on this device.';
        }), child: const PrimeText('Save')),
        PrimeTextButton(onPressed: c.preferences == null ? null : () => _operation(context, () async {
          return await c.load() ? 'Saved layout loaded.' : 'No valid saved layout found, or layout changed while loading.';
        }), child: const PrimeText('Load')),
        PrimeTextButton(onPressed: () => _operation(context, () async {
          await Clipboard.setData(ClipboardData(text: c.exportJson())); return 'Layout JSON copied.';
        }), child: const PrimeText('Copy JSON')),
        if (WorkspaceFiles.canExportFile) PrimeTextButton(onPressed: () => _operation(context, () async {
          return await WorkspaceFiles.exportJson(c.exportJson()) ? 'Layout file exported.' : 'Export cancelled.';
        }), child: const PrimeText('Export file')),
        PrimeTextButton(onPressed: () => _operation(context, () async {
          final source = await WorkspaceFiles.importJson();
          if (!context.mounted || source == null) return 'Import cancelled.';
          c.importJson(source); return 'Layout file imported. Save to keep it on this device.';
        }), child: const PrimeText('Import file')),
        PrimeTextButton(onPressed: () => _import(context, c), child: const PrimeText('Import JSON')),
      ]),
      const PrimeText('Settings are scoped to your account, tenant, role and application. Save stores them on this device. JSON contains layout settings only.'),
      const SizedBox(height: 24),
    ]);
  }
  Future<void> _import(BuildContext context, WorkspaceController c) =>
    showDialog<void>(context: context, builder: (_) => _LayoutImportDialog(controller: c));
}

class _LayoutImportDialog extends StatefulWidget {
  final WorkspaceController controller;
  const _LayoutImportDialog({required this.controller});
  @override State<_LayoutImportDialog> createState() => _LayoutImportDialogState();
}
class _LayoutImportDialogState extends State<_LayoutImportDialog> {
  final input = TextEditingController();
  String? error;
  @override void dispose() { input.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => PrimeAlertDialog(
    title: const PrimeText('Import layout JSON'),
    content: SizedBox(width: 480, child: PrimeTextField(controller: input, maxLines: 10,
      maxLength: 32768, decoration: InputDecoration(hintText: 'Paste exported layout JSON', errorText: error))),
    actions: [
      PrimeTextButton(onPressed: () => Navigator.pop(context), child: const PrimeText('Cancel')),
      PrimeTextButton(onPressed: () {
        try { widget.controller.importJson(input.text); Navigator.pop(context); }
        catch (_) { setState(() => error = 'Invalid or incompatible layout JSON.'); }
      }, child: const PrimeText('Apply')),
    ]);
}

/// Shared theme envelope; all shell appearance derives from Theme Center data.
class PrimePortalTheme extends StatelessWidget {
  final ThemeData data;
  final Widget child;
  final bool? customScrollbars;
  const PrimePortalTheme({super.key, required this.data, required this.child, this.customScrollbars});
  @override Widget build(BuildContext context) => Theme(data: data,
    child: customScrollbars == null ? child : ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: customScrollbars), child: child));
}

/// The toolbar shortcut uses the same reversible fold setting as the editor.
class PrimeSidebarFoldButton extends StatelessWidget {
  final WorkspaceController controller;
  final Color foreground;
  const PrimeSidebarFoldButton({
    super.key,
    required this.controller,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final folded = controller.current.navigationWidth ==
        PrimeShellMetrics.foldedNavigationMarker;
    final leading = controller.current.navigation == 'left';
    final icon = leading
        ? (folded ? LucideIcons.panelLeftOpen : LucideIcons.panelLeftClose)
        : (folded ? LucideIcons.panelRightOpen : LucideIcons.panelRightClose);
    return Semantics(
      container: true,
      expanded: !folded,
      child: Center(
        child: PrimeIconButton(
          icon: PrimeIcon(
            icon,
            size: PrimeShellMetrics.sidebarIconExtent,
            color: foreground,
          ),
          tooltip: themeCenterOption(context, 'color.sidebar'),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(
            width: PrimeShellMetrics.sidebarToggleSize,
            height: PrimeShellMetrics.sidebarToggleSize,
          ),
          onPressed: () => controller.patch({
            'navigationWidth': folded
                ? controller.expandedNavigationWidth
                : PrimeShellMetrics.foldedNavigationMarker,
          }),
        ),
      ),
    );
  }
}

/// Horizontal navigation uses the same centrally themed label in every portal.
class PrimePortalNavigationLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool showExpand;
  const PrimePortalNavigationLabel({super.key, required this.icon, required this.label, required this.color, this.showExpand = true});
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      PrimeIcon(icon, size: 16, color: color), const SizedBox(width: 8),
      PrimeText(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color)),
      if (showExpand) ...[
        const SizedBox(width: 4),
        PrimeIcon(Icons.expand_more, size: 16, color: color),
      ],
    ]));
}

/// Retains access to Theme Settings when imported layouts hide their toolbar.
class PrimeWorkspaceRecovery extends StatelessWidget {
  final bool show;final Widget child;
  const PrimeWorkspaceRecovery({super.key,required this.show,required this.child});
  @override Widget build(BuildContext context)=>Stack(children:[Positioned.fill(child:child),
    if(show)PositionedDirectional(end:0,top:16,child:Material(elevation:3,color:Theme.of(context).colorScheme.surface,
      borderRadius:const BorderRadiusDirectional.horizontal(start:Radius.circular(12)),child:PrimeIconButton(
        tooltip:'Theme settings',onPressed:()=>Scaffold.of(context).openEndDrawer(),icon:const PrimeIcon(Icons.settings_outlined)))),
  ]);
}
class PrimeNavigationEntry {
  final String label;final VoidCallback onPressed;
  const PrimeNavigationEntry(this.label,this.onPressed);
}
class PrimeNavigationTab {
  final String label;final IconData icon;final Widget content;final List<PrimeNavigationEntry> entries;
  const PrimeNavigationTab({required this.label,required this.icon,required this.content,required this.entries});
}
/// The host supplies only authorized navigation destinations and content.
class PrimeTabbedNavigation extends StatefulWidget {
  final List<PrimeNavigationTab> tabs;final int initialIndex;
  final Widget? railHeader;
  const PrimeTabbedNavigation({super.key,required this.tabs,this.initialIndex=0,this.railHeader});
  @override State<PrimeTabbedNavigation> createState()=>_PrimeTabbedNavigationState();
}
class _PrimeTabbedNavigationState extends State<PrimeTabbedNavigation>{
  late int selected=widget.initialIndex;
  @override void didUpdateWidget(PrimeTabbedNavigation old){super.didUpdateWidget(old);
    if(old.initialIndex!=widget.initialIndex)selected=widget.initialIndex;
    if(selected>=widget.tabs.length)selected=0;
  }
  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sidebar = theme.extension<GovernanceThemeColors>();
    final foldedSurface = sidebar?.sidebarBackground ?? scheme.surfaceContainerLow;
    final ink = readableThemeForeground(foldedSurface, scheme.onSurface);
    final foldedSelection = PrimeShellMetrics.sidebarSelectionFill(
      background: foldedSurface, foreground: ink, brightness: theme.brightness,
    );
    return LayoutBuilder(builder: (context, limits) {
      final folded = limits.maxWidth <= 96;
      return Row(children: [
        Container(
          width: folded ? limits.maxWidth : 48,
          color: folded ? foldedSurface : scheme.surfaceContainerLow,
          child: ListView(children: [
            if (folded && widget.railHeader != null) widget.railHeader!,
            for (var i = 0; i < widget.tabs.length; i++)
              Semantics(
                container: folded,
                label: folded ? widget.tabs[i].label : null,
                selected: i == selected,
                child: folded
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          if (i == selected)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: foldedSelection,
                                borderRadius: PrimeShellMetrics.navigationItemRadius,
                              ),
                              child: const SizedBox.square(
                                dimension: PrimeShellMetrics.sidebarRowHeight,
                              ),
                            ),
                          PrimePopupMenuButton<int>(
                            tooltip: widget.tabs[i].label,
                            icon: PrimeIcon(
                              widget.tabs[i].icon,
                              size: PrimeShellMetrics.sidebarIconExtent,
                              color: readableThemeForeground(
                                i == selected ? foldedSelection : foldedSurface,
                                sidebar?.sidebarIconColor ?? ink,
                              ),
                            ),
                            itemBuilder: (context) => [
                              for (var j = 0; j < widget.tabs[i].entries.length; j++)
                                PopupMenuItem(value: j, child: PrimeText(widget.tabs[i].entries[j].label)),
                            ],
                            onSelected: (j) => widget.tabs[i].entries[j].onPressed(),
                          ),
                        ],
                      )
                    : Container(
                        color: i == selected ? scheme.primaryContainer : null,
                        child: PrimeIconButton(
                          tooltip: widget.tabs[i].label,
                          onPressed: () => setState(() => selected = i),
                          icon: PrimeIcon(widget.tabs[i].icon, size: 20,
                            color: i == selected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant),
                        ),
                      ),
              ),
          ]),
        ),
        if (!folded) Expanded(child: widget.tabs[selected].content),
      ]);
    });
  }
}
