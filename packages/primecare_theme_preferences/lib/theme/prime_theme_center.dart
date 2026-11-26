import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'package:primecare_models/src/models/auth_state.dart';
import 'package:primecare_preferences/providers/persistence_providers.dart';
import 'package:primecare_theme/workspace/portal_workspace.dart';
import 'package:primecare_theme/theme/personal_theme.dart';
import 'package:primecare_theme/theme/navbar_style_text_generated.dart';
import 'package:primecare_theme/theme/prime_palette_editor.dart';
import 'package:primecare_theme/theme/prime_theme_center_style.dart';
import 'package:primecare_theme/theme/prime_shell_metrics.dart';
import 'package:primecare_theme/theme/theme_center_catalog_generated.dart';
import 'package:primecare_theme/theme/theme_center_settings_file.dart';
import 'theme_settings_provider.dart';

/// Owned Dart presentation matching the grouped Fuse settings reference.
abstract class PrimeThemeCenterBase extends ConsumerWidget {
  final String tenantDefaultPreset;
  const PrimeThemeCenterBase({super.key,required this.tenantDefaultPreset});
  AuthState watchAccount(WidgetRef ref);
  AuthState readAccount(WidgetRef ref);
  ThemeSettingsState watchSettings(WidgetRef ref);
  ThemeSettingsNotifierBase readNotifier(WidgetRef ref);
  Widget completePanel();
  Widget savedPanel();
  Future<void> _run(BuildContext context,Future<void> Function() action)async{
    try{await action();}catch(_){if(context.mounted)ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      const PrimeSnackBar(content:PrimeText('Settings could not be saved. Please try again.')));}
  }
  @override Widget build(BuildContext context,WidgetRef ref){
    final personal=watchSettings(ref).theme;
    return Theme(data:PrimeThemeCenterStyle.resolve(Theme.of(context),family:personal.fontFamily,scale:personal.fontScale),
      child:Builder(builder:(context)=>_build(context,ref)));
  }
  Widget _build(BuildContext context,WidgetRef ref){
    final settings=watchSettings(ref),notifier=readNotifier(ref);
    final c=PortalWorkspaceScope.maybeOf(context),p=c?.current,theme=Theme.of(context);
    final matchedCombinations=themeCenterColorCombinations.entries.where((entry)=>settings.theme.colors.isEmpty&&entry.value['main']==settings.theme.preset&&['navbar','toolbar','footer'].every((part)=>entry.value[part]==(settings.sectionThemes[part]??settings.theme).preset&&(settings.sectionThemes[part]??settings.theme).colors.isEmpty));
    final selectedCombination=matchedCombinations.isEmpty?null:matchedCombinations.first.key;
    final auth=watchAccount(ref),owner=themeAccountScope(readAccount(ref));
    final navbarSession=notifier.bindAccount();
    final navbarText=navbarStyleText[Localizations.localeOf(context).languageCode]??navbarStyleText['en']!;
    final horizontal=['top','bottom'].contains(p?.navigation)||p?.navigation=='hidden'&&settings.layoutStyle==LayoutStyle.horizontal;
    final family=c==null?(settings.layoutStyle==LayoutStyle.horizontal?'2':'1'):horizontal?(p!.scroll=='content'?'3':'2'):'1';
    void patch(Map<String,Object?> value){if(c!=null)c.patch(value);}
    void display(String part,bool visible,String current,String fallback){
      _run(context,()async{
        if(!visible)await notifier.rememberChrome(part,current);
        if(!context.mounted||themeAccountScope(readAccount(ref))!=owner)return;
        patch({part:visible?(settings.hiddenChrome[part]??fallback):'hidden'});
      });
    }
    void position(String part,String current,String value){
      if(current=='hidden'){_run(context,()=>notifier.rememberChrome(part,value));}else{patch({part:value});}
    }
    void chooseFamily(String value){
      _run(context,()async{
        await notifier.updateLayoutStyle(value=='1'?LayoutStyle.verticalLeft:LayoutStyle.horizontal);
        if(!context.mounted||themeAccountScope(readAccount(ref))!=owner)return;
        patch({'navigation':value=='1'?'left':'top','navigationWidth':PrimeShellMetrics.expandedNavigationWidth,'container':'content','maxWidth':1120,
          'toolbar':value=='1'?'top':'belowNavigation','toolbarStyle':value=='1'?'sticky':'static','footer':'sticky','scroll':value=='3'?'content':'page'});
      });
    }
    Widget choices(String label,String value,Map<String,String> values,void Function(String) change,{bool vertical=false,bool last=false})=>
      PrimeSettingsChoices(label:label,value:value,choices:values,onChanged:change,vertical:vertical,last:last);
    Widget toggle(String label,bool value,ValueChanged<bool> change,{bool last=false})=>Padding(padding:EdgeInsets.only(top:6,bottom:last?0:6),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[PrimeText(label,style:theme.textTheme.labelLarge?.copyWith(color:theme.colorScheme.onSurfaceVariant)),PrimeSettingsSwitch(label:label,value:value,onChanged:change)]));
    Future<void> save()async{
      final prefs=ref.read(sharedPreferencesProvider);
      if(c==null||c.preferences==null||prefs==null||!hasThemeAccount(auth)||c.scope.user!=auth.userId||c.scope.tenant!=auth.tenantId)throw StateError('Personal workspace unavailable');
      final source=ThemeCenterSettingsFile(appearance:settings,layout:c.current).exportJson();
      await c.save();
      if(!context.mounted||themeAccountScope(readAccount(ref))!=owner||!await prefs.setString('theme_center_complete_v1:${c.scope.storageKey}',source))throw StateError('Account changed');
      if(context.mounted)ScaffoldMessenger.maybeOf(context)?.showSnackBar(const PrimeSnackBar(content:PrimeText('Your settings are saved.')));
    }
    return PrimeDrawer(width:math.min(PrimeThemeCenterStyle.panelWidth,MediaQuery.sizeOf(context).width*.9),shape:const RoundedRectangleBorder(),
      child:SafeArea(child:Stack(children:[Column(children:[
        Expanded(child:ListView(key:const Key('theme-settings-scroll'),padding:EdgeInsets.all(PrimeThemeCenterStyle.inset(MediaQuery.sizeOf(context).width)),children:[
          PrimeText('Theme Settings',style:theme.textTheme.titleLarge),
          const SizedBox(height:32),
          PrimeSettingsGroup(key:const Key('theme-settings-layout'),label:'Layout',first:true,children:[
            choices('Style',family,{'1':'Layout 1 - Vertical','2':'Layout 2 - Horizontal','3':'Layout 3 - Horizontal'},chooseFamily,vertical:true),
            if(p!=null)...[
              choices('Mode',p.container,{'boxed':'Boxed','fullwidth':'Full width','content':'Container'},(v)=>patch({'container':v})),
              PrimeSettingsNumber(label:'Container Width (px)',value:p.maxWidth,min:960,max:1920,onChanged:(v)=>patch({'maxWidth':v})),
            ],
          if(p!=null)...[
            PrimeSettingsGroup(label:'Navbar',children:[
              toggle('Display',p.navigation!='hidden',(v)=>display('navigation',v,p.navigation,horizontal?'top':settings.layoutStyle==LayoutStyle.verticalRight?'right':'left')),
              if(horizontal&&p.navigation!='bottom')Semantics(key:const Key('theme-navbar-style'),identifier:'theme-navbar-style',label:navbarText['label'],container:true,child:
                choices(navbarText['style']!,settings.navbarStyle??(p.scroll=='content'||p.toolbar=='belowNavigation'?'fixed':'static'),{'fixed':navbarText['fixed']!,'static':navbarText['static']!},(v)=>_run(context,()=>navbarSession.updateNavbarStyle(v)),last:true)),
              if(!horizontal)...[
                choices('Position',(p.navigation=='hidden'?settings.hiddenChrome['navigation']:p.navigation)=='right'?'right':'left',{'left':'Left','right':'Right'},(v)=>_run(context,()async{
                  if(p.navigation=='hidden'){await notifier.rememberChrome('navigation',v);}else{patch({'navigation':v});}
                  if(context.mounted&&themeAccountScope(readAccount(ref))==owner)await notifier.updateLayoutStyle(v=='right'?LayoutStyle.verticalRight:LayoutStyle.verticalLeft);
                })),
                choices('Style',settings.navigationStyle,{'slide':'Slide','tabbed':'Tabbed'},(v)=>_run(context,()=>notifier.updateNavigationStyle(v))),
                toggle('Tabbed Folded (default)',p.navigationWidth==64,(v)=>patch({'navigationWidth':v?64:c?.expandedNavigationWidth??PrimeShellMetrics.expandedNavigationWidth}),last:true),
              ],
            ]),
            PrimeSettingsGroup(label:'Toolbar',children:[
              toggle('Display',p.toolbar!='hidden',(v)=>display('toolbar',v,p.toolbar,horizontal?'belowNavigation':'top')),
              if(horizontal)choices('Position',(p.toolbar=='hidden'?settings.hiddenChrome['toolbar']:p.toolbar)??'top',{'top':'Above','belowNavigation':'Below',if(p.toolbar=='bottom'||p.toolbar=='hidden'&&settings.hiddenChrome['toolbar']=='bottom')'bottom':'Bottom'},(v)=>position('toolbar',p.toolbar,v)),
              choices('Style',p.toolbarStyle,{'sticky':'Fixed','static':'Static'},(v)=>patch({'toolbarStyle':v}),last:true),
            ]),
            PrimeSettingsGroup(label:'Footer',children:[
              toggle('Display',p.footer!='hidden',(v)=>display('footer',v,p.footer,'sticky')),
              choices('Style',(p.footer=='hidden'?settings.hiddenChrome['footer']:p.footer)??'sticky',{'sticky':'Fixed','static':'Static'},(v)=>position('footer',p.footer,v),last:true),
            ]),
          ],
          Padding(padding:const EdgeInsets.symmetric(vertical:16),child:PrimeText('*Not all option combinations are available',style:theme.textTheme.bodySmall?.copyWith(fontSize:12,fontStyle:FontStyle.italic,color:theme.colorScheme.onSurfaceVariant))),
          ]),
          PrimeSettingsGroup(key:const Key('theme-settings-palette'),label:'Theme',children:[
            LayoutBuilder(builder:(context,constraints){
              return Wrap(spacing:16,runSpacing:0,children:[for(final region in ['main','navbar','toolbar','footer'])SizedBox(width:128,
                child:PrimePaletteTile(key:Key('palette-$region'),section:region,theme:settings.sectionThemes[region]??settings.theme,
                  onPressed:()=>_run(context,()async{
                    final selected=await showDialog<PersonalTheme>(context:context,builder:(_)=>PrimePaletteEditor(section:region,initial:settings.sectionThemes[region]??settings.theme,inherited:region!='main'&&!settings.sectionThemes.containsKey(region)));
                    if(selected==null||!context.mounted||themeAccountScope(readAccount(ref))!=owner)return;
                    if(region=='main'){await notifier.applyPersonalTheme(selected);}else{await notifier.updateSectionTheme(region,selected);}
                  }))) ]);
            }),
            const SizedBox(height:16),
          ]),
          toggle('Custom Scrollbars',settings.customScrollbars,(v)=>_run(context,()=>notifier.toggleScrollbars(v))),
          choices('Direction',settings.direction==TextDirection.rtl?'rtl':'ltr',{'rtl':'RTL','ltr':'LTR'},(v)=>_run(context,()=>notifier.updateDirection(v=='rtl'?TextDirection.rtl:TextDirection.ltr)),last:true),
          Padding(padding:const EdgeInsets.symmetric(vertical:32),child:PrimeFilledButton(onPressed:c==null?null:()=>_run(context,()async{
            final source=ThemeCenterSettingsFile(appearance:settings,layout:c.current).exportJson();
            await showDialog<void>(context:context,builder:(context)=>PrimeAlertDialog(title:const PrimeText('Theme settings JSON'),
              content:SizedBox(width:600,child:SingleChildScrollView(child:SelectionArea(child:PrimeText(source,style:theme.textTheme.bodySmall?.copyWith(fontFamily:'monospace'))))),
              actions:[PrimeTextButton(onPressed:()=>Navigator.pop(context),child:const PrimeText('Close'))]));
          }),child:const Row(mainAxisAlignment:MainAxisAlignment.center,children:[PrimeIcon(Icons.code,size:16),SizedBox(width:8),PrimeText('View settings JSON')]))),
          ExpansionTile(title:const PrimeText('Color combinations'),tilePadding:EdgeInsets.zero,children:[
            PrimeDropdownButtonFormField<String>(key:ValueKey(selectedCombination),initialValue:selectedCombination,isExpanded:true,decoration:const InputDecoration(labelText:'Color combination',isDense:true,border:OutlineInputBorder()),
              items:[for(final name in themeCenterColorCombinations.keys)DropdownMenuItem(value:name,child:PrimeText(name))],
              onChanged:(name){if(name!=null)_run(context,()=>notifier.applyColorCombination(name));}),
            const SizedBox(height:16),
            const SizedBox(height:12),
            if(settings.sectionThemes.isNotEmpty)PrimeTextButton(onPressed:()=>_run(context,()async{
              for(final region in ['navbar','toolbar','footer']){if(!context.mounted||themeAccountScope(readAccount(ref))!=owner)return;await notifier.updateSectionTheme(region,null);}
            }),child:const PrimeText('Use main palette for all sections')),
          ]),
          if(p!=null)ExpansionTile(title:const PrimeText('Advanced layout'),tilePadding:EdgeInsets.zero,children:[
            if(horizontal)choices('Position',(p.toolbar=='hidden'?settings.hiddenChrome['toolbar']:p.toolbar)??'top',{'top':'Above','belowNavigation':'Below','bottom':'Bottom'},(v)=>position('toolbar',p.toolbar,v)),
            choices('Scroll',p.scroll,{'page':'Page','content':'Content'},(v)=>patch({'scroll':v})),
            PrimeText('Navigation width · ${p.navigationWidth}px'),
            PrimeSlider(value:p.navigationWidth.clamp(160,400).toDouble(),min:160,max:400,divisions:24,onChanged:p.navigationWidth==64?null:(v)=>patch({'navigationWidth':v.round()})),
            Row(children:[PrimeTextButton(onPressed:c!=null&&c.canUndo?c.undo:null,child:const PrimeText('Undo')),PrimeTextButton(onPressed:c!=null&&c.canRedo?c.redo:null,child:const PrimeText('Redo'))]),
          ]),
          ExpansionTile(title:const PrimeText('My settings · Import & export'),tilePadding:EdgeInsets.zero,children:[completePanel(),
            Padding(padding:const EdgeInsets.symmetric(vertical:12),child:Row(children:[Expanded(child:PrimeOutlinedButton(onPressed:()=>_run(context,()async{await notifier.resetToTenantDefault(tenantDefaultPreset);if(context.mounted&&themeAccountScope(readAccount(ref))==owner)c?.reset();}),child:const PrimeText('Reset'))),const SizedBox(width:12),Expanded(child:PrimeFilledButton(onPressed:c?.preferences!=null&&hasThemeAccount(auth)?()=>_run(context,save):null,child:const PrimeText('Save')))]))]),
          ExpansionTile(title:const PrimeText('Saved themes & typography'),tilePadding:EdgeInsets.zero,children:[savedPanel()]),
        ])),
      ]),PositionedDirectional(top:0,end:0,child:PrimeIconButton(tooltip:'Close theme settings',constraints:const BoxConstraints.tightFor(width:36,height:36),padding:const EdgeInsets.all(10),onPressed:()=>Navigator.of(context).maybePop(),icon:PrimeIcon(Icons.close,size:16,color:theme.colorScheme.onSurfaceVariant)))])));
  }
}

