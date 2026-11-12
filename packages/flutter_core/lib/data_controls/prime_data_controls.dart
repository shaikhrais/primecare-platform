import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCheckbox, PrimeCheckboxListTile, PrimeMaterialLinearProgressIndicator, PrimeSlider, PrimeTextFormField;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextField;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIconButton;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextButton;
import '../original_assets.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter/material.dart';import 'package:flutter/services.dart';import 'package:flutter/semantics.dart';import '../component_catalogue/prime_component_catalogue.dart' show CatalogueLabels,PrimeCatalogueAction;import 'data_controls_model.dart';import 'upload_task.dart';
export 'data_controls_model.dart';export 'upload_task.dart';
class PrimeDataKit {final CatalogueLabels labels;final String scope;PrimeDataKit(this.labels,this.scope){if(scope.trim().isEmpty)throw ArgumentError('scope_required');}
 Widget button(String key,Future<void> Function()? action,{String suffix='',bool disabled=false})=>PrimeCatalogueAction(labels:labels,scope:scope,control:key,action:action,suffix:suffix,disabled:disabled,errorKey:'error',successKey:key=='cancel'?'cancel':'success');
 Widget field(String kind,TextEditingController controller,{bool enabled=true,bool required=false,double? min,double? max,double? step,String? pattern,DateTime? firstDate,DateTime? lastDate})=>_PrimeTypedField(labels:labels,scope:scope,kind:kind,controller:controller,enabled:enabled,required:required,min:min,max:max,step:step,pattern:pattern,firstDate:firstDate,lastDate:lastDate);
 Widget form(GlobalKey<FormState> key,List<Widget> children,Future<void> Function()? save)=>labels.identify('form','prime_card',Form(key:key,child:Column(mainAxisSize:MainAxisSize.min,children:[...children,button('submit',save==null?null:()async{if(!key.currentState!.validate())throw StateError('invalid_form');await save();}),if(save==null)PrimeText(labels.text('unsupported'))])));
}
class _PrimeTypedField extends StatefulWidget {
 final CatalogueLabels labels;final String scope,kind;final TextEditingController controller;final bool enabled,required;
 final double? min,max,step;final String? pattern;final DateTime? firstDate,lastDate;
 const _PrimeTypedField({required this.labels,required this.scope,required this.kind,required this.controller,required this.enabled,required this.required,this.min,this.max,this.step,this.pattern,this.firstDate,this.lastDate});
 @override State<_PrimeTypedField> createState()=>_PrimeTypedFieldState();
}
class _PrimeTypedFieldState extends State<_PrimeTypedField> {
 int _epoch=0;bool _picking=false;ModalRoute<dynamic>? _pickerRoute;
 void _closePicker(){final route=_pickerRoute;_pickerRoute=null;final navigator=route?.navigator;if(route==null||navigator==null)return;WidgetsBinding.instance.addPostFrameCallback((_){if(navigator.mounted&&route.isActive)navigator.removeRoute(route);});}
 @override void didUpdateWidget(covariant _PrimeTypedField old){super.didUpdateWidget(old);if(old.scope!=widget.scope||old.kind!=widget.kind||old.controller!=widget.controller||old.enabled!=widget.enabled||old.firstDate!=widget.firstDate||old.lastDate!=widget.lastDate){_epoch++;_picking=false;_closePicker();}}
 @override void dispose(){_epoch++;_closePicker();super.dispose();}
 Future<void> _pick()async{
  if(!widget.enabled||_picking)return;
  final w=widget,controller=w.controller,text=controller.text,g=++_epoch;
  setState(()=>_picking=true);
  Widget capture(BuildContext context,Widget? child){if(mounted&&g==_epoch)_pickerRoute=ModalRoute.of(context);return child!;}
  String? next;
  try{
   if(w.kind=='date'&&w.firstDate!=null&&w.lastDate!=null){
    final first=w.firstDate!,last=w.lastDate!,parsed=DateTime.tryParse(text),initial=parsed!=null&&!parsed.isBefore(first)&&!parsed.isAfter(last)?parsed:first;
    final date=await showDatePicker(context:context,initialDate:initial,firstDate:first,lastDate:last,builder:capture);
    if(date!=null)next='${date.year.toString().padLeft(4,'0')}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
   }else if(w.kind=='time'){
    final parts=text.split(':'),valid=fieldError(text,'time')==null&&parts.length==2;
    final time=await showTimePicker(context:context,initialTime:valid?TimeOfDay(hour:int.parse(parts[0]),minute:int.parse(parts[1])):TimeOfDay.now(),builder:capture);
    if(time!=null)next='${time.hour.toString().padLeft(2,'0')}:${time.minute.toString().padLeft(2,'0')}';
   }
   if(mounted&&g==_epoch&&widget.enabled&&identical(controller,widget.controller)&&controller.text==text&&next!=null)controller.text=next;
  }finally{if(mounted&&g==_epoch){_pickerRoute=null;setState(()=>_picking=false);}}
 }
 @override Widget build(BuildContext context){final w=widget,labels=w.labels,kind=w.kind,controller=w.controller,pattern=w.pattern;
  return labels.identify(kind,'prime_text_field',PrimeTextFormField(controller:controller,enabled:w.enabled,keyboardType:kind=='number'?const TextInputType.numberWithOptions(decimal:true,signed:true):kind=='date'||kind=='time'?TextInputType.datetime:TextInputType.text,
   decoration:InputDecoration(labelText:labels.text(kind),suffixIcon:kind=='time'||kind=='date'&&w.firstDate!=null&&w.lastDate!=null?Semantics(identifier:'${labels.id(kind,'prime_text_field')}-picker',child:PrimeIconButton(tooltip:labels.text(kind),icon:PrimeOriginalAsset(kind=='date'?'calendar':'clock'),onPressed:w.enabled&&!_picking?_pick:null)):null),
   onChanged:kind=='mask'&&pattern!=null?(v){
    final formatted=formatMask(v,pattern);
    if(v!=formatted){
     final previous=controller.value,selection=previous.selection;
     final valid=selection.isValid&&selection.baseOffset<=v.length&&selection.extentOffset<=v.length;
     final next=valid?TextSelection(baseOffset:formatMask(v.substring(0,selection.baseOffset),pattern).length,extentOffset:formatMask(v.substring(0,selection.extentOffset),pattern).length,affinity:selection.affinity,isDirectional:selection.isDirectional):TextSelection.collapsed(offset:formatted.length);
     controller.value=previous.copyWith(text:formatted,selection:next,composing:TextRange.empty);
    }
   }:null,
   validator:(v){final error=fieldError(v??'',kind,required:w.required,min:w.min,max:w.max,step:w.step,pattern:w.pattern);return error==null?null:labels.text(error);}));
 }
}

