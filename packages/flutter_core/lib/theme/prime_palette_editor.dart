import 'package:flutter/material.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';
import 'personal_theme.dart';
import 'theme_center_catalog_generated.dart';
import 'theme_config_generated.dart';
import 'theme_contrast.dart';
import 'prime_theme_center_style.dart';

String _hex(Color color)=>'#${color.toARGB32().toRadixString(16).padLeft(8,'0').substring(2)}';
Color? _parse(String text)=>RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(text)?Color(int.parse(text.substring(1),radix:16)|0xff000000):null;
String _title(String name)=>name.replaceAllMapped(RegExp(r'([a-z])([A-Z])'),(m)=>'${m[1]} ${m[2]}').replaceAll('Palette','').trim();

class PrimePaletteTile extends StatelessWidget {
  final String section;final PersonalTheme theme;final VoidCallback onPressed;
  const PrimePaletteTile({super.key,required this.section,required this.theme,required this.onPressed});
  @override Widget build(BuildContext context)=>Semantics(button:true,label:'Edit $section palette',child:InkWell(onTap:onPressed,borderRadius:BorderRadius.circular(6),child:Padding(
    padding:const EdgeInsets.symmetric(vertical:8),child:Column(children:[PrimePaletteMiniature(theme:theme,section:section,schematic:true),const SizedBox(height:8),
      PrimeText('${section[0].toUpperCase()}${section.substring(1)} Palette',maxLines:2,textAlign:TextAlign.center,style:Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight:FontWeight.w600,color:Theme.of(context).colorScheme.onSurface.withValues(alpha:.8))),const SizedBox(height:24)]))));
}
class PrimePaletteMiniature extends StatelessWidget {
  final PersonalTheme theme;final String section;final bool schematic;
  const PrimePaletteMiniature({super.key,required this.theme,this.section='main',this.schematic=false});
  @override Widget build(BuildContext context){
    if(schematic){
      final c=Theme.of(context).colorScheme;
      final base=Theme.of(context).scaffoldBackgroundColor;
      final neutral=Color.lerp(base,Colors.white,c.brightness==Brightness.light?.4:.02)!;
      final highlight=c.secondary.withValues(alpha:.3);
      Color fill(String region)=>section==region?highlight:neutral;
      Color line(String region)=>section==region?highlight:c.outline;
      Widget dots(String region)=>Row(children:[for(var i=0;i<3;i++)Padding(padding:const EdgeInsets.only(left:4),child:Container(width:4,height:4,decoration:BoxDecoration(color:line(region),shape:BoxShape.circle)))]);
      return Container(width:128,height:80,clipBehavior:Clip.antiAlias,decoration:BoxDecoration(border:Border.all(color:c.outline),borderRadius:BorderRadius.circular(6)),child:Row(children:[
        Container(width:31,padding:const EdgeInsets.fromLTRB(6,12,6,0),color:fill('navbar'),child:Column(children:[for(var i=0;i<5;i++)Padding(padding:const EdgeInsets.only(bottom:1),child:Container(height:4,decoration:BoxDecoration(color:line('navbar'),borderRadius:BorderRadius.circular(2))))])),
        Expanded(child:Container(decoration:BoxDecoration(border:Border(left:BorderSide(color:c.outline))),child:Column(children:[
          Container(height:12,color:fill('toolbar'),padding:const EdgeInsets.only(right:6),alignment:Alignment.centerRight,child:dots('toolbar')),
          Expanded(child:Container(decoration:BoxDecoration(color:fill('main'),border:Border.symmetric(horizontal:BorderSide(color:c.outline))))),
          Container(height:12,color:fill('footer'),padding:const EdgeInsets.only(right:6),alignment:Alignment.centerLeft,child:dots('footer')),
        ]))),
      ]));
    }
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
  Map<String,String>? modeOverrides;
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
    final overrides=themeCenterModeOverrides[value?'dark':'light']!;
    setState((){
      dark=value;dirty=true;error=null;preset=next;modeOverrides=overrides;
      fields['surface']!.text=overrides['surface']!;fields['background']!.text=overrides['background']!;
    });
  }
  Map<String,String> colors(){final out={...widget.initial.colors};
    if(modeOverrides!=null){out.addAll(modeOverrides!);final border=modeOverrides!['border']!;if(!border.startsWith('#'))out['border']='#2d2d2e';}
    if(preset!=widget.initial.preset&&modeOverrides==null){out.remove('text');out.remove('muted');}
    for(final entry in fields.entries){out[entry.key]=entry.value.text.trim();}
    if(widget.section=='navbar')out['sidebar']=out['background']!;
    if(widget.section=='toolbar')out['topbar']=out['background']!;
    return out;
  }
  void save(){try{final next=PersonalTheme(name:widget.initial.name,preset:preset,fontFamily:widget.initial.fontFamily,
    fontScale:widget.initial.fontScale,radius:widget.initial.radius,colors:colors()).validated();Navigator.pop(context,next);
  }catch(_){setState(()=>error='Use valid colors with readable, compatible backgrounds.');}}
  Future<void> colorPicker(String field)async{
    final p=ThemeConfig.getAppPalette(preset);var value=_parse(fields[field]!.text)??p.primary;var valid=true;
    final hex=TextEditingController(text:_hex(value));
    try{
      final result=await showDialog<Color>(context:context,builder:(context)=>StatefulBuilder(builder:(context,setLocal)=>PrimeAlertDialog(
        title:const PrimeText('Choose color'),content:SizedBox(width:300,child:Column(mainAxisSize:MainAxisSize.min,children:[
          Container(height:56,color:value),const SizedBox(height:12),
          PrimeTextField(key:const Key('palette-picker-hex'),controller:hex,maxLength:7,decoration:InputDecoration(labelText:'Hex color',errorText:valid?null:'Use #RRGGBB'),
            onChanged:(text)=>setLocal((){final next=_parse(text);valid=next!=null;if(next!=null)value=next;})),
          for(final component in ['Red','Green','Blue'])Row(children:[SizedBox(width:42,child:PrimeText(component)),Expanded(child:PrimeSlider(
            min:0,max:255,divisions:255,value:(component=='Red'?value.r:component=='Green'?value.g:value.b)*255,
            onChanged:(v)=>setLocal((){value=Color.fromARGB(255,component=='Red'?v.round():(value.r*255).round(),component=='Green'?v.round():(value.g*255).round(),component=='Blue'?v.round():(value.b*255).round());hex.text=_hex(value);valid=true;})))]),
        ])),actions:[PrimeTextButton(onPressed:()=>Navigator.pop(context),child:const PrimeText('Cancel')),
          PrimeFilledButton(onPressed:valid?()=>Navigator.pop(context,value):null,child:const PrimeText('Use color'))])));
      if(result!=null&&mounted)setState((){fields[field]!.text=_hex(result);dirty=true;error=null;});
    }finally{hex.dispose();}
  }
  @override Widget build(BuildContext context)=>Theme(data:PrimeThemeCenterStyle.resolve(Theme.of(context),family:widget.initial.fontFamily,scale:widget.initial.fontScale),child:Builder(builder:(context)=>_build(context)));
  Widget _build(BuildContext context){
    final theme=Theme.of(context),palette=ThemeConfig.getAppPalette(preset);
    final header=theme.colorScheme.primary;
    final headerText=readableThemeForeground(header,theme.colorScheme.onPrimary);
    final primary=_parse(fields['primary']!.text)??palette.primary,secondary=_parse(fields['secondary']!.text)??palette.secondary;
    final surface=_parse(fields['surface']!.text)??palette.surface,background=_parse(fields['background']!.text)??palette.background;
    Widget inputs()=>Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[
      Row(mainAxisSize:MainAxisSize.min,children:[for(final choice in [false,true])SizedBox(width:56,height:32,child:PrimeOutlinedButton(onPressed:()=>mode(choice),
        style:PrimeOutlinedButton.styleFrom(padding:EdgeInsets.zero,minimumSize:const Size(56,32),side:BorderSide(color:theme.colorScheme.secondary),
          backgroundColor:dark==choice?theme.colorScheme.secondary:null,foregroundColor:dark==choice?theme.colorScheme.onSecondary:theme.colorScheme.secondary,
          shape:RoundedRectangleBorder(borderRadius:BorderRadius.horizontal(left:Radius.circular(choice?0:8),right:Radius.circular(choice?8:0)))),child:PrimeText(choice?'Dark':'Light')))]),
      const SizedBox(height:48),
      for(final entry in const {'primary':'Primary color','secondary':'Secondary color','surface':'Background paper','background':'Background default'}.entries)Padding(
        padding:EdgeInsets.only(bottom:entry.key=='background'?0:16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          PrimeText(entry.value,style:theme.textTheme.labelLarge?.copyWith(fontSize:12,height:2,color:theme.colorScheme.onSurfaceVariant)),
          PrimePaletteColorField(key:Key('palette-color-${entry.key}'),label:entry.value,color:_parse(fields[entry.key]!.text)??palette.primary,onPressed:()=>colorPicker(entry.key)),
        ])),
      if(error!=null)PrimeText(error!,style:theme.textTheme.bodySmall?.copyWith(color:theme.colorScheme.error)),
    ]));
    Widget preview()=>Column(mainAxisSize:MainAxisSize.min,children:[PrimeText('Preview',style:theme.textTheme.labelLarge?.copyWith(fontSize:14,fontWeight:FontWeight.w600,color:theme.colorScheme.onSurfaceVariant)),
      const SizedBox(height:16),PrimePaletteLivePreview(primary:primary,secondary:secondary,surface:surface,background:background)]);
    return Dialog(insetPadding:const EdgeInsets.all(32),clipBehavior:Clip.antiAlias,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),child:RepaintBoundary(key:const Key('palette-editor-capture'),child:ColoredBox(color:theme.colorScheme.surface,child:SizedBox(
      width:600,child:Column(mainAxisSize:MainAxisSize.min,children:[
        Container(height:48,color:header,padding:const EdgeInsets.symmetric(horizontal:24),child:Row(children:[PrimeIcon(Icons.palette_outlined,size:24,color:headerText),const SizedBox(width:12),
          Expanded(child:PrimeText('Edit palette',style:theme.textTheme.titleMedium?.copyWith(color:headerText)))])),
        Flexible(child:SingleChildScrollView(child:Padding(padding:const EdgeInsets.symmetric(horizontal:24,vertical:20),child:presets?
          Wrap(spacing:16,runSpacing:16,children:[for(final name in themeCenterPresetNames)SizedBox(width:128,child:InkWell(onTap:()=>Navigator.pop(context,PersonalTheme(
            name:widget.initial.name,preset:name,fontFamily:widget.initial.fontFamily,fontScale:widget.initial.fontScale,radius:widget.initial.radius).validated()),
            child:Column(children:[PrimePaletteMiniature(theme:PersonalTheme(name:name,preset:name),section:widget.section),const SizedBox(height:6),PrimeText(_title(name),textAlign:TextAlign.center,maxLines:2)])))])
          :LayoutBuilder(builder:(context,limits)=>limits.maxWidth>=544?Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:inputs()),SizedBox(width:296,height:400,child:Center(child:Transform.translate(offset:const Offset(0,-24),child:preview())))])
            :Column(mainAxisSize:MainAxisSize.min,children:[inputs(),const SizedBox(height:16),preview()]))))),
        Padding(padding:const EdgeInsets.all(16),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
          PrimeTextButton(onPressed:()=>Navigator.pop(context),child:const PrimeText('Cancel')),
          PrimeTextButton(onPressed:()=>setState(()=>presets=!presets),child:PrimeText(presets?'Customize':'Presets')),
          if(!presets)PrimeFilledButton(onPressed:dirty?save:null,child:const PrimeText('Save')),
        ])),
      ])))));
  }
}

