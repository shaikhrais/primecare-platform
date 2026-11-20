import 'package:flutter/material.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'personal_theme.dart';
import 'theme_center_catalog_generated.dart';
import 'theme_config_generated.dart';
import 'theme_contrast.dart';

String _hex(Color color)=>'#${color.toARGB32().toRadixString(16).padLeft(8,'0').substring(2)}';
Color? _parse(String text)=>RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(text)?Color(int.parse(text.substring(1),radix:16)|0xff000000):null;
String _title(String name)=>name.replaceAllMapped(RegExp(r'([a-z])([A-Z])'),(m)=>'${m[1]} ${m[2]}').replaceAll('Palette','').trim();

class PrimePaletteTile extends StatelessWidget {
  final String section;final PersonalTheme theme;final VoidCallback onPressed;
  const PrimePaletteTile({super.key,required this.section,required this.theme,required this.onPressed});
  @override Widget build(BuildContext context)=>Semantics(button:true,label:'Edit $section palette',child:InkWell(onTap:onPressed,borderRadius:BorderRadius.circular(6),child:Padding(
    padding:const EdgeInsets.all(4),child:Column(children:[PrimePaletteMiniature(theme:theme,section:section),const SizedBox(height:8),
      PrimeText('${section[0].toUpperCase()}${section.substring(1)} Palette',maxLines:2,textAlign:TextAlign.center,style:Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight:FontWeight.w600))]))));
}
class PrimePaletteMiniature extends StatelessWidget {
  final PersonalTheme theme;final String section;
  const PrimePaletteMiniature({super.key,required this.theme,this.section='main'});
  @override Widget build(BuildContext context){
    final p=ThemeConfig.getAppPalette(theme.preset),outline=Theme.of(context).dividerColor;
    Color value(String key,Color fallback)=>_parse(theme.colors[key]??'')??fallback;
    final primary=value('primary',p.primary),surface=value('surface',p.surface),background=value('background',p.background),secondary=value('secondary',p.secondary);
    final highlight=secondary.withValues(alpha:.28);
    return Container(width:128,height:80,clipBehavior:Clip.antiAlias,decoration:BoxDecoration(border:Border.all(color:outline),borderRadius:BorderRadius.circular(6)),child:Row(children:[
      Container(width:28,padding:const EdgeInsets.fromLTRB(5,12,5,4),color:section=='navbar'?highlight:value('sidebar',p.sidebarBackground),child:Column(children:[for(var i=0;i<5;i++)Padding(padding:const EdgeInsets.only(bottom:3),child:Container(height:3,color:section=='navbar'?secondary.withValues(alpha:.4):surface.withValues(alpha:.45)))])),
      Expanded(child:Column(children:[
        Container(height:13,color:section=='toolbar'?highlight:value('topbar',p.topbarBackground),padding:const EdgeInsets.only(right:4),child:Row(mainAxisAlignment:MainAxisAlignment.end,children:[for(var i=0;i<3;i++)Padding(padding:const EdgeInsets.only(left:3),child:Container(width:3,height:3,decoration:BoxDecoration(color:primary.withValues(alpha:.5),shape:BoxShape.circle)))])),
        Expanded(child:Container(color:section=='main'?highlight:background,padding:const EdgeInsets.all(7),child:Container(color:surface))),
        Container(height:11,color:section=='footer'?highlight:surface),
      ])),
    ]));
  }
}

