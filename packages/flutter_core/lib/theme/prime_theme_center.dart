import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import '../auth_service.dart' show authProvider;
import '../providers/persistence_providers.dart';
import '../registry/widgets/theme_center_panel.dart';
import '../workspace/portal_workspace.dart';
import 'personal_theme.dart';
import 'prime_palette_editor.dart';
import 'theme_center_complete_panel.dart';
import 'theme_center_settings_file.dart';
import 'theme_settings_provider.dart';

/// Owned Dart presentation matching the grouped Fuse settings reference.
class PrimeThemeCenter extends ConsumerWidget {
  final String tenantDefaultPreset;
  const PrimeThemeCenter({super.key,required this.tenantDefaultPreset});
  Future<void> _run(BuildContext context,Future<void> Function() action)async{
    try{await action();}catch(_){if(context.mounted)ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      const PrimeSnackBar(content:PrimeText('Settings could not be saved. Please try again.')));}
  }
  @override Widget build(BuildContext context,WidgetRef ref){
    final settings=ref.watch(themeSettingsProvider),notifier=ref.read(themeSettingsProvider.notifier);
    final c=PortalWorkspaceScope.maybeOf(context),p=c?.current,theme=Theme.of(context);
    final auth=ref.watch(authProvider),owner=themeAccountScope(ref.read(authProvider));
    final horizontal=['top','bottom'].contains(p?.navigation)||p?.navigation=='hidden'&&settings.layoutStyle==LayoutStyle.horizontal;
    final family=c==null?(settings.layoutStyle==LayoutStyle.horizontal?'2':'1'):horizontal?(p!.scroll=='content'?'3':'2'):'1';
    void patch(Map<String,Object?> value){if(c!=null)c.patch(value);}
    void display(String part,bool visible,String current,String fallback){
      _run(context,()async{
        if(!visible)await notifier.rememberChrome(part,current);
        if(!context.mounted||themeAccountScope(ref.read(authProvider))!=owner)return;
        patch({part:visible?(settings.hiddenChrome[part]??fallback):'hidden'});
      });
    }
    void position(String part,String current,String value){
      if(current=='hidden'){_run(context,()=>notifier.rememberChrome(part,value));}else{patch({part:value});}
    }
    void chooseFamily(String value){
      _run(context,()async{
        await notifier.updateLayoutStyle(value=='1'?LayoutStyle.verticalLeft:LayoutStyle.horizontal);
        if(!context.mounted||themeAccountScope(ref.read(authProvider))!=owner)return;
        patch({'navigation':value=='1'?'left':'top','navigationWidth':248,'container':'content','maxWidth':1120,
          'toolbar':value=='1'?'top':'belowNavigation','toolbarStyle':value=='1'?'sticky':'static','footer':'sticky','scroll':value=='3'?'content':'page'});
      });
    }
    Widget choices(String label,String value,Map<String,String> values,void Function(String) change,{bool vertical=false})=>
      PrimeSettingsChoices(label:label,value:value,choices:values,onChanged:change,vertical:vertical);
    Widget toggle(String label,bool value,ValueChanged<bool> change)=>PrimeSwitchListTile(
      title:PrimeText(label),value:value,onChanged:change,dense:true,contentPadding:EdgeInsets.zero);
    Future<void> save()async{
      final prefs=ref.read(sharedPreferencesProvider);
      if(c==null||c.preferences==null||prefs==null||!hasThemeAccount(auth)||c.scope.user!=auth.userId||c.scope.tenant!=auth.tenantId)throw StateError('Personal workspace unavailable');
      final source=ThemeCenterSettingsFile(appearance:settings,layout:c.current).exportJson();
      await c.save();
      if(!context.mounted||themeAccountScope(ref.read(authProvider))!=owner||!await prefs.setString('theme_center_complete_v1:${c.scope.storageKey}',source))throw StateError('Account changed');
      if(context.mounted)ScaffoldMessenger.maybeOf(context)?.showSnackBar(const PrimeSnackBar(content:PrimeText('Your settings are saved.')));
    }
    return PrimeDrawer(width:math.min(380.0,MediaQuery.sizeOf(context).width*.9),shape:const RoundedRectangleBorder(),
      child:SafeArea(child:Column(children:[
        Padding(padding:const EdgeInsets.fromLTRB(24,12,8,4),child:Row(children:[
          Expanded(child:PrimeText('Theme Settings',style:theme.textTheme.titleLarge?.copyWith(fontWeight:FontWeight.w600))),
          PrimeIconButton(tooltip:'Close theme settings',onPressed:()=>Navigator.of(context).maybePop(),icon:const PrimeIcon(Icons.close,size:22)),
        ])),
        Expanded(child:ListView(key:const Key('theme-settings-scroll'),padding:const EdgeInsets.fromLTRB(24,8,24,24),children:[
          PrimeSettingsGroup(key:const Key('theme-settings-layout'),label:'Layout',children:[
            choices('Style',family,{'1':'Layout 1 – Vertical','2':'Layout 2 – Horizontal','3':'Layout 3 – Horizontal'},chooseFamily,vertical:true),
            if(p!=null)...[
              choices('Mode',p.container,{'boxed':'Boxed','fullwidth':'Full width','content':'Container'},(v)=>patch({'container':v})),
              PrimeSettingsNumber(label:'Container Width (px)',value:p.maxWidth,min:960,max:1920,onChanged:(v)=>patch({'maxWidth':v})),
            ],
          ]),
          if(p!=null)...[
            PrimeSettingsGroup(label:'Navbar',children:[
              toggle('Display',p.navigation!='hidden',(v)=>display('navigation',v,p.navigation,horizontal?'top':settings.layoutStyle==LayoutStyle.verticalRight?'right':'left')),
              if(!horizontal)...[
                choices('Position',(p.navigation=='hidden'?settings.hiddenChrome['navigation']:p.navigation)=='right'?'right':'left',{'left':'Left','right':'Right'},(v)=>_run(context,()async{
                  if(p.navigation=='hidden'){await notifier.rememberChrome('navigation',v);}else{patch({'navigation':v});}
                  if(context.mounted&&themeAccountScope(ref.read(authProvider))==owner)await notifier.updateLayoutStyle(v=='right'?LayoutStyle.verticalRight:LayoutStyle.verticalLeft);
                })),
                choices('Style',settings.navigationStyle,{'slide':'Slide','tabbed':'Tabbed'},(v)=>_run(context,()=>notifier.updateNavigationStyle(v))),
                toggle('Folded',p.navigationWidth==64,(v)=>patch({'navigationWidth':v?64:248})),
              ],
            ]),
            PrimeSettingsGroup(label:'Toolbar',children:[
              toggle('Display',p.toolbar!='hidden',(v)=>display('toolbar',v,p.toolbar,horizontal?'belowNavigation':'top')),
              if(horizontal)choices('Position',(p.toolbar=='hidden'?settings.hiddenChrome['toolbar']:p.toolbar)??'top',{'top':'Above','belowNavigation':'Below','bottom':'Bottom'},(v)=>position('toolbar',p.toolbar,v)),
              choices('Style',p.toolbarStyle,{'sticky':'Fixed','static':'Static'},(v)=>patch({'toolbarStyle':v})),
            ]),
            PrimeSettingsGroup(label:'Footer',children:[
              toggle('Display',p.footer!='hidden',(v)=>display('footer',v,p.footer,'sticky')),
              choices('Style',(p.footer=='hidden'?settings.hiddenChrome['footer']:p.footer)??'sticky',{'sticky':'Fixed','static':'Static'},(v)=>position('footer',p.footer,v)),
            ]),
          ],
          PrimeSettingsGroup(key:const Key('theme-settings-palette'),label:'Theme',children:[
            LayoutBuilder(builder:(context,constraints){final width=(constraints.maxWidth-16)/2;
              return Wrap(spacing:16,runSpacing:16,children:[for(final region in ['main','navbar','toolbar','footer'])SizedBox(width:width,
                child:PrimePaletteTile(key:Key('palette-$region'),section:region,theme:settings.sectionThemes[region]??settings.theme,
                  onPressed:()=>_run(context,()async{
                    final selected=await showDialog<PersonalTheme>(context:context,builder:(_)=>PrimePaletteEditor(section:region,initial:settings.sectionThemes[region]??settings.theme,inherited:region!='main'&&!settings.sectionThemes.containsKey(region)));
                    if(selected==null||!context.mounted||themeAccountScope(ref.read(authProvider))!=owner)return;
                    if(region=='main'){await notifier.applyPersonalTheme(selected);}else{await notifier.updateSectionTheme(region,selected);}
                  }))) ]);
            }),
            const SizedBox(height:12),
            if(settings.sectionThemes.isNotEmpty)PrimeTextButton(onPressed:()=>_run(context,()async{
              for(final region in ['navbar','toolbar','footer']){if(!context.mounted||themeAccountScope(ref.read(authProvider))!=owner)return;await notifier.updateSectionTheme(region,null);}
            }),child:const PrimeText('Use main palette for all sections')),
          ]),
          toggle('Custom Scrollbars',settings.customScrollbars,(v)=>_run(context,()=>notifier.toggleScrollbars(v))),
          choices('Direction',settings.direction==TextDirection.rtl?'rtl':'ltr',{'ltr':'LTR','rtl':'RTL'},(v)=>_run(context,()=>notifier.updateDirection(v=='rtl'?TextDirection.rtl:TextDirection.ltr))),
          if(p!=null)ExpansionTile(title:const PrimeText('Advanced layout'),tilePadding:EdgeInsets.zero,children:[
            choices('Scroll',p.scroll,{'page':'Page','content':'Content'},(v)=>patch({'scroll':v})),
            PrimeText('Navigation width · ${p.navigationWidth}px'),
            PrimeSlider(value:p.navigationWidth.clamp(160,400).toDouble(),min:160,max:400,divisions:24,onChanged:p.navigationWidth==64?null:(v)=>patch({'navigationWidth':v.round()})),
            Row(children:[PrimeTextButton(onPressed:c!=null&&c.canUndo?c.undo:null,child:const PrimeText('Undo')),PrimeTextButton(onPressed:c!=null&&c.canRedo?c.redo:null,child:const PrimeText('Redo'))]),
          ]),
          const ExpansionTile(title:PrimeText('My settings · Import & export'),tilePadding:EdgeInsets.zero,children:[ThemeCenterCompletePanel(actionsOnly:true)]),
          const ExpansionTile(title:PrimeText('Saved themes & typography'),tilePadding:EdgeInsets.zero,children:[ThemeCenterPanel()]),
        ])),
        DecoratedBox(decoration:BoxDecoration(border:Border(top:BorderSide(color:theme.dividerColor))),child:Padding(
          padding:const EdgeInsets.symmetric(horizontal:24,vertical:12),child:Row(children:[
            Expanded(child:PrimeOutlinedButton(onPressed:()=>_run(context,()async{await notifier.resetToTenantDefault(tenantDefaultPreset);if(context.mounted&&themeAccountScope(ref.read(authProvider))==owner)c?.reset();}),child:const PrimeText('Reset'))),
            const SizedBox(width:12),Expanded(child:PrimeFilledButton(onPressed:c?.preferences!=null&&hasThemeAccount(auth)?()=>_run(context,save):null,child:const PrimeText('Save'))),
          ]))),
      ])));
  }
}