class PrimePaletteColorField extends StatelessWidget {
  final String label;final Color color;final VoidCallback onPressed;
  const PrimePaletteColorField({super.key,required this.label,required this.color,required this.onPressed});
  @override Widget build(BuildContext context){final theme=Theme.of(context);return Semantics(label:label,value:_hex(color),button:true,child:Tooltip(message:label,child:InkWell(onTap:onPressed,borderRadius:BorderRadius.circular(8),
    child:Container(width:200,height:32,padding:const EdgeInsets.symmetric(horizontal:13,vertical:10),decoration:BoxDecoration(color:PrimeThemeCenterStyle.inputFill(theme),border:Border.all(color:PrimeThemeCenterStyle.inputBorder(theme)),borderRadius:BorderRadius.circular(8)),
      child:Container(decoration:BoxDecoration(color:color,border:Border.all(color:theme.colorScheme.onSurface.withValues(alpha:.55),width:.5)))))));}
}

class PrimePaletteLivePreview extends StatelessWidget{
  final Color primary,secondary,surface,background;
  const PrimePaletteLivePreview({super.key,required this.primary,required this.secondary,required this.surface,required this.background});
  @override Widget build(BuildContext context){final theme=Theme.of(context);TextStyle text(Color color)=>theme.textTheme.bodySmall!.copyWith(fontSize:12,height:1.5,fontWeight:FontWeight.w700,color:color);
    return SizedBox(width:200,height:162,child:Container(decoration:BoxDecoration(color:background,borderRadius:BorderRadius.circular(6),boxShadow:[BoxShadow(color:theme.shadowColor.withValues(alpha:.1),blurRadius:3,offset:const Offset(0,1))]),child:ClipRRect(borderRadius:BorderRadius.circular(6),child:Stack(children:[
      Positioned(left:0,right:0,top:0,height:56,child:Container(padding:const EdgeInsets.all(8),color:primary,child:PrimeText('Header (Primary)',style:text(readableThemeForeground(primary,theme.colorScheme.onSurface))))),
      Positioned(left:8,right:28,top:32,height:96,child:Container(padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:surface,borderRadius:BorderRadius.circular(2),boxShadow:[BoxShadow(color:theme.shadowColor.withValues(alpha:.1),blurRadius:3,offset:const Offset(0,1))]),
        child:PrimeText('Paper',style:text(readableThemeForeground(surface,theme.colorScheme.onSurface).withValues(alpha:.75))))),
      Positioned(right:4,top:46,child:CircleAvatar(radius:10,backgroundColor:secondary,child:PrimeText('S',style:text(readableThemeForeground(secondary,theme.colorScheme.onSurface)).copyWith(fontSize:9)))),
      Positioned(left:8,bottom:8,child:PrimeText('Background',style:text(readableThemeForeground(background,theme.colorScheme.onSurface).withValues(alpha:.75)))),
    ]))));
  }
}
