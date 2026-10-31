import 'dart:convert';
import 'package:flutter/material.dart';
import 'advanced_theme_model.dart';
import 'advanced_theme_controller.dart';
import 'advanced_theme_region.dart';
import 'advanced_theme_import.dart';
class PrimeAdvancedThemeEditor extends StatefulWidget {
 final AdvancedThemeController controller;final List<ThemeField> fields;final Map<String,String> labels,optionLabels,regionLabels;
 final ValueChanged<AdvancedTheme?> onApply;final ValueChanged<Map<String,Object?>> onLegacy;
 final Future<void> Function(String) copyText,download;final Future<String?> Function() pickText;
 final EdgeInsets padding;final double spacing;
 PrimeAdvancedThemeEditor({super.key,required this.controller,required List<ThemeField> fields,required Map<String,String> labels,required Map<String,String> optionLabels,required Map<String,String> regionLabels,required this.onApply,required this.onLegacy,required this.copyText,required this.download,required this.pickText,required this.padding,required this.spacing}):fields=List.unmodifiable(fields),labels=Map.unmodifiable(labels),optionLabels=Map.unmodifiable(optionLabels),regionLabels=Map.unmodifiable(regionLabels);
 @override State<PrimeAdvancedThemeEditor> createState()=>_PrimeAdvancedThemeEditorState();
}
class _PrimeAdvancedThemeEditorState extends State<PrimeAdvancedThemeEditor> {
 AdvancedTheme _draft=AdvancedTheme.defaults();String _selected='',_status='';int _epoch=0;bool _busy=false;
 final _inputs=<String,TextEditingController>{};
 @override void initState(){super.initState();_draft=widget.controller.active??AdvancedTheme.defaults();}
 @override void didUpdateWidget(PrimeAdvancedThemeEditor oldWidget){super.didUpdateWidget(oldWidget);if(!identical(oldWidget.controller,widget.controller)){_epoch++;_busy=false;_selected='';_status='';_draft=widget.controller.active??AdvancedTheme.defaults();_sync();}else if(jsonEncode(oldWidget.fields.map((f)=>f.toJson()).toList())!=jsonEncode(widget.fields.map((f)=>f.toJson()).toList())){_epoch++;_busy=false;_sync();}}
 @override void dispose(){_epoch++;for(final c in _inputs.values)c.dispose();super.dispose();}
 void _sync(){for(final field in widget.fields){final c=_inputs[field.path];if(c!=null)c.text=_draft.value(field.path).toString();}}
 AdvancedTheme _collect(){final raw=_draft.toJson();for(final field in widget.fields.where((f)=>f.visible(_draft))){final spec=themeFieldSpec(field.path),input=_inputs[field.path];if(input==null)continue;Object value=input.text;if(spec['kind']=='number'){value=num.parse(input.text);}final keys=field.path.split('.'),last=keys.removeLast();Map<String,Object?> host=raw;for(final key in keys){host=host[key]! as Map<String,Object?>;}host[last]=value;}return AdvancedTheme.fromJson(raw);}
 Future<void> _run(String action,int epoch)async{if(!mounted||epoch!=_epoch||_busy||!widget.controller.ready)return;setState(()=>_busy=true);try{
  if(!['reset','import','remove'].contains(action))_draft=_collect();switch(action){
   case 'apply':await widget.controller.apply(_draft);if(!mounted||epoch!=_epoch)return;widget.onApply(_draft);break;
   case 'save':final savedId=await widget.controller.save(_draft);if(!mounted||epoch!=_epoch)return;_selected=savedId;break;
   case 'update':await widget.controller.save(_draft,id:_selected);break;
   case 'rename':await widget.controller.rename(_selected,_draft.name);break;
   case 'duplicate':final duplicateId=await widget.controller.duplicate(_selected,_draft.name);if(!mounted||epoch!=_epoch)return;_selected=duplicateId;break;
   case 'remove':await widget.controller.remove(_selected);_selected='';break;
   case 'reset':await widget.controller.apply(null);if(!mounted||epoch!=_epoch)return;_draft=AdvancedTheme.defaults();_selected='';widget.onApply(null);break;
   case 'copy':await widget.copyText(_draft.exportJson());break;
   case 'export':await widget.download(_draft.exportJson());break;
   case 'import':final text=await widget.pickText();if(!mounted||epoch!=_epoch)return;if(text==null){return;}final imported=importThemeDocument(text);if(imported['kind']=='advanced'){_draft=AdvancedTheme.fromJson(imported['value']);_selected='';}else{widget.onLegacy(imported);}break;
  }if(mounted&&epoch==_epoch){_sync();setState(()=>_status=widget.labels['success']!);}
 }catch(_){if(mounted&&epoch==_epoch)setState(()=>_status=widget.labels['error']!);}finally{if(mounted&&epoch==_epoch)setState(()=>_busy=false);}}
 @override Widget build(BuildContext context){final epoch=_epoch,base=Theme.of(context);
  for(final key in ['primary','secondary','success','warning','error','info',...widget.fields.expand((f)=>(themeFieldSpec(f.path)['values'] as List<String>?)??<String>[])]){if(widget.optionLabels[key]?.trim().isNotEmpty!=true)throw StateError('Registered option labels required');}for(final key in themeRegions){if(widget.regionLabels[key]?.trim().isNotEmpty!=true)throw StateError('Registered region labels required');}
  for(final key in ['saved','preview','configuration','apply','save','update','rename','duplicate','remove','reset','copy','import','export','success','error','empty']){if(widget.labels[key]?.trim().isNotEmpty!=true)throw StateError('Registered editor labels required');}
  return AnimatedBuilder(animation:widget.controller,builder:(context,child)=>SingleChildScrollView(child:Padding(padding:widget.padding,child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   for(final field in widget.fields.where((f)=>f.visible(_draft)))Builder(builder:(context){final spec=themeFieldSpec(field.path);if(spec['kind']=='select'){final values=spec['values']! as List<String>;return DropdownButtonFormField<String>(key:ValueKey('theme-field-${field.id}-${_draft.value(field.path)}'),initialValue:_draft.value(field.path) as String,decoration:InputDecoration(labelText:field.label),items:values.map((v)=>DropdownMenuItem(value:v,child:Text(widget.optionLabels[v]??v))).toList(),onChanged:_busy?null:(value){try{if(epoch!=_epoch||value==null)return;setState((){_draft=_collect().patch(field.path,value);_sync();_status='';});}catch(_){setState(()=>_status=widget.labels['error']!);}});}
    final controller=_inputs.putIfAbsent(field.path,()=>TextEditingController(text:_draft.value(field.path).toString()));return TextField(key:ValueKey('theme-field-${field.id}'),controller:controller,decoration:InputDecoration(labelText:field.label),keyboardType:spec['kind']=='number'?const TextInputType.numberWithOptions(decimal:true):TextInputType.text,maxLength:spec['kind']=='color'?7:spec['kind']=='text'?60:null,onSubmitted:(_){try{if(epoch!=_epoch)return;setState((){_draft=_collect();_sync();_status='';});}catch(_){setState(()=>_status=widget.labels['error']!);}});
   }),
   DropdownButtonFormField<String>(key:ValueKey('theme-saved-$_selected-${widget.controller.items.length}'),initialValue:_selected,decoration:InputDecoration(labelText:widget.labels['saved']),items:[DropdownMenuItem(value:'',child:Text(widget.labels['empty']!)),for(final item in widget.controller.items)DropdownMenuItem(value:item['id']! as String,child:Text(AdvancedTheme.fromJson(item['theme']).name))],onChanged:_busy?null:(value){if(epoch!=_epoch)return;setState((){_selected=value??'';final item=widget.controller.items.where((i)=>i['id']==_selected).firstOrNull;if(item!=null){_draft=AdvancedTheme.fromJson(item['theme']);_sync();}});}),
   Wrap(spacing:widget.spacing,runSpacing:widget.spacing,children:[for(final action in ['apply','save','update','rename','duplicate','remove','reset','copy','import','export'])TextButton(key:ValueKey('theme-action-$action'),onPressed:_busy||widget.controller.busy||!widget.controller.ready||['update','rename','duplicate','remove'].contains(action)&&_selected.isEmpty?null:()=>_run(action,epoch),child:Text(widget.labels[action]!))]),
   Text(widget.labels['preview']!,style:base.textTheme.titleLarge),
   for(final region in themeRegions)AdvancedThemeRegion(theme:_draft,region:region,base:base,child:Padding(padding:widget.padding,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(widget.regionLabels[region]??region),Wrap(children:[for(final entry in (themePalettePreview(_draft.region(region))['colors']! as Map<String,Object>).entries)for(final pair in [const ['value','on'],const ['light','onLight'],const ['dark','onDark']])Builder(builder:(context){final c=entry.value as Map<String,String>;return ColoredBox(color:Color(int.parse(c[pair[0]]!.substring(1),radix:16)|0xff000000),child:Padding(padding:widget.padding,child:Text(widget.optionLabels[entry.key]??entry.key,style:TextStyle(color:Color(int.parse(c[pair[1]]!.substring(1),radix:16)|0xff000000)))));})])]))),
   Text(widget.labels['configuration']!,style:base.textTheme.titleLarge),SelectableText(const JsonEncoder.withIndent('  ').convert(_draft.toJson()),key:const ValueKey('theme-configuration')),
   Semantics(liveRegion:true,child:Text(_status,key:const ValueKey('theme-status'))),
  ])))));
 }
}
