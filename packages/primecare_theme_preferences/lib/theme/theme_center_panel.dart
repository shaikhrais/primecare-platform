import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeAlertDialog, PrimeDropdownButtonFormField, PrimeFilledButton, PrimeListTile, PrimePopupMenuButton, PrimeSlider;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeSnackBar;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextField;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeOutlinedButton, PrimeTextButton;
import 'package:primecare_theme/theme/theme_center_text_generated.dart';
import 'package:primecare_theme/theme/theme_center_options_generated.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter/material.dart';import 'package:flutter/services.dart';import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_theme/theme/personal_theme.dart';import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';import 'theme_library_provider.dart';import 'theme_settings_provider.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon;
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
typedef ThemeCenterLiveText = String Function(BuildContext context,String screen,String language,String key,String fallback,{required Map<String,String> args});
String resolvedThemeCenterText(ThemeCenterLiveText liveScreenText,BuildContext context,String key,{Map<String,String> args=const {}}) {
 final language=Localizations.localeOf(context).languageCode;
 final fallback=themeCenterScreenCatalog[language]?[key]??themeCenterOptions[language]?[key]??themeCenterScreenCatalog['en']?[key]??themeCenterOptions['en']?[key];
 if(fallback==null)throw ArgumentError.value(key,'key','Unknown Theme Center resource');
 return liveScreenText(context,'theme_center',language,key,fallback,args:args);
}

/// Toolbar access to the existing, account-scoped Theme Center text scale.
abstract class PrimeToolbarTextScaleBase extends ConsumerWidget {
  final Color foreground;
  const PrimeToolbarTextScaleBase({super.key, required this.foreground});
  String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}});
  ThemeSettingsState watchSettings(WidgetRef ref);
  PersonalThemeSettingsSession bindSettings(WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = watchSettings(ref).theme.fontScale;
    final account = bindSettings(ref);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String percentage(double scale) => NumberFormat.decimalPercentPattern(
      locale: locale,
      decimalDigits: (scale * 100) % 1 == 0 ? 0 : 1,
    ).format(scale);
    return PrimePopupMenuButton<double>(
      tooltip: themeCenterText(context, 'text_scale'),
      icon: PrimeIcon(LucideIcons.aLargeSmall, color: foreground),
      onSelected: (scale) async {
        try {
          await account.updateTextScale(scale);
        } catch (_) {
          if (context.mounted) {
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(PrimeSnackBar(
              content: PrimeText(themeCenterText(context,
                'unable_to_save_or_apply_use_a_unique_name_and_valid_settings')),
            ));
          }
        }
      },
      itemBuilder: (context) => [
        for (final scale in [.875, 1.0, 1.125, 1.25, 1.375, 1.5])
          PopupMenuItem(
            value: scale,
            child: Semantics(selected: scale == current, child: PrimeText(percentage(scale))),
          ),
      ],
    );
  }
}