class PrimeSettingsGroup extends StatelessWidget {
  final String label;final List<Widget> children;
  const PrimeSettingsGroup({super.key,required this.label,required this.children});
  @override Widget build(BuildContext context){final theme=Theme.of(context);return Padding(padding:const EdgeInsets.only(top:16,bottom:8),child:Stack(clipBehavior:Clip.none,children:[
    Container(width:double.infinity,padding:const EdgeInsets.fromLTRB(12,16,12,8),decoration:BoxDecoration(border:Border.all(color:theme.dividerColor),borderRadius:BorderRadius.circular(4)),
      child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:children)),
    Positioned(left:8,top:-10,child:ColoredBox(color:theme.colorScheme.surface,child:Padding(padding:const EdgeInsets.symmetric(horizontal:4),child:PrimeText(label,style:theme.textTheme.labelLarge?.copyWith(color:theme.colorScheme.onSurfaceVariant,fontWeight:FontWeight.w600))))),
  ]));}
}
class PrimeSettingsChoices extends StatelessWidget {
  final String label,value;final Map<String,String> choices;final ValueChanged<String> onChanged;final bool vertical;
  const PrimeSettingsChoices({super.key,required this.label,required this.value,required this.choices,required this.onChanged,this.vertical=false});
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:4),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    PrimeText(label,style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Theme.of(context).colorScheme.onSurfaceVariant)),
    RadioGroup<String>(groupValue:value,onChanged:(v){if(v!=null)onChanged(v);},child:LayoutBuilder(builder:(context,constraints)=>Wrap(children:[for(final entry in choices.entries)SizedBox(
      width:vertical?constraints.maxWidth:constraints.maxWidth/(choices.length>2?3:2),child:PrimeRadioListTile<String>(value:entry.key,title:PrimeText(entry.value),dense:true,
        contentPadding:EdgeInsets.zero,visualDensity:VisualDensity.compact))]))),
  ]));
}
class PrimeSettingsNumber extends StatefulWidget {
  final String label;final int value,min,max;final ValueChanged<int> onChanged;
  const PrimeSettingsNumber({super.key,required this.label,required this.value,required this.min,required this.max,required this.onChanged});
  @override State<PrimeSettingsNumber> createState()=>_PrimeSettingsNumberState();
}
class _PrimeSettingsNumberState extends State<PrimeSettingsNumber>{
  late final controller=TextEditingController(text:widget.value.toString());String? error;
  @override void didUpdateWidget(PrimeSettingsNumber old){super.didUpdateWidget(old);if(old.value!=widget.value&&controller.text!=widget.value.toString())controller.text=widget.value.toString();}
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:8),child:PrimeTextField(controller:controller,keyboardType:TextInputType.number,
    decoration:InputDecoration(labelText:widget.label,isDense:true,border:const OutlineInputBorder(),errorText:error),onChanged:(s){final v=int.tryParse(s);setState(()=>error=v==null||v<widget.min||v>widget.max?'${widget.min}–${widget.max}':null);if(error==null)widget.onChanged(v!);}));
}
