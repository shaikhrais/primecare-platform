import 'workspace_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
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
  final Widget Function(BuildContext, WorkspaceController) builder;
  const PortalWorkspace({super.key, required this.scope, this.preferences,
    required this.legacyLayoutStyle, required this.builder});
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
      preferences: widget.preferences, legacyLayoutStyle: widget.legacyLayoutStyle);
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
      choice('Navigation', 'navigation', layout.navigation, ['left','right','top','bottom','hidden']),
      choice('Toolbar position', 'toolbar', layout.toolbar, ['top','bottom']),
      choice('Toolbar scrolling', 'toolbarStyle', layout.toolbarStyle, ['sticky','static']),
      choice('Footer', 'footer', layout.footer, ['sticky','static','hidden']),
      choice('Container', 'container', layout.container, ['fullwidth','boxed','content']),
      choice('Scrolling', 'scroll', layout.scroll, ['page','content']),
      PrimeSwitchListTile(title: const PrimeText('Fold navigation to icons'),
        value: layout.navigationWidth == 64,
        onChanged: (v) => c.patch({'navigationWidth': v ? 64 : 248})),
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
  const PrimePortalTheme({super.key, required this.data, required this.child});
  @override Widget build(BuildContext context) => Theme(data: data, child: child);
}

/// Horizontal navigation uses the same centrally themed label in every portal.
class PrimePortalNavigationLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const PrimePortalNavigationLabel({super.key, required this.icon, required this.label, required this.color});
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      PrimeIcon(icon, size: 16, color: color), const SizedBox(width: 8),
      PrimeText(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color)),
      const SizedBox(width: 4), PrimeIcon(Icons.expand_more, size: 16, color: color),
    ]));
}
