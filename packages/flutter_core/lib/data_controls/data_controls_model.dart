import 'dart:math' as math;
bool richTextBoundary(String text,int offset)=>offset>=0&&offset<=text.length&&!(offset>0&&offset<text.length&&text.codeUnitAt(offset-1)>=0xd800&&text.codeUnitAt(offset-1)<=0xdbff&&text.codeUnitAt(offset)>=0xdc00&&text.codeUnitAt(offset)<=0xdfff);
List<Map<String,Object?>> _validateRichMarks(String text,Object? raw,bool bold,bool italic){
 if(raw is! List||raw.length>1024)throw ArgumentError('invalid_marks');
 int? position(Object? value)=>value is num&&value.isFinite&&value.abs()<=9007199254740991&&value==value.roundToDouble()?value.toInt():null;
 final result=<Map<String,Object?>>[];var previousEnd=0;
 for(final value in raw){
  if(value is! Map||value.keys.length!=4||value.keys.any((k)=>!['start','end','bold','italic'].contains(k))||value['bold'] is! bool||value['italic'] is! bool)throw ArgumentError('invalid_mark');
  final start=position(value['start']),end=position(value['end']);
  if(start==null||end==null||!richTextBoundary(text,start)||!richTextBoundary(text,end)||start>=end||start<previousEnd)throw ArgumentError('invalid_mark');
  previousEnd=end;if(value['bold']==bold&&value['italic']==italic)continue;
  if(result.isNotEmpty&&result.last['end']==start&&result.last['bold']==value['bold']&&result.last['italic']==value['italic']){result.last['end']=end;}
  else{result.add({'start':start,'end':end,'bold':value['bold'],'italic':value['italic']});}
 }
 return result;
}
class RichTextRun {
 final int start,end;final String text;final bool bold,italic;
 const RichTextRun(this.start,this.end,this.text,this.bold,this.italic);
 Map<String,Object?> toJson()=>{'start':start,'end':end,'text':text,'bold':bold,'italic':italic};
}
class RichTextEdit {final int start,end;const RichTextEdit(this.start,this.end);}
RichTextEdit? inferRichEdit(String old,String text,int start,int end,int afterStart){
 if(!richTextBoundary(old,start)||!richTextBoundary(old,end)||start>end||!richTextBoundary(text,afterStart))return null;
 bool fits(int a,int b){final inserted=text.length-(old.length-(b-a));return richTextBoundary(old,a)&&richTextBoundary(old,b)&&inserted>=0&&richTextBoundary(text,a)&&richTextBoundary(text,a+inserted)&&text.substring(0,a)==old.substring(0,a)&&text.substring(a+inserted)==old.substring(b);}
 if(start==end&&text.length<old.length){final removed=old.length-text.length,a=afterStart<start?start-removed:start,b=afterStart<start?start:start+removed;return fits(a,b)?RichTextEdit(a,b):null;}
 return fits(start,end)?RichTextEdit(start,end):null;
}
List<RichTextRun> richRuns(Map<String,Object?> raw){
 final block=((validateDocument({'version':2,'blocks':[raw]})['blocks'] as List).single as Map).cast<String,Object?>(),text=block['text'] as String,result=<RichTextRun>[];var offset=0;
 void add(int start,int end,bool bold,bool italic){if(start<end)result.add(RichTextRun(start,end,text.substring(start,end),bold,italic));}
 for(final mark in (block['marks'] as List? ??const [])){
  add(offset,mark['start'] as int,block['bold'] as bool,block['italic'] as bool);
  add(mark['start'] as int,mark['end'] as int,mark['bold'] as bool,mark['italic'] as bool);offset=mark['end'] as int;
 }
 add(offset,text.length,block['bold'] as bool,block['italic'] as bool);return result;
}
Map<String,Object?> _markedBlock(Map<String,Object?> block,String text,List<Map<String,Object?>> runs){
 final spans=<Map<String,Object?>>[];
 for(final run in runs){if(run['bold']==block['bold']&&run['italic']==block['italic'])continue;
  if(spans.isNotEmpty&&spans.last['end']==run['start']&&spans.last['bold']==run['bold']&&spans.last['italic']==run['italic']){spans.last['end']=run['end'];}
  else{spans.add(Map<String,Object?>.from(run));}
 }
 final marks=_validateRichMarks(text,spans,block['bold'] as bool,block['italic'] as bool),result=Map<String,Object?>.from(block)..['text']=text..remove('marks');
 if(marks.isNotEmpty)result['marks']=marks;
 return ((validateDocument({'version':2,'blocks':[result]})['blocks'] as List).single as Map).cast<String,Object?>();
}
Map<String,Object?> toggleRichRange(Map<String,Object?> raw,int start,int end,String style){
 final block=((validateDocument({'version':2,'blocks':[raw]})['blocks'] as List).single as Map).cast<String,Object?>(),text=block['text'] as String;
 if(!['bold','italic'].contains(style)||!richTextBoundary(text,start)||!richTextBoundary(text,end)||start>=end)throw ArgumentError('invalid_range');
 final runs=richRuns(block),enabled=!runs.where((r)=>r.start<end&&r.end>start).every((r)=>style=='bold'?r.bold:r.italic),next=<Map<String,Object?>>[];
 for(final run in runs){final cuts=[run.start,if(start>run.start&&start<run.end)start,if(end>run.start&&end<run.end)end,run.end];
  for(var i=0;i<cuts.length-1;i++){final a=cuts[i],b=cuts[i+1];next.add({'start':a,'end':b,'bold':run.bold,'italic':run.italic,if(a>=start&&b<=end)style:enabled});}
 }
 return _markedBlock(block,text,next);
}
Map<String,Object?> replaceRichText(Map<String,Object?> raw,String text,[RichTextEdit? edit]){
 final block=((validateDocument({'version':2,'blocks':[raw]})['blocks'] as List).single as Map).cast<String,Object?>(),old=block['text'] as String;
 if(text.length>32768)throw ArgumentError('invalid_text');if(text==old)return block;
 var prefix=0,suffix=0;
 if(edit!=null){if(!richTextBoundary(old,edit.start)||!richTextBoundary(old,edit.end)||edit.start>edit.end)throw ArgumentError('invalid_edit');prefix=edit.start;suffix=old.length-edit.end;final insertEnd=text.length-suffix;if(insertEnd<prefix||!richTextBoundary(text,prefix)||!richTextBoundary(text,insertEnd)||old.substring(0,prefix)!=text.substring(0,prefix)||old.substring(edit.end)!=text.substring(insertEnd))throw ArgumentError('invalid_edit');}
 else{
  while(prefix<old.length&&prefix<text.length&&old[prefix]==text[prefix]){prefix++;}
  while(!richTextBoundary(old,prefix)||!richTextBoundary(text,prefix)){prefix--;}
  while(suffix<old.length-prefix&&suffix<text.length-prefix&&old[old.length-1-suffix]==text[text.length-1-suffix]){suffix++;}
  while(!richTextBoundary(old,old.length-suffix)||!richTextBoundary(text,text.length-suffix)){suffix--;}
 }
 final runs=richRuns(block),next=<Map<String,Object?>>[],insertEnd=text.length-suffix,oldEnd=old.length-suffix,delta=text.length-old.length;
 RichTextRun? inherited;for(final run in runs){if(run.start<=math.max(0,prefix-1)&&run.end>math.max(0,prefix-1)){inherited=run;break;}}
 for(final run in runs){if(run.start<prefix)next.add({'start':run.start,'end':math.min(run.end,prefix),'bold':run.bold,'italic':run.italic});}
 if(insertEnd>prefix)next.add({'start':prefix,'end':insertEnd,'bold':inherited?.bold??block['bold'],'italic':inherited?.italic??block['italic']});
 for(final run in runs){if(run.end>oldEnd)next.add({'start':math.max(run.start,oldEnd)+delta,'end':run.end+delta,'bold':run.bold,'italic':run.italic});}
 return _markedBlock(block,text,next);
}
class VirtualWindow {final int start,end;final double before,after;const VirtualWindow(this.start,this.end,this.before,this.after);}
VirtualWindow virtualWindow(int count,double offset,double height,double rowHeight,[int overscan=2]){if(count<0||count>100000||overscan<0||overscan>20||![offset,height,rowHeight].every((x)=>x.isFinite)||offset<0||height<=0||rowHeight<=0)throw ArgumentError('invalid_window');final start=math.min(count,math.max(0,(offset/rowHeight).floor()-overscan)),end=math.min(count,((offset+height)/rowHeight).ceil()+overscan);return VirtualWindow(start,math.max(start,end),start*rowHeight,math.max(0,(count-end)*rowHeight));}
class DataColumnSpec {final String key,label;double width;bool visible,pinned;DataColumnSpec(this.key,this.label,this.width,{this.visible=true,this.pinned=false});DataColumnSpec copy()=>DataColumnSpec(key,label,width,visible:visible,pinned:pinned);}
class DataRowSpec {final String id;final Map<String,Object?> values;DataRowSpec(this.id,Map<String,Object?> values):values=Map.unmodifiable(values);}
bool _identity(String value)=>RegExp(r'^[a-z0-9_-]{1,80}$').hasMatch(value);
class DataTableModel {List<DataRowSpec> rows=[];final List<DataColumnSpec> columns;final int pageSize;String query='';String? sortKey,expanded;bool descending=false;int page=0;Set<String> selected={};
 DataTableModel(List<DataColumnSpec> columns,List<DataRowSpec> rows,{this.pageSize=100}):columns=columns.map((c)=>c.copy()).toList(){if(pageSize<1||pageSize>1000||columns.isEmpty||columns.length>50||columns.map((c)=>c.key).toSet().length!=columns.length||columns.any((c)=>!_identity(c.key)||c.label.trim().isEmpty||!c.width.isFinite||c.width<=0)||!columns.any((c)=>c.visible))throw ArgumentError('invalid_columns');replace(rows);}
 void replace(List<DataRowSpec> next){if(next.length>100000||next.map((r)=>r.id).toSet().length!=next.length||next.any((r)=>!_identity(r.id)||r.values.values.any((v)=>v!=null&&v is! String&&v is! num&&v is! bool||v is num&&!v.isFinite)))throw ArgumentError('invalid_rows');rows=List.unmodifiable(next);final ids=next.map((r)=>r.id).toSet();selected=selected.intersection(ids);if(!ids.contains(expanded))expanded=null;page=0;}
 void filter(String value){if(value.length>1000)throw ArgumentError('invalid_filter');query=value.toLowerCase();page=0;}
 void sort(String key){column(key);descending=sortKey==key?!descending:false;sortKey=key;page=0;}
 DataColumnSpec column(String key)=>columns.firstWhere((c)=>c.key==key);
 List<DataColumnSpec> visible()=>[...columns.where((c)=>c.visible&&c.pinned),...columns.where((c)=>c.visible&&!c.pinned)];
 void configure(String key,{bool? visible,bool? pinned,double? width,int? move,required double minWidth,required double maxWidth}){final c=column(key);if(!minWidth.isFinite||!maxWidth.isFinite||minWidth<=0||maxWidth<minWidth||width!=null&&(!width.isFinite||width<minWidth||width>maxWidth)||move!=null&&![-1,1].contains(move))throw ArgumentError('invalid_column_config');if(visible==false&&this.visible().length==1&&c.visible)throw ArgumentError('last_visible_column');if(width!=null)c.width=width;if(visible!=null)c.visible=visible;if(pinned!=null)c.pinned=pinned;if(move!=null){final i=columns.indexOf(c),j=(i+move).clamp(0,columns.length-1);columns.removeAt(i);columns.insert(j,c);}}
 List<DataRowSpec> projected(){final result=rows.where((r)=>query.isEmpty||columns.any((c)=>(r.values[c.key]??'').toString().toLowerCase().contains(query))).toList();if(sortKey!=null){final original={for(var i=0;i<result.length;i++)result[i].id:i};result.sort((a,b){final x=a.values[sortKey],y=b.values[sortKey];final cmp=x==y?0:x==null?1:y==null?-1:x is num&&y is num?x.compareTo(y):x.toString().compareTo(y.toString());return cmp==0?original[a.id]!.compareTo(original[b.id]!):(descending?-cmp:cmp);});}return result;}
 ({List<DataRowSpec> rows,int total,int start}) pageRows(){final all=projected();page=page.clamp(0,math.max(0,(all.length/pageSize).ceil()-1));final start=page*pageSize;return(rows:all.sublist(start,math.min(all.length,start+pageSize)),total:all.length,start:start);}
 void toggle(String id){if(!rows.any((r)=>r.id==id))throw ArgumentError('unknown_row');if(!selected.remove(id))selected.add(id);}
}
String safeHttps(Object? value){if(value is! String||value.length>2048||RegExp(r'[\x00-\x20\x7f\\]').hasMatch(value)||!RegExp(r'^https://',caseSensitive:false).hasMatch(value))throw ArgumentError('unsafe_url');final u=Uri.tryParse(value);if(u==null||u.scheme.toLowerCase()!='https'||u.host.isEmpty||u.userInfo.isNotEmpty)throw ArgumentError('unsafe_url');return value;}
Map<String,Object?> validateDocument(Object? raw){if(raw is! Map||raw.keys.any((k)=>!['version','blocks'].contains(k))||!([1,2].contains(raw['version']))||raw['blocks'] is! List)throw ArgumentError('invalid_document');final blocks=raw['blocks'] as List;if(blocks.isEmpty||blocks.length>200)throw ArgumentError('invalid_document');var size=0,markCount=0;return {'version':raw['version']==2?2:1,'blocks':blocks.map((b){if(b is! Map||b.keys.any((k)=>!['text','bold','italic','kind','link','image','marks'].contains(k))||b['text'] is! String||b['bold'] is! bool||b['italic'] is! bool||!['paragraph','bullet'].contains(b['kind']))throw ArgumentError('invalid_block');size+=(b['text'] as String).length;if(size>32768)throw ArgumentError('document_too_large');final n=<String,Object?>{'text':b['text'],'bold':b['bold'],'italic':b['italic'],'kind':b['kind']};if(b.containsKey('marks')){if(raw['version']!=2)throw ArgumentError('range_document_version_required');final marks=_validateRichMarks(b['text'] as String,b['marks'],b['bold'] as bool,b['italic'] as bool);markCount+=marks.length;if(markCount>4096)throw ArgumentError('too_many_marks');if(marks.isNotEmpty)n['marks']=marks;}if(b.containsKey('link'))n['link']=safeHttps(b['link']);if(b.containsKey('image')){final image=b['image'];if(image is! Map||image.keys.any((k)=>!['url','alt'].contains(k))||image['alt'] is! String||(image['alt'] as String).trim().isEmpty||(image['alt'] as String).length>500)throw ArgumentError('invalid_image');n['image']={'url':safeHttps(image['url']),'alt':image['alt']};}return n;}).toList()};}
String formatMask(String value,String pattern){if(!RegExp(r'^[# ()+.-]{1,80}$').hasMatch(pattern)||!pattern.contains('#'))throw ArgumentError('invalid_mask');final digits=value.replaceAll(RegExp(r'\D'),'');var i=0,result='';for(final c in pattern.split('')){if(i>=digits.length)break;result+=c=='#'?digits[i++]:c;}return result;}
String? fieldError(String value,String kind,{bool required=false,double? min,double? max,double? step,String? pattern}){if(value.trim().isEmpty)return required?'required':null;if(kind=='number'){if(!RegExp(r'^[+-]?(?:\d+(?:\.\d*)?|\.\d+)$').hasMatch(value))return 'invalid';final n=double.tryParse(value);if(n==null||!n.isFinite||min!=null&&n<min||max!=null&&n>max||step!=null&&(step<=0||((n-(min??0))/step-((n-(min??0))/step).round()).abs()>1e-7))return 'invalid';}if(kind=='date'){if(!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)||value.startsWith('0000'))return 'invalid';final t=DateTime.tryParse('${value}T00:00:00Z');if(t==null||t.toIso8601String().substring(0,10)!=value)return 'invalid';}if(kind=='time'&&!RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(value))return 'invalid';if(kind=='mask'&&(pattern==null||formatMask(value,pattern)!=value||value.replaceAll(RegExp(r'\D'),'').length!='#'.allMatches(pattern).length))return 'invalid';return null;}
class UploadCandidate {final String name,type;final int size;final Object handle;const UploadCandidate(this.name,this.size,this.type,this.handle);}
class UploadPolicy {final int maxFiles,maxBytes;final List<String> types;const UploadPolicy({required this.maxFiles,required this.maxBytes,required this.types});}
List<UploadCandidate> validateFiles(List<UploadCandidate> files,UploadPolicy p){if(p.maxFiles<1||p.maxFiles>100||p.maxBytes<1||p.types.isEmpty||files.isEmpty||files.length>p.maxFiles)throw ArgumentError('invalid_files');var bytes=0;for(final f in files){if(f.name.trim().isEmpty||f.name.length>255||RegExp(r'[/\\\x00-\x1f\x7f]').hasMatch(f.name)||f.size<0||!p.types.contains(f.type))throw ArgumentError('invalid_files');bytes+=f.size;if(bytes>p.maxBytes)throw ArgumentError('invalid_files');}return List.unmodifiable(files);}
