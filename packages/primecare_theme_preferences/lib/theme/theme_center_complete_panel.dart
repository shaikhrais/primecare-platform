import 'package:primecare_models/src/models/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'package:primecare_preferences/providers/persistence_providers.dart';
import 'package:primecare_theme/workspace/portal_workspace.dart';
import 'package:primecare_layout/workspace/workspace_files.dart';
import 'package:primecare_theme/theme/personal_theme.dart';
import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';
import 'package:primecare_theme/theme/theme_center_settings_file.dart';
import 'theme_settings_provider.dart';

/// The complete-profile controls live once, inside the shared Theme Center.
abstract class ThemeCenterCompletePanelBase extends ConsumerWidget {
  final bool actionsOnly;
  const ThemeCenterCompletePanelBase({super.key,this.actionsOnly=false});
  AuthState watchAccount(WidgetRef ref);
  AuthState readAccount(WidgetRef ref);
  ThemeSettingsState watchSettings(WidgetRef ref);
  ThemeSettingsState readSettings(WidgetRef ref);
  ThemeSettingsNotifierBase readNotifier(WidgetRef ref);
  @override Widget build(BuildContext context, WidgetRef ref) {
    final auth=watchAccount(ref);
    final owner=themeAccountScope(auth);
    final settings=watchSettings(ref);
    final notifier=readNotifier(ref);
    final workspace=PortalWorkspaceScope.maybeOf(context);
    final preferences=ref.watch(sharedPreferencesProvider);
    final identity=workspace?.scope.storageKey;
    final ownsWorkspace=hasThemeAccount(auth) && workspace!=null &&
      workspace.scope.user==auth.userId && workspace.scope.tenant==auth.tenantId;
    bool isCurrent() => context.mounted && ownsWorkspace &&
      themeAccountScope(readAccount(ref))==owner &&
      identical(PortalWorkspaceScope.maybeOf(context), workspace);
    ThemeCenterSettingsFile snapshot() {
      if(!isCurrent())throw StateError('Personal workspace changed');
      return ThemeCenterSettingsFile(appearance:readSettings(ref),layout:workspace!.current);
    }
    Future<void> run(Future<String> Function() action) async {
      final messenger=ScaffoldMessenger.maybeOf(context);
      try {final message=await action();if(context.mounted)messenger?.showSnackBar(PrimeSnackBar(content:PrimeText(message)));}
      catch (_) {if(context.mounted)messenger?.showSnackBar(const PrimeSnackBar(content:PrimeText('Unable to apply or save settings. Check the file and try again.')));}
    }
    Future<void> apply(String source) async {
      final parsed=ThemeCenterSettingsFile.parse(source,workspace!.defaults.panels.keys);
      if(!isCurrent() || workspace.inGesture)throw StateError('Workspace changed');
      // Validate the whole file before either controller is changed. Account-scoped
      // appearance persistence rejects account switches during its asynchronous write.
      await notifier.replaceSettings(parsed.appearance);
      if(!isCurrent())throw StateError('Workspace changed');
      workspace.change(parsed.layout);
    }
    Widget palette(String section) {
      final main=section=='main';
      final selected=main?settings.theme.preset:settings.sectionThemes[section]?.preset ?? 'inherit';
      return Padding(padding:const EdgeInsets.symmetric(vertical:6),child:PrimeDropdownButtonFormField<String>(
        key:ValueKey('section-$section-$selected'),initialValue:selected,isExpanded:true,
        decoration:InputDecoration(labelText:'${section[0].toUpperCase()}${section.substring(1)} palette',isDense:true,border:const OutlineInputBorder()),
        items:[if(!main)const DropdownMenuItem(value:'inherit',child:PrimeText('Inherit main palette')),
          for(final preset in themeCenterPresetNames)DropdownMenuItem(value:preset,child:PrimeText(preset))],
        onChanged:(value) {if(value!=null)run(()async {
          if(!isCurrent())throw StateError('Personal workspace changed');
          if(main) {await notifier.updatePreset(value);} else {
            await notifier.updateSectionTheme(section,value=='inherit'?null:PersonalTheme(name:section,preset:value));
          }
          return 'Palette applied.';
        });}));
    }
    return Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
      if(!actionsOnly) ...[
      const PrimeText('MY THEME SETTINGS'),
      const PrimeText('Your preferences are separate from other users. Save and load your profile on this device, or transfer it using a settings file.'),
      for(final section in ['main','navbar','toolbar','footer'])palette(section),
      ],
      if(workspace!=null)...[
        Wrap(spacing:8,runSpacing:4,children:[
          PrimeTextButton(onPressed:()=>run(()async {await Clipboard.setData(ClipboardData(text:snapshot().exportJson()));return 'Complete settings JSON copied.';}),child:const PrimeText('Copy all settings')),
          if(WorkspaceFiles.canExportFile)PrimeTextButton(onPressed:()=>run(()async {
            return await WorkspaceFiles.exportJson(snapshot().exportJson(),filename:'primecare-theme-settings.json')?'Complete settings file exported.':'Export cancelled.';
          }),child:const PrimeText('Export all settings')),
          PrimeTextButton(onPressed:()=>showDialog<void>(context:context,builder:(_)=>_CompleteSettingsImport(onApply:apply)),child:const PrimeText('Paste all settings')),
          PrimeTextButton(onPressed:()=>run(()async {
            final source=await WorkspaceFiles.importJson(maxBytes:65536);
            if(source==null)return 'Import cancelled.';
            await apply(source);return 'Complete settings applied. Save all to retain the layout.';
          }),child:const PrimeText('Import all settings')),
          PrimeTextButton(onPressed:!ownsWorkspace || workspace.preferences==null || preferences==null?null:()=>run(()async {
            final source=snapshot().exportJson();
            await workspace.save();
            if(!isCurrent() || !await preferences.setString('theme_center_complete_v1:$identity',source))throw StateError('Unable to save settings');
            return 'Complete settings saved on this device.';
          }),child:const PrimeText('Save all')),
          PrimeTextButton(onPressed:!ownsWorkspace || workspace.preferences==null || preferences==null?null:()=>run(()async {
            if(!isCurrent())throw StateError('Personal workspace changed');
            final source=preferences.getString('theme_center_complete_v1:$identity');
            if(source==null)return 'No complete settings profile saved.';
            await apply(source);return 'Complete settings loaded.';
          }),child:const PrimeText('Load all')),
        ]),
        if(!actionsOnly) const PrimeText('One file contains current palettes, typography, colors, direction, scrollbar preference and layout. Named theme-library entries are separate. No business data or access rules are included.'),
      ],
      const SizedBox(height:24),
    ]);
  }
}

class _CompleteSettingsImport extends StatefulWidget {
  final Future<void> Function(String) onApply;
  const _CompleteSettingsImport({required this.onApply});
  @override State<_CompleteSettingsImport> createState()=>_CompleteSettingsImportState();
}
class _CompleteSettingsImportState extends State<_CompleteSettingsImport> {
  final input=TextEditingController();
  String? error;
  bool busy=false;
  @override void dispose(){input.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>PrimeAlertDialog(
    title:const PrimeText('Import complete theme settings'),
    content:SizedBox(width:480,child:PrimeTextField(controller:input,maxLines:8,maxLength:65536,
      enabled:!busy,decoration:InputDecoration(hintText:'Paste complete settings JSON',errorText:error))),
    actions:[
      PrimeTextButton(onPressed:busy?null:()=>Navigator.pop(context),child:const PrimeText('Cancel')),
      PrimeTextButton(onPressed:busy?null:()async {
        setState(()=>busy=true);
        try {await widget.onApply(input.text);if(context.mounted)Navigator.pop(context);}
        catch(_){if(mounted)setState((){busy=false;error='Invalid settings or settings could not be saved.';});}
      },child:PrimeText(busy?'Applying…':'Apply')),
    ]);
}