abstract class ThemeCenterPanelBase extends ConsumerWidget {
 const ThemeCenterPanelBase({super.key});
 String themeCenterText(BuildContext context,String key,{Map<String,String> args=const {}});
 ThemeSettingsState watchSettings(WidgetRef ref);
 List<SavedPersonalTheme> watchLibrary(WidgetRef ref);
 PersonalThemeSettingsSession bindSettings(WidgetRef ref);
 ThemeLibrarySession bindLibrary(WidgetRef ref);
 Future<void> _run(BuildContext context,Future<void> Function() action) async {try{await action();}catch(_){if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(PrimeSnackBar(content:PrimeText(themeCenterText(context,'unable_to_save_or_apply_use_a_unique_name_and_valid_settings'))));}}
 Future<String?> _name(BuildContext context,String initial) async {final controller=TextEditingController(text:initial);final result=await showDialog<String>(context:context,builder:(c)=>PrimeAlertDialog(title:PrimeText(themeCenterText(context,'theme_name')),content:PrimeTextField(controller:controller,maxLength:60,autofocus:true),actions:[PrimeTextButton(onPressed:()=>Navigator.pop(c),child:PrimeText(themeCenterText(context,'cancel'))),PrimeFilledButton(onPressed:()=>Navigator.pop(c,controller.text),child:PrimeText(themeCenterText(context,'save')))]));controller.dispose();return result;}
 Future<PersonalTheme?> _edit(BuildContext context,PersonalTheme initial) async {
  final controllers={for(final key in themeCenterColorKeys)key:TextEditingController(text:initial.colors[key]??'')};var font=initial.fontFamily,scale=initial.fontScale,radius=initial.radius;
  final result=await showDialog<PersonalTheme>(context:context,builder:(c)=>StatefulBuilder(builder:(c,setState)=>PrimeAlertDialog(title:PrimeText(themeCenterText(context,'edit_theme')),content:SizedBox(width:420,child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[PrimeDropdownButtonFormField<String>(initialValue:font,decoration:InputDecoration(labelText:themeCenterText(context,'font')),items:['system','serif','monospace'].map((f)=>DropdownMenuItem(value:f,child:PrimeText(themeCenterText(context,'font.$f')))).toList(),onChanged:(v)=>setState(()=>font=v!)),PrimeText('${themeCenterText(context,'text_scale')}: ${scale.toStringAsFixed(3)}'),PrimeSlider(value:scale,min:.875,max:1.5,divisions:5,onChanged:(v)=>setState(()=>scale=v)),PrimeText('${themeCenterText(context,'corner_radius')}: $radius'),PrimeSlider(value:radius.toDouble(),min:0,max:24,divisions:24,onChanged:(v)=>setState(()=>radius=v.round())),...themeCenterColorKeys.map((key)=>PrimeTextField(controller:controllers[key],maxLength:7,decoration:InputDecoration(labelText:themeCenterText(context,'color.$key'),hintText:'#RRGGBB'))),PrimeText(themeCenterText(context,'leave_colors_empty_to_inherit_the_palette_text_contrast_adjusts_automa'))]))),actions:[PrimeTextButton(onPressed:()=>Navigator.pop(c),child:PrimeText(themeCenterText(context,'cancel'))),PrimeFilledButton(onPressed:(){try{final theme=PersonalTheme(name:initial.name,preset:initial.preset,fontFamily:font,fontScale:scale,radius:radius,colors:{for(final entry in controllers.entries)if(entry.value.text.trim().isNotEmpty)entry.key:entry.value.text.trim()}).validated();Navigator.pop(c,theme);}catch(_){ScaffoldMessenger.of(c).showSnackBar(PrimeSnackBar(content:PrimeText(themeCenterText(c,'invalidColor'))));}},child:PrimeText(themeCenterText(context,'apply')))])));
  for(final c in controllers.values)c.dispose();return result;
 }
 @override Widget build(BuildContext context,WidgetRef ref) {
  final current=watchSettings(ref).theme,items=watchLibrary(ref);final settings=bindSettings(ref),library=bindLibrary(ref);
  return Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[PrimeText(themeCenterText(context,'theme_center_heading'),style:Theme.of(context).textTheme.titleMedium),PrimeText(themeCenterText(context,'personal_themes_are_saved_for_this_account_and_role_on_this_device')),Wrap(spacing:8,children:[PrimeOutlinedButton(onPressed:()=>_run(context,()async{final edited=await _edit(context,current);if(edited!=null)await settings.applyPersonalTheme(edited);}),child:PrimeText(themeCenterText(context,'edit_current'))),PrimeFilledButton(onPressed:()=>_run(context,()async{final name=await _name(context,current.name);if(name!=null)await library.save(current.named(name));}),child:PrimeText(themeCenterText(context,'save_as_new'))),PrimeOutlinedButton(onPressed:()=>_run(context,()async{await Clipboard.setData(ClipboardData(text:current.exportJson()));if(context.mounted)ScaffoldMessenger.of(context).showSnackBar(PrimeSnackBar(content:PrimeText(themeCenterText(context,'theme_json_copied'))));}),child:PrimeText(themeCenterText(context,'export'))),PrimeOutlinedButton(onPressed:()=>_run(context,()async{final controller=TextEditingController();final value=await showDialog<String>(context:context,builder:(c)=>PrimeAlertDialog(title:PrimeText(themeCenterText(context,'import_theme_json')),content:PrimeTextField(controller:controller,maxLength:16384,maxLines:8),actions:[PrimeTextButton(onPressed:()=>Navigator.pop(c),child:PrimeText(themeCenterText(context,'cancel'))),PrimeFilledButton(onPressed:()=>Navigator.pop(c,controller.text),child:PrimeText(themeCenterText(context,'import')))]));controller.dispose();if(value!=null)await settings.applyPersonalTheme(PersonalTheme.importJson(value));}),child:PrimeText(themeCenterText(context,'import')))]),...items.map((item)=>PrimeListTile(title:PrimeText(item.theme.name),subtitle:PrimeText(item.theme.preset),onTap:()=>_run(context,()=>settings.applyPersonalTheme(item.theme)),trailing:PrimePopupMenuButton<String>(onSelected:(action)=>_run(context,()async{if(action=='delete'){await library.remove(item.id);return;}if(action=='update'){await library.save(current.named(item.theme.name),id:item.id);return;}final name=await _name(context,action=='duplicate'?themeCenterText(context,'copyName',args:{'name':item.theme.name}):item.theme.name);if(name==null)return;if(action=='rename'){await library.rename(item.id,name);if(current.name==item.theme.name)await settings.applyPersonalTheme(current.named(name));}else await library.duplicate(item.id,name);}),itemBuilder:(c)=>[PopupMenuItem(value:'update',child:PrimeText(themeCenterText(context,'update_from_current'))),PopupMenuItem(value:'rename',child:PrimeText(themeCenterText(context,'rename'))),PopupMenuItem(value:'duplicate',child:PrimeText(themeCenterText(context,'duplicate'))),PopupMenuItem(value:'delete',child:PrimeText(themeCenterText(context,'delete')))]))),const SizedBox(height:24)]);
 }
}