class PrimeSettingsGroup extends StatelessWidget {
  final String label;final List<Widget> children;final bool first;
  const PrimeSettingsGroup({super.key,required this.label,required this.children,this.first=false});
  @override Widget build(BuildContext context){final theme=Theme.of(context);return Padding(padding:EdgeInsets.only(top:first?16:24),child:Stack(clipBehavior:Clip.none,children:[
    Container(width:double.infinity,padding:const EdgeInsets.fromLTRB(12,12,12,0),decoration:BoxDecoration(border:Border.all(color:theme.dividerColor),borderRadius:BorderRadius.circular(2)),
      child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:children)),
    Positioned(left:8,top:-10,child:ColoredBox(color:theme.colorScheme.surface,child:Padding(padding:const EdgeInsets.symmetric(horizontal:4),child:PrimeText(label,style:theme.textTheme.labelLarge?.copyWith(color:theme.colorScheme.onSurfaceVariant,fontWeight:FontWeight.w600))))),
  ]));}
}
class PrimeSettingsChoices extends StatelessWidget {
  final String label,value;final Map<String,String> choices;final ValueChanged<String> onChanged;final bool vertical,last;
  const PrimeSettingsChoices({super.key,required this.label,required this.value,required this.choices,required this.onChanged,this.vertical=false,this.last=false});
  @override Widget build(BuildContext context)=>Padding(padding:EdgeInsets.only(top:6,bottom:last?0:6),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    PrimeText(label,style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Theme.of(context).colorScheme.onSurfaceVariant)),
    RadioGroup<String>(groupValue:value,onChanged:(v){if(v!=null)onChanged(v);},child:LayoutBuilder(builder:(context,constraints)=>Wrap(spacing:16,children:[for(final entry in choices.entries)SizedBox(
      width:vertical?constraints.maxWidth:null,child:PrimeSettingsRadio<String>(value:entry.key,label:PrimeText(entry.value),onSelected:()=>onChanged(entry.key)))]))),
  ]));
}
class PrimeSettingsNumber extends StatefulWidget {
  final String label;final int value,min,max;final ValueChanged<int> onChanged;
  const PrimeSettingsNumber({super.key,required this.label,required this.value,required this.min,required this.max,required this.onChanged});
  @override State<PrimeSettingsNumber> createState()=>_PrimeSettingsNumberState();
}
class _PrimeSettingsNumberState extends State<PrimeSettingsNumber>{
  late final controller=TextEditingController(text:widget.value.toString());String? error;
  @override void didUpdateWidget(PrimeSettingsNumber old){
    super.didUpdateWidget(old);
    if(old.value!=widget.value){
      if(controller.text!=widget.value.toString())controller.text=widget.value.toString();
      error=null;
    }else if(old.min!=widget.min||old.max!=widget.max){
      final value=int.tryParse(controller.text);
      error=value==null||value<widget.min||value>widget.max?'${widget.min}–${widget.max}':null;
    }
  }
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(top:6),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[PrimeText(widget.label,style:Theme.of(context).textTheme.labelLarge?.copyWith(fontSize:12,height:2,color:Theme.of(context).colorScheme.onSurfaceVariant)),SizedBox(width:209,height:error==null?32:null,child:PrimeTextField(controller:controller,keyboardType:TextInputType.number,
    style:Theme.of(context).textTheme.bodyMedium?.copyWith(height:1.4375),decoration:InputDecoration(isDense:true,errorText:error),onChanged:(s){final v=int.tryParse(s);setState(()=>error=v==null||v<widget.min||v>widget.max?'${widget.min}–${widget.max}':null);if(error==null)widget.onChanged(v!);}))]));
}