class PrimeVirtualTable extends StatefulWidget {
  final CatalogueLabels labels;
  final String scope;
  final List<DataColumnSpec> columns;
  final List<DataRowSpec> rows;
  final double rowHeight, height, minWidth, maxWidth, actionWidth;
  final int pageSize;
  final Widget Function(DataRowSpec)? detail;
  const PrimeVirtualTable({
    super.key,
    required this.labels,
    required this.scope,
    required this.columns,
    required this.rows,
    required this.rowHeight,
    required this.height,
    required this.minWidth,
    required this.maxWidth,
    required this.actionWidth,
    this.pageSize = 100,
    this.detail,
  });
  @override
  State<PrimeVirtualTable> createState() => _PrimeVirtualTableState();
}

class _PrimeVirtualTableState extends State<PrimeVirtualTable> {
  late DataTableModel model;
  List<DataColumnSpec> _sourceColumns = [];
  final scroll = ScrollController(), filter = TextEditingController();
  final headerScroll = ScrollController(), bodyScroll = ScrollController();
  bool syncing = false;
  int active = 0;
  final focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _reset();
    bodyScroll.addListener(_horizontal);
  }

  void _horizontal() {
    if (!syncing && headerScroll.hasClients) {
      syncing = true;
      headerScroll.jumpTo(bodyScroll.offset);
      syncing = false;
    }
  }

  // Compare captured input specs, not the model's user-configured columns.
  bool _sameSourceColumns(List<DataColumnSpec> columns) {
    if (columns.length != _sourceColumns.length) return false;
    for (var i = 0; i < columns.length; i++) {
      final incoming = columns[i], previous = _sourceColumns[i];
      if (incoming.key != previous.key ||
          incoming.label != previous.label ||
          incoming.width != previous.width ||
          incoming.visible != previous.visible ||
          incoming.pinned != previous.pinned) return false;
    }
    return true;
  }

  void _reset() {
    final w = widget;
    if (![
          w.rowHeight,
          w.height,
          w.minWidth,
          w.maxWidth,
          w.actionWidth,
        ].every((v) => v.isFinite) ||
        [w.rowHeight, w.height, w.minWidth, w.actionWidth].any((v) => v <= 0) ||
        w.maxWidth < w.minWidth ||
        w.columns.any((c) => c.width < w.minWidth || c.width > w.maxWidth))
      throw ArgumentError('invalid_geometry');
    model = DataTableModel(w.columns, w.rows, pageSize: w.pageSize);
    _sourceColumns = w.columns.map((column) => column.copy()).toList(growable: false);
    filter.clear();
    active = 0;
  }

  @override
  void didUpdateWidget(covariant PrimeVirtualTable old) {
    super.didUpdateWidget(old);
    if (old.scope != widget.scope ||
        !_sameSourceColumns(widget.columns) ||
        old.pageSize != widget.pageSize) {
      _reset();
    } else if (old.rows != widget.rows) {
      model.replace(widget.rows);
      active = 0;
    }
  }

  @override
  void dispose() {
    scroll.dispose();
    filter.dispose();
    headerScroll.dispose();
    bodyScroll.dispose();
    focus.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() => active = 0);
    if (scroll.hasClients) scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.labels,
        kit = PrimeDataKit(l, widget.scope),
        page = model.pageRows(),
        columns = model.visible(),
        width =
            widget.actionWidth + columns.fold<double>(0, (s, c) => s + c.width);
    Widget cell(Widget child, double w) => SizedBox(width: w, child: child);
    // Keep a single semantic/widget instance per cell. Pinned cells paint last,
    // cancelling the enclosing viewport's logical horizontal displacement.
    Widget stickyRow(List<Widget> cells) => AnimatedBuilder(
      animation: bodyScroll,
      builder: (context, _) {
        final offset = bodyScroll.hasClients ? bodyScroll.offset : 0.0;
        final sign = Directionality.of(context) == TextDirection.rtl
            ? -1.0
            : 1.0;
        final starts = <double>[0];
        final widths = <double>[
          widget.actionWidth,
          ...columns.map((c) => c.width),
        ];
        for (final w in widths) {
          starts.add(starts.last + w);
        }
        bool pinned(int i) => i == 0 || columns[i - 1].pinned;
        return SizedBox(
          height: widget.rowHeight,
          width: width,
          child: Stack(
            children: [
              for (final fixed in [false, true])
                for (var i = 0; i < cells.length; i++)
                  if (pinned(i) == fixed)
                    PositionedDirectional(
                      start: starts[i],
                      top: 0,
                      bottom: 0,
                      width: widths[i],
                      child: Transform.translate(
                        offset: Offset(fixed ? sign * offset : 0, 0),
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surface,
                          child: cells[i],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
    final header = stickyRow([
      cell(PrimeText(l.text('selectRow')), widget.actionWidth),
      for (final c in columns)
        cell(
          Semantics(
            sortKey: OrdinalSortKey(columns.indexOf(c).toDouble()),
            child: l.identify(
              'sort',
              'prime_button',
              PrimeTextButton(
                onPressed: () {
                  model.sort(c.key);
                  refresh();
                },
                child: PrimeText(c.label),
              ),
              suffix: '-${c.key}',
            ),
          ),
          c.width,
        ),
    ]);
    return l.identify(
      'table',
      'prime_table_web',
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          l.identify(
            'filter',
            'prime_text_field',
            PrimeTextField(
              controller: filter,
              decoration: InputDecoration(labelText: l.text('filter')),
              onChanged: (value) {
                model.filter(value);
                refresh();
              },
            ),
          ),
          l.identify(
            'columns',
            'prime_card',
            ExpansionTile(
              title: PrimeText(l.text('columns')),
              children: [
                for (final c in model.columns)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      l.identify(
                        'visible',
                        'prime_checkbox_web',
                        PrimeCheckboxListTile(
                          title: PrimeText(c.label),
                          value: c.visible,
                          onChanged: (v) {
                            try {
                              model.configure(
                                c.key,
                                visible: v,
                                minWidth: widget.minWidth,
                                maxWidth: widget.maxWidth,
                              );
                              refresh();
                            } on ArgumentError {
                              /* Preserve the last visible column. */
                            }
                          },
                        ),
                        suffix: '-${c.key}',
                      ),
                      Wrap(
                        children: [
                          kit.button('moveLeft', () async {
                            model.configure(
                              c.key,
                              move: -1,
                              minWidth: widget.minWidth,
                              maxWidth: widget.maxWidth,
                            );
                            refresh();
                          }, suffix: '-${c.key}'),
                          kit.button('moveRight', () async {
                            model.configure(
                              c.key,
                              move: 1,
                              minWidth: widget.minWidth,
                              maxWidth: widget.maxWidth,
                            );
                            refresh();
                          }, suffix: '-${c.key}'),
                          kit.button('pin', () async {
                            model.configure(
                              c.key,
                              pinned: !c.pinned,
                              minWidth: widget.minWidth,
                              maxWidth: widget.maxWidth,
                            );
                            refresh();
                          }, suffix: '-${c.key}'),
                        ],
                      ),
                      l.identify(
                        'resize',
                        'prime_text_field',
                        PrimeSlider(
                          label: l.text('resize'),
                          value: c.width,
                          min: widget.minWidth,
                          max: widget.maxWidth,
                          onChanged: (value) {
                            model.configure(
                              c.key,
                              width: value,
                              minWidth: widget.minWidth,
                              maxWidth: widget.maxWidth,
                            );
                            refresh();
                          },
                        ),
                        suffix: '-${c.key}',
                      ),
                    ],
                  ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: headerScroll,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(width: width, child: header),
          ),
          Focus(
            focusNode: focus,
            onKeyEvent: (node, event) {
              if (event is! KeyDownEvent ||
                  ![
                    LogicalKeyboardKey.arrowDown,
                    LogicalKeyboardKey.arrowUp,
                    LogicalKeyboardKey.pageDown,
                    LogicalKeyboardKey.pageUp,
                  ].contains(event.logicalKey) ||
                  !scroll.hasClients)
                return KeyEventResult.ignored;
              final direction =
                  [
                    LogicalKeyboardKey.arrowUp,
                    LogicalKeyboardKey.pageUp,
                  ].contains(event.logicalKey)
                  ? -1
                  : 1;
              final step =
                  [
                    LogicalKeyboardKey.pageDown,
                    LogicalKeyboardKey.pageUp,
                  ].contains(event.logicalKey)
                  ? widget.height
                  : widget.rowHeight;
              scroll.jumpTo(
                (scroll.offset + direction * step).clamp(
                  0,
                  scroll.position.maxScrollExtent,
                ),
              );
              return KeyEventResult.handled;
            },
            child: SizedBox(
              height: widget.height,
              child: SingleChildScrollView(
                controller: bodyScroll,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: width,
                  child: ListView.builder(
                    controller: scroll,
                    itemExtent: widget.rowHeight,
                    itemCount: page.rows.length,
                    itemBuilder: (context, i) {
                      final row = page.rows[i];
                      return Semantics(
                        identifier:
                            '${l.id('table', 'prime_table_web')}-row-${row.id}',
                        selected: model.selected.contains(row.id),
                        child: stickyRow([
                          cell(
                            Row(
                              children: [
                                Expanded(
                                  child: l.identify(
                                    'selectRow',
                                    'prime_checkbox_web',
                                    PrimeCheckbox(
                                      semanticLabel: l.text('selectRow'),
                                      value: model.selected.contains(row.id),
                                      onChanged: (_) =>
                                          setState(() => model.toggle(row.id)),
                                    ),
                                    suffix: '-${row.id}',
                                  ),
                                ),
                                if (widget.detail != null)
                                  Expanded(
                                    child: l.identify(
                                      'expand',
                                      'prime_button',
                                      PrimeIconButton(
                                        tooltip: l.text('expand'),
                                        icon: PrimeOriginalAsset(
                                          model.expanded == row.id
                                              ? 'chevron-up'
                                              : 'chevron-down',
                                        ),
                                        onPressed: () => setState(
                                          () => model.expanded =
                                              model.expanded == row.id
                                              ? null
                                              : row.id,
                                        ),
                                      ),
                                      suffix: '-${row.id}',
                                    ),
                                  ),
                              ],
                            ),
                            widget.actionWidth,
                          ),
                          for (final c in columns)
                            cell(
                              Semantics(
                                identifier:
                                    '${l.id('table', 'prime_table_web')}-cell-${row.id}-${c.key}',
                                child: SelectableText(
                                  (row.values[c.key] ?? '').toString(),
                                  semanticsLabel:
                                      '${c.label}: ${row.values[c.key] ?? ''}',
                                ),
                              ),
                              c.width,
                            ),
                        ]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            children: [
              kit.button('previous', () async {
                model.page--;
                refresh();
              }, disabled: model.page == 0),
              kit.button('next', () async {
                model.page++;
                refresh();
              }, disabled: (model.page + 1) * model.pageSize >= page.total),
            ],
          ),
          Semantics(
            liveRegion: true,
            child: PrimeText(
              '${page.total == 0 ? l.text('empty') : '${page.start + 1}–${page.start + page.rows.length} / ${page.total}'}; ${l.text('selected')}: ${model.selected.length}',
            ),
          ),
          if (model.expanded != null && widget.detail != null)
            widget.detail!(
              model.rows.firstWhere((r) => r.id == model.expanded),
            ),
        ],
      ),
    );
  }
}

class PrimeDataAutocomplete extends StatefulWidget {final CatalogueLabels labels;final String scope;final Future<List<({String value,String label})>> Function(String)? load;final ValueChanged<String>? selected;const PrimeDataAutocomplete({super.key,required this.labels,required this.scope,this.load,this.selected});@override State<PrimeDataAutocomplete> createState()=>_PrimeDataAutocompleteState();}
class _PrimeDataAutocompleteState extends State<PrimeDataAutocomplete>{int generation=0;String? status;@override void didUpdateWidget(covariant PrimeDataAutocomplete old){super.didUpdateWidget(old);if(old.scope!=widget.scope||old.load!=widget.load){generation++;status=null;}}@override void dispose(){generation++;super.dispose();}@override Widget build(BuildContext context){final l=widget.labels;return Column(mainAxisSize:MainAxisSize.min,children:[l.identify('autocomplete','prime_text_field',Autocomplete<({String value,String label})>(key:ValueKey(widget.scope),displayStringForOption:(v)=>v.label,optionsBuilder:(text)async{final g=++generation;if(widget.load==null)return [];setState(()=>status='loading');try{final result=await widget.load!(text.text);if(!mounted||g!=generation)return [];if(result.length>100||result.map((v)=>v.value).toSet().length!=result.length||result.any((v)=>v.label.isEmpty))throw StateError('invalid_options');final accepted=List<({String value,String label})>.unmodifiable(result);setState(()=>status=accepted.isEmpty?'empty':null);return accepted;}catch(_){if(mounted&&g==generation)setState(()=>status='error');return [];}},onSelected:(v)=>widget.selected?.call(v.value),fieldViewBuilder:(context,controller,node,submit)=>PrimeTextField(controller:controller,focusNode:node,enabled:widget.load!=null,onSubmitted:(_)=>submit(),decoration:InputDecoration(labelText:l.text('autocomplete'))))),if(widget.load==null)PrimeText(l.text('unsupported')),if(status!=null)Semantics(liveRegion:true,child:PrimeText(l.text(status!)))]);}}
class PrimeStructuredEditor extends StatefulWidget {
 final CatalogueLabels labels;final String scope;final Object document;final Future<void> Function(Map<String,Object?>)? save;
 final bool Function(String)? imageAllowed;final Widget Function(String,String)? imageBuilder;final Future<void> Function(String)? openLink;
 final bool inlineRanges;
 const PrimeStructuredEditor({super.key,required this.labels,required this.scope,required this.document,this.save,this.imageAllowed,this.imageBuilder,this.openLink,this.inlineRanges=false});
 @override State<PrimeStructuredEditor> createState()=>_PrimeStructuredEditorState();
}
class _PrimeStructuredEditorState extends State<PrimeStructuredEditor>{
 late Map<String,Object?> doc;final text=TextEditingController(),link=TextEditingController(),image=TextEditingController();
 int index=0,generation=0;bool linkBusy=false,settingText=false;String? linkStatus,editorStatus;TextEditingValue previousValue=const TextEditingValue();RichTextEdit? pendingEdit;
 List<Map<String,Object?>> get blocks=>(doc['blocks'] as List).cast<Map<String,Object?>>();
 @override void initState(){super.initState();_reset();text.addListener(trackEdit);}
 void _reset(){generation++;linkBusy=false;linkStatus=null;editorStatus=null;link.clear();image.clear();doc=validateDocument(widget.document);
  if(!widget.inlineRanges&&doc['version']!=1)throw ArgumentError('inline_range_capability_required');if(widget.inlineRanges)doc['version']=2;
  index=0;setText(blocks[0]['text'] as String);
 }
 void setText(String value){settingText=true;try{text.value=TextEditingValue(text:value,selection:TextSelection.collapsed(offset:value.length));previousValue=text.value;pendingEdit=null;}finally{settingText=false;}}
 void trackEdit(){if(settingText)return;final next=text.value;if(previousValue.text!=next.text){pendingEdit=widget.inlineRanges&&previousValue.text==blocks[index]['text']?inferRichEdit(previousValue.text,next.text,previousValue.selection.start,previousValue.selection.end,next.selection.start):null;}previousValue=next;}
 void sync(){final next=widget.inlineRanges?replaceRichText(blocks[index],text.text,pendingEdit):{...blocks[index],'text':text.text};doc=validateDocument({...doc,'blocks':[for(var i=0;i<blocks.length;i++)i==index?next:blocks[i]]});pendingEdit=null;}
 @override void didUpdateWidget(covariant PrimeStructuredEditor old){super.didUpdateWidget(old);if(old.scope!=widget.scope||old.document!=widget.document||old.inlineRanges!=widget.inlineRanges)_reset();}
 Future<void> activateLink(String value)async{if(linkBusy||widget.openLink==null)return;final g=generation;setState((){linkBusy=true;linkStatus=null;});try{await widget.openLink!(safeHttps(value));}catch(_){if(mounted&&g==generation)setState(()=>linkStatus='error');}finally{if(mounted&&g==generation)setState(()=>linkBusy=false);}}
 @override void dispose(){generation++;text.removeListener(trackEdit);text.dispose();link.dispose();image.dispose();super.dispose();}
 Widget previewText(Map<String,Object?> block){
  final style=TextStyle(fontWeight:block['bold']==true?FontWeight.bold:null,fontStyle:block['italic']==true?FontStyle.italic:null);
  if((block['marks'] as List?)?.isNotEmpty!=true)return SelectableText('${block['kind']=='bullet'?'• ':''}${block['text']}',style:style);
  return SelectableText.rich(TextSpan(children:[if(block['kind']=='bullet')const TextSpan(text:'• '),for(final run in richRuns(block))TextSpan(text:run.text,style:TextStyle(fontWeight:run.bold?FontWeight.bold:FontWeight.normal,fontStyle:run.italic?FontStyle.italic:FontStyle.normal))]),style:style);
 }
 @override Widget build(BuildContext context){
  final l=widget.labels,kit=PrimeDataKit(l,widget.scope);
  Widget format(String key)=>kit.button(key,()async{
   final selection=text.selection;sync();setState((){
    if(key=='list'){blocks[index]['kind']=blocks[index]['kind']=='bullet'?'paragraph':'bullet';}
    else if(widget.inlineRanges&&selection.isValid&&!selection.isCollapsed){blocks[index]=toggleRichRange(blocks[index],selection.start,selection.end,key);}
    else{blocks[index][key]=blocks[index][key]!=true;if(widget.inlineRanges&&blocks[index]['marks'] is List){blocks[index]['marks']=[for(final mark in blocks[index]['marks'] as List){...Map<String,Object?>.from(mark as Map),key:blocks[index][key]}];}doc=validateDocument(doc);}
   });
  });
  return Column(mainAxisSize:MainAxisSize.min,children:[
   Wrap(children:[for(var i=0;i<blocks.length;i++)l.identify('editor','prime_textarea_web',PrimeTextButton(onPressed:(){try{sync();setState((){index=i;setText(blocks[index]['text'] as String);editorStatus=null;});}catch(_){setState(()=>editorStatus='invalid');}},child:PrimeText('${i+1}')),suffix:'-block-$i')]),
   l.identify('editor','prime_textarea_web',PrimeTextField(controller:text,maxLines:5,maxLength:32768,decoration:InputDecoration(labelText:l.text('editor')),onChanged:(_){try{sync();setState(()=>editorStatus=null);}catch(_){setState(()=>editorStatus='invalid');}})),
   Wrap(children:[format('bold'),format('italic'),format('list')]),
   l.identify('link','prime_text_field',PrimeTextField(controller:link,decoration:InputDecoration(labelText:l.text('link')))),
   kit.button('addLink',()async{sync();final url=safeHttps(link.text);setState(()=>blocks[index]['link']=url);}),
   l.identify('image','prime_text_field',PrimeTextField(controller:image,decoration:InputDecoration(labelText:l.text('image')))),
   kit.button('addImage',widget.imageAllowed==null||widget.imageBuilder==null?null:()async{sync();final url=safeHttps(image.text);if(!widget.imageAllowed!(url)||(blocks[index]['text'] as String).trim().isEmpty)throw StateError('denied_image');setState(()=>blocks[index]['image']={'url':url,'alt':blocks[index]['text']});}),
   kit.button('addBlock',()async{sync();if(blocks.length>=200)throw StateError('too_many_blocks');setState((){blocks.add({'text':'','bold':false,'italic':false,'kind':'paragraph'});index=blocks.length-1;setText('');});}),
   kit.button('save',widget.save==null?null:()async{sync();await widget.save!(validateDocument(doc));}),
   if(widget.save==null)PrimeText(l.text('unsupported')),
   if(editorStatus!=null)Semantics(liveRegion:true,child:PrimeText(l.text(editorStatus!))),
   if(linkStatus!=null)Semantics(liveRegion:true,child:PrimeText(l.text(linkStatus!))),
   l.identify('editorPreview','prime_card',Column(mainAxisSize:MainAxisSize.min,children:[for(final b in blocks)Column(mainAxisSize:MainAxisSize.min,children:[
    previewText(b),
    if(b['link']!=null)widget.openLink==null?SelectableText(b['link'] as String):Semantics(link:true,child:PrimeTextButton(onPressed:linkBusy?null:()=>activateLink(b['link'] as String),child:PrimeText(b['link'] as String))),
    if(b['image'] is Map)widget.imageAllowed?.call((b['image'] as Map)['url'] as String)==true&&widget.imageBuilder!=null?widget.imageBuilder!((b['image'] as Map)['url'] as String,(b['image'] as Map)['alt'] as String):PrimeText((b['image'] as Map)['alt'] as String)
   ])]))
  ]);
 }
}
class PrimeUploadControl extends StatefulWidget {
 final CatalogueLabels labels;final String scope;final UploadPolicy policy;final Future<List<UploadCandidate>> Function()? pick;final UploadPort? port;final bool retrySafe;final UploadRemovalPort? removalPort;final UploadReceiptPort? receiptPort;final bool removalRetrySafe;
 const PrimeUploadControl({super.key,required this.labels,required this.scope,required this.policy,this.pick,this.port,this.retrySafe=false,this.removalPort,this.receiptPort,this.removalRetrySafe=false});
 @override State<PrimeUploadControl> createState()=>_PrimeUploadControlState();
}
class _PrimeUploadControlState extends State<PrimeUploadControl>{
 late UploadTask task;bool invalid=false;int generation=0;
 @override void initState(){super.initState();_create();}
 void _create(){task=UploadTask(widget.scope,widget.policy,port:widget.port,retrySafe:widget.retrySafe,removalPort:widget.removalPort,receiptPort:widget.receiptPort,removalRetrySafe:widget.removalRetrySafe);task.addListener(_changed);}
 void _changed(){if(mounted)setState((){});}
 @override void didUpdateWidget(covariant PrimeUploadControl old){super.didUpdateWidget(old);if(old.scope!=widget.scope||old.port!=widget.port||old.policy!=widget.policy||old.retrySafe!=widget.retrySafe||old.removalPort!=widget.removalPort||old.receiptPort!=widget.receiptPort||old.removalRetrySafe!=widget.removalRetrySafe){generation++;task.dispose();_create();invalid=false;}}
 @override void dispose(){generation++;task.dispose();super.dispose();}
 @override Widget build(BuildContext context){
  final l=widget.labels,kit=PrimeDataKit(l,widget.scope),canRemove=widget.removalPort!=null&&widget.receiptPort!=null;
  return Column(mainAxisSize:MainAxisSize.min,children:[
   l.identify('upload','prime_text_field',PrimeTextButton(onPressed:widget.pick==null||['uploading','removing','remove-error'].contains(task.status)?null:()async{final g=++generation;try{final files=await widget.pick!();if(!mounted||g!=generation)return;task.choose(files);setState(()=>invalid=false);}catch(_){if(mounted&&g==generation)setState(()=>invalid=true);}},child:PrimeText(l.text('upload')))),
   for(var i=0;i<task.files.length;i++)Row(children:[Expanded(child:PrimeText(task.files[i].name)),kit.button('remove',()async=>task.removeSelection(i),suffix:'-selected-$i',disabled:task.status!='ready')]),
   kit.button('send',widget.port==null?null:()async{await task.send();if(task.status!='success')throw StateError('upload_not_acknowledged');},disabled:task.status!='ready'),
   kit.button('cancel',()async=>task.cancel(),disabled:task.status!='uploading'),
   kit.button('retry',widget.retrySafe&&widget.port!=null?()async{await task.send();if(task.status!='success')throw StateError('upload_not_acknowledged');}:null,disabled:!['error','cancelled'].contains(task.status)),
   if(task.receiptId!=null)kit.button('remove',canRemove?()async{await task.removeUpload();if(task.status!='removed')throw StateError('removal_not_verified');}:null,suffix:'-receipt',disabled:!['success','remove-error'].contains(task.status)),
   if(task.receiptId!=null&&!canRemove)PrimeText(l.text('unsupported')),
   l.identify('progress','prime_card',PrimeMaterialLinearProgressIndicator(value:task.progress,semanticsLabel:l.text('progress'))),
   Semantics(liveRegion:true,child:PrimeText(invalid?l.text('invalid'):widget.port==null||widget.pick==null?l.text('unsupported'):['success','removed'].contains(task.status)?l.text('success'):['error','remove-error'].contains(task.status)?l.text('error'):['uploading','removing'].contains(task.status)?l.text('loading'):task.files.map((f)=>f.name).join(', '))),
  ]);
 }
}