/// Palette dialog follows the public Fuse reference: mode, four colors, preview.
class PrimePaletteEditor extends StatefulWidget {
  final String section;final PersonalTheme initial;final bool inherited;
  const PrimePaletteEditor({super.key,required this.section,required this.initial,this.inherited=false});
  @override State<PrimePaletteEditor> createState()=>_PrimePaletteEditorState();
}
class _PrimePaletteEditorState extends State<PrimePaletteEditor>{
  late String preset=widget.initial.preset;
  late final modePreset=widget.initial.preset;
  late bool dark;
  bool presets=false,dirty=false;String? error;
  final fields=<String,TextEditingController>{};
  @override void initState(){super.initState();final p=ThemeConfig.getAppPalette(preset);
    final bar=widget.section=='navbar'?(_parse(widget.initial.colors['sidebar']??'')??p.sidebarBackground):
      widget.section=='toolbar'?(_parse(widget.initial.colors['topbar']??'')??p.topbarBackground):null;
    final background=bar??_parse(widget.initial.colors['background']??'')??p.background;
    final surface=bar!=null&&widget.inherited?bar:_parse(widget.initial.colors['surface']??'')??bar??p.surface;
    dark=background.computeLuminance()<.3;
    final defaults={'primary':_parse(widget.initial.colors['primary']??'')??p.primary,
      'secondary':_parse(widget.initial.colors['secondary']??'')??p.secondary,'surface':surface,'background':background};
    for(final entry in defaults.entries){fields[entry.key]=TextEditingController(text:_hex(entry.value));}
  }
  @override void dispose(){for(final c in fields.values)c.dispose();super.dispose();}
  void mode(bool value){
    if(value==dark)return;
    final paired=themeCenterModePairs[modePreset];
    final next=paired?[value?1:0]??(value?'defaultDark':'default');
    final p=ThemeConfig.getAppPalette(next);
    setState((){
      dark=value;dirty=true;error=null;
      // Unpaired source palettes keep their accent combination when mode changes.
      if(paired!=null){preset=next;fields['primary']!.text=_hex(p.primary);fields['secondary']!.text=_hex(p.secondary);}
      else{preset=next;}
      fields['surface']!.text=_hex(p.surface);fields['background']!.text=_hex(p.background);
    });
  }
  Map<String,String> colors(){final out={...widget.initial.colors};
    if(preset!=widget.initial.preset){out.remove('text');out.remove('muted');}
    for(final entry in fields.entries){out[entry.key]=entry.value.text.trim();}
    if(widget.section=='navbar')out['sidebar']=out['background']!;
    if(widget.section=='toolbar')out['topbar']=out['background']!;
    return out;
  }
  void save(){try{final next=PersonalTheme(name:widget.initial.name,preset:preset,fontFamily:widget.initial.fontFamily,
    fontScale:widget.initial.fontScale,radius:widget.initial.radius,colors:colors()).validated();Navigator.pop(context,next);
  }catch(_){setState(()=>error='Use valid colors with readable, compatible backgrounds.');}}
  Future<void> colorPicker(String field)async{
    final p=ThemeConfig.getAppPalette(preset);var value=_parse(fields[field]!.text)??p.primary;
    final result=await showDialog<Color>(context:context,builder:(context)=>StatefulBuilder(builder:(context,setLocal)=>PrimeAlertDialog(
      title:const PrimeText('Choose color'),content:SizedBox(width:300,child:Column(mainAxisSize:MainAxisSize.min,children:[
        Container(height:56,color:value),const SizedBox(height:12),PrimeText(_hex(value)),
        for(final component in ['Red','Green','Blue'])Row(children:[SizedBox(width:42,child:PrimeText(component)),Expanded(child:PrimeSlider(
          min:0,max:255,divisions:255,value:(component=='Red'?value.r:component=='Green'?value.g:value.b)*255,
          onChanged:(v)=>setLocal(()=>value=Color.fromARGB(255,component=='Red'?v.round():(value.r*255).round(),component=='Green'?v.round():(value.g*255).round(),component=='Blue'?v.round():(value.b*255).round()))))]),
      ])),actions:[PrimeTextButton(onPressed:()=>Navigator.pop(context),child:const PrimeText('Cancel')),
        PrimeFilledButton(onPressed:()=>Navigator.pop(context,value),child:const PrimeText('Use color'))])));
    if(result!=null&&mounted)setState((){fields[field]!.text=_hex(result);dirty=true;error=null;});
  }
  @override Widget build(BuildContext context){
    final theme=Theme.of(context),palette=ThemeConfig.getAppPalette(preset);
    final header=theme.colorScheme.secondary;
    final headerText=readableThemeForeground(header,theme.colorScheme.onSurface);
    final primary=_parse(fields['primary']!.text)??palette.primary,secondary=_parse(fields['secondary']!.text)??palette.secondary;
    final surface=_parse(fields['surface']!.text)??palette.surface,background=_parse(fields['background']!.text)??palette.background;
    Widget inputs()=>Column(mainAxisSize:MainAxisSize.min,children:[
      Row(mainAxisAlignment:MainAxisAlignment.center,children:[
        PrimeOutlinedButton(onPressed:()=>mode(false),style:PrimeOutlinedButton.styleFrom(backgroundColor:!dark?theme.colorScheme.secondary:null,foregroundColor:!dark?theme.colorScheme.onSecondary:null),child:const PrimeText('Light')),
        PrimeOutlinedButton(onPressed:()=>mode(true),style:PrimeOutlinedButton.styleFrom(backgroundColor:dark?theme.colorScheme.secondary:null,foregroundColor:dark?theme.colorScheme.onSecondary:null),child:const PrimeText('Dark')),
      ]),const SizedBox(height:24),
      for(final entry in const {'primary':'Primary color','secondary':'Secondary color','surface':'Background paper','background':'Background default'}.entries)Padding(
        padding:const EdgeInsets.only(bottom:20),child:PrimeTextField(key:Key('palette-color-${entry.key}'),controller:fields[entry.key],maxLength:7,
          decoration:InputDecoration(labelText:entry.value,counterText:'',border:const OutlineInputBorder(),isDense:true,
            prefixIcon:PrimeIconButton(tooltip:'Choose ${entry.value.toLowerCase()}',onPressed:()=>colorPicker(entry.key),
              icon:Container(width:22,height:22,decoration:BoxDecoration(color:_parse(fields[entry.key]!.text)??palette.primary,border:Border.all(color:theme.dividerColor))))),
          onChanged:(_)=>setState((){dirty=true;error=null;}))),
      if(error!=null)PrimeText(error!,style:theme.textTheme.bodySmall?.copyWith(color:theme.colorScheme.error)),
    ]);
    Widget preview()=>Column(mainAxisSize:MainAxisSize.min,children:[PrimeText('Preview',style:theme.textTheme.titleMedium?.copyWith(fontWeight:FontWeight.w600)),
      const SizedBox(height:20),PrimePaletteLivePreview(primary:primary,secondary:secondary,surface:surface,background:background)]);
    return Dialog(insetPadding:const EdgeInsets.all(20),clipBehavior:Clip.antiAlias,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16)),child:RepaintBoundary(key:const Key('palette-editor-capture'),child:ColoredBox(color:theme.colorScheme.surface,child:SizedBox(
      width:640,child:Column(mainAxisSize:MainAxisSize.min,children:[
        Container(color:header,padding:const EdgeInsets.symmetric(horizontal:20,vertical:14),child:Row(children:[PrimeIcon(Icons.palette_outlined,color:headerText),const SizedBox(width:12),
          Expanded(child:PrimeText('Edit palette',style:theme.textTheme.titleLarge?.copyWith(color:headerText))),
          PrimeTextButton(onPressed:()=>setState(()=>presets=!presets),style:PrimeTextButton.styleFrom(foregroundColor:headerText),child:PrimeText(presets?'Customize':'Presets'))])),
        Flexible(child:SingleChildScrollView(child:Padding(padding:const EdgeInsets.all(24),child:presets?
          Wrap(spacing:16,runSpacing:16,children:[for(final name in themeCenterPresetNames)SizedBox(width:128,child:InkWell(onTap:()=>Navigator.pop(context,PersonalTheme(
            name:widget.initial.name,preset:name,fontFamily:widget.initial.fontFamily,fontScale:widget.initial.fontScale,radius:widget.initial.radius).validated()),
            child:Column(children:[PrimePaletteMiniature(theme:PersonalTheme(name:name,preset:name),section:widget.section),const SizedBox(height:6),PrimeText(_title(name),textAlign:TextAlign.center,maxLines:2)])))])
          :LayoutBuilder(builder:(context,limits)=>limits.maxWidth>=500?Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:inputs()),const SizedBox(width:28),Expanded(child:preview())]):Column(mainAxisSize:MainAxisSize.min,children:[inputs(),const SizedBox(height:16),preview()]))))),
        Padding(padding:const EdgeInsets.fromLTRB(16,8,20,16),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
          PrimeTextButton(onPressed:()=>Navigator.pop(context),child:const PrimeText('Cancel')),
          if(!presets)PrimeFilledButton(onPressed:dirty?save:null,child:const PrimeText('Save')),
        ])),
      ])))));
  }
}
class PrimePaletteLivePreview extends StatelessWidget{
  final Color primary,secondary,surface,background;
  const PrimePaletteLivePreview({super.key,required this.primary,required this.secondary,required this.surface,required this.background});
  @override Widget build(BuildContext context)=>SizedBox(width:240,height:220,child:Stack(children:[
    Positioned.fill(top:10,child:Container(decoration:BoxDecoration(color:background,borderRadius:BorderRadius.circular(10),border:Border.all(color:Theme.of(context).dividerColor)))),
    Positioned(left:0,right:0,top:0,height:78,child:Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:primary,borderRadius:BorderRadius.circular(10)),
      child:PrimeText('Header (Primary)',style:TextStyle(color:readableThemeForeground(primary,Theme.of(context).colorScheme.onSurface),fontWeight:FontWeight.w600)))),
    Positioned(left:10,right:26,top:40,bottom:42,child:Material(elevation:2,color:surface,borderRadius:BorderRadius.circular(6),child:Padding(padding:const EdgeInsets.all(12),
      child:PrimeText('Paper',style:TextStyle(color:readableThemeForeground(surface,Theme.of(context).colorScheme.onSurface),fontWeight:FontWeight.w600))))),
    Positioned(right:6,top:60,child:CircleAvatar(radius:13,backgroundColor:secondary,child:PrimeText('S',style:TextStyle(color:readableThemeForeground(secondary,Theme.of(context).colorScheme.onSurface))))),
    Positioned(left:12,bottom:12,child:PrimeText('Background',style:TextStyle(color:readableThemeForeground(background,Theme.of(context).colorScheme.onSurface),fontWeight:FontWeight.w600))),
  ]));
}
