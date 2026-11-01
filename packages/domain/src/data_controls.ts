/** Bounded presentation models. Caller supplies authorized projections; no business policy or transport. */
export type Cell=string|number|boolean|null;
export type DataRow={id:string;values:Record<string,Cell>};
export type DataColumn={key:string;label:string;width:number;visible:boolean;pinned:boolean};
const identity=(v:string)=>typeof v==='string'&&/^[a-z0-9_-]{1,80}$/.test(v);
export function virtualWindow(count:number,offset:number,height:number,rowHeight:number,overscan=2){if(![count,overscan].every(Number.isSafeInteger)||count<0||count>100000||overscan<0||overscan>20||![offset,height,rowHeight].every(Number.isFinite)||offset<0||height<=0||rowHeight<=0)throw Error('invalid_window');const start=Math.min(count,Math.max(0,Math.floor(offset/rowHeight)-overscan)),end=Math.min(count,Math.ceil((offset+height)/rowHeight)+overscan);return {start,end:Math.max(start,end),before:start*rowHeight,after:Math.max(0,(count-end)*rowHeight)};}
export class DataTableModel {
 rows:readonly DataRow[]=[];columns:DataColumn[];query='';sortKey:string|null=null;descending=false;page=0;selected=new Set<string>();expanded:string|null=null;
 constructor(columns:readonly DataColumn[],rows:readonly DataRow[],readonly pageSize=100){if(!Number.isInteger(pageSize)||pageSize<1||pageSize>1000||columns.length<1||columns.length>50||new Set(columns.map(c=>c.key)).size!==columns.length||columns.some(c=>!identity(c.key)||!c.label.trim()||!Number.isFinite(c.width)||c.width<=0))throw Error('invalid_columns');this.columns=columns.map(c=>({...c}));if(!this.columns.some(c=>c.visible))throw Error('no_visible_columns');this.replace(rows);}
 replace(rows:readonly DataRow[]){if(rows.length>100000||new Set(rows.map(r=>r.id)).size!==rows.length||rows.some(r=>!identity(r.id)||Object.values(r.values).some(v=>v!==null&&!['string','number','boolean'].includes(typeof v)||typeof v==='number'&&!Number.isFinite(v))))throw Error('invalid_rows');this.rows=rows.map(r=>Object.freeze({id:r.id,values:Object.freeze({...r.values})}));const ids=new Set(rows.map(r=>r.id));this.selected=new Set([...this.selected].filter(id=>ids.has(id)));if(this.expanded&&!ids.has(this.expanded))this.expanded=null;this.page=0;}
 filter(query:string){if(query.length>1000)throw Error('invalid_filter');this.query=query.toLowerCase();this.page=0;}
 sort(key:string){this.column(key);this.descending=this.sortKey===key?!this.descending:false;this.sortKey=key;this.page=0;}
 private column(key:string){const c=this.columns.find(c=>c.key===key);if(!c)throw Error('unknown_column');return c;}
 visible(){return [...this.columns.filter(c=>c.visible&&c.pinned),...this.columns.filter(c=>c.visible&&!c.pinned)];}
 configure(key:string,change:{visible?:boolean;pinned?:boolean;width?:number;move?:number},minWidth:number,maxWidth:number){const c=this.column(key);if(!Number.isFinite(minWidth)||!Number.isFinite(maxWidth)||minWidth<=0||maxWidth<minWidth||change.width!==undefined&&(!Number.isFinite(change.width)||change.width<minWidth||change.width>maxWidth)||change.move!==undefined&&![-1,1].includes(change.move))throw Error('invalid_column_config');if(change.visible===false&&this.visible().length===1&&c.visible)throw Error('last_visible_column');if(change.width!==undefined)c.width=change.width;if(change.visible!==undefined)c.visible=change.visible;if(change.pinned!==undefined)c.pinned=change.pinned;if(change.move){const i=this.columns.indexOf(c),j=Math.max(0,Math.min(this.columns.length-1,i+change.move));this.columns.splice(i,1);this.columns.splice(j,0,c);}}
 projected(){const q=this.query,keys=this.columns.map(c=>c.key);const result=this.rows.filter(r=>!q||keys.some(k=>String(r.values[k]??'').toLowerCase().includes(q)));if(this.sortKey){const k=this.sortKey,d=this.descending?-1:1;result.sort((a,b)=>{const x=a.values[k]??null,y=b.values[k]??null;return d*(x===y?0:x===null?1:y===null?-1:typeof x==='number'&&typeof y==='number'?x-y:String(x)<String(y)?-1:1);});}return result;}
 pageRows(){const rows=this.projected();this.page=Math.max(0,Math.min(this.page,Math.max(0,Math.ceil(rows.length/this.pageSize)-1)));return {total:rows.length,start:this.page*this.pageSize,rows:rows.slice(this.page*this.pageSize,(this.page+1)*this.pageSize)};}
 toggle(id:string){if(!this.rows.some(r=>r.id===id))throw Error('unknown_row');this.selected.has(id)?this.selected.delete(id):this.selected.add(id);}
}
export function safeHttps(value:unknown){if(typeof value!=='string'||value.length>2048||/[\u0000-\u0020\u007f\\]/.test(value)||!/^https:\/\//i.test(value))throw Error('unsafe_url');let u:URL;try{u=new URL(value);}catch{throw Error('unsafe_url');}if(u.protocol!=='https:'||!u.hostname||u.username||u.password)throw Error('unsafe_url');return value;}
export type RichMark={start:number;end:number;bold:boolean;italic:boolean};
export type RichRun=RichMark&{text:string};
export type RichTextEdit={start:number;end:number};
export type RichBlock={marks?:RichMark[];text:string;bold:boolean;italic:boolean;kind:'paragraph'|'bullet';link?:string;image?:{url:string;alt:string}};
export type RichDocument={version:1|2;blocks:RichBlock[]};
/** Offsets use UTF-16 on web and Dart; never divide a surrogate pair. */
export function richTextBoundary(text:string,offset:number){return Number.isSafeInteger(offset)&&offset>=0&&offset<=text.length&&!(offset>0&&offset<text.length&&text.charCodeAt(offset-1)>=0xd800&&text.charCodeAt(offset-1)<=0xdbff&&text.charCodeAt(offset)>=0xdc00&&text.charCodeAt(offset)<=0xdfff);}
function validateRichMarks(text:string,raw:unknown,bold:boolean,italic:boolean):RichMark[]{
 if(!Array.isArray(raw)||raw.length>1024)throw Error('invalid_marks');
 const result:RichMark[]=[];let previousEnd=0;
 for(const mark of raw){
  if(!mark||typeof mark!=='object'||Object.keys(mark).sort().join(',')!=='bold,end,italic,start'||typeof mark.bold!=='boolean'||typeof mark.italic!=='boolean'||!richTextBoundary(text,mark.start)||!richTextBoundary(text,mark.end)||mark.start>=mark.end||mark.start<previousEnd)throw Error('invalid_mark');
  previousEnd=mark.end;if(mark.bold===bold&&mark.italic===italic)continue;
  const last=result.at(-1);
  if(last&&last.end===mark.start&&last.bold===mark.bold&&last.italic===mark.italic)last.end=mark.end;
  else result.push({start:mark.start,end:mark.end,bold:mark.bold,italic:mark.italic});
 }
 return result;
}
export function richRuns(raw:RichBlock):RichRun[]{
 const block=validateDocument({version:2,blocks:[raw]}).blocks[0],result:RichRun[]=[];let offset=0;
 const add=(start:number,end:number,bold:boolean,italic:boolean)=>{if(start<end)result.push({start,end,text:block.text.slice(start,end),bold,italic});};
 for(const mark of block.marks??[]){add(offset,mark.start,block.bold,block.italic);add(mark.start,mark.end,mark.bold,mark.italic);offset=mark.end;}
 add(offset,block.text.length,block.bold,block.italic);return result;
}
function markedBlock(block:RichBlock,text:string,runs:readonly RichMark[]):RichBlock{
 const spans:RichMark[]=[];
 for(const run of runs){if(run.bold===block.bold&&run.italic===block.italic)continue;const last=spans.at(-1);if(last&&last.end===run.start&&last.bold===run.bold&&last.italic===run.italic)last.end=run.end;else spans.push({...run});}
 const marks=validateRichMarks(text,spans,block.bold,block.italic),result={...block,text};
 delete result.marks;if(marks.length)result.marks=marks;return validateDocument({version:2,blocks:[result]}).blocks[0];
}
export function toggleRichRange(raw:RichBlock,start:number,end:number,style:'bold'|'italic'):RichBlock{
 const block=validateDocument({version:2,blocks:[raw]}).blocks[0];
 if(!['bold','italic'].includes(style)||!richTextBoundary(block.text,start)||!richTextBoundary(block.text,end)||start>=end)throw Error('invalid_range');
 const runs=richRuns(block),enabled=!runs.filter(r=>r.start<end&&r.end>start).every(r=>r[style]);const next:RichMark[]=[];
 for(const run of runs){const cuts=[run.start,...[start,end].filter(n=>n>run.start&&n<run.end),run.end];
  for(let i=0;i<cuts.length-1;i++){const a=cuts[i],b=cuts[i+1];next.push({start:a,end:b,bold:run.bold,italic:run.italic,...(a>=start&&b<=end?{[style]:enabled}:{})});}}
 return markedBlock(block,block.text,next);
}
/** Rebase marks around one contiguous edit; inserted text inherits its neighbouring style. */
export function inferRichEdit(old:string,text:string,start:number,end:number,afterStart:number):RichTextEdit|null{
 if(!richTextBoundary(old,start)||!richTextBoundary(old,end)||start>end||!richTextBoundary(text,afterStart))return null;
 const fits=(a:number,b:number)=>{const inserted=text.length-(old.length-(b-a));return richTextBoundary(old,a)&&richTextBoundary(old,b)&&inserted>=0&&richTextBoundary(text,a)&&richTextBoundary(text,a+inserted)&&text.slice(0,a)===old.slice(0,a)&&text.slice(a+inserted)===old.slice(b);};
 if(start===end&&text.length<old.length){const removed=old.length-text.length,a=afterStart<start?start-removed:start,b=afterStart<start?start:start+removed;return fits(a,b)?{start:a,end:b}:null;}
 return fits(start,end)?{start,end}:null;
}
export function replaceRichText(raw:RichBlock,text:string,edit?:RichTextEdit):RichBlock{
 const block=validateDocument({version:2,blocks:[raw]}).blocks[0];if(typeof text!=='string'||text.length>32768)throw Error('invalid_text');
 if(text===block.text)return block;
 let prefix=0,suffix=0;const old=block.text;
 if(edit!==undefined){if(!edit||Object.keys(edit).sort().join(',')!=='end,start'||!richTextBoundary(old,edit.start)||!richTextBoundary(old,edit.end)||edit.start>edit.end)throw Error('invalid_edit');prefix=edit.start;suffix=old.length-edit.end;const insertEnd=text.length-suffix;if(insertEnd<prefix||!richTextBoundary(text,prefix)||!richTextBoundary(text,insertEnd)||old.slice(0,prefix)!==text.slice(0,prefix)||old.slice(edit.end)!==text.slice(insertEnd))throw Error('invalid_edit');}
 else{
  while(prefix<old.length&&prefix<text.length&&old[prefix]===text[prefix])prefix++;
  while(!richTextBoundary(old,prefix)||!richTextBoundary(text,prefix))prefix--;
  while(suffix<old.length-prefix&&suffix<text.length-prefix&&old[old.length-1-suffix]===text[text.length-1-suffix])suffix++;
  while(!richTextBoundary(old,old.length-suffix)||!richTextBoundary(text,text.length-suffix))suffix--;
 }
 const runs=richRuns(block),next:RichMark[]=[],insertEnd=text.length-suffix,oldEnd=old.length-suffix,delta=text.length-old.length;
 const inherited=runs.find(r=>r.start<=Math.max(0,prefix-1)&&r.end>Math.max(0,prefix-1))??block;
 for(const run of runs)if(run.start<prefix)next.push({start:run.start,end:Math.min(run.end,prefix),bold:run.bold,italic:run.italic});
 if(insertEnd>prefix)next.push({start:prefix,end:insertEnd,bold:inherited.bold,italic:inherited.italic});
 for(const run of runs)if(run.end>oldEnd)next.push({start:Math.max(run.start,oldEnd)+delta,end:run.end+delta,bold:run.bold,italic:run.italic});
 return markedBlock(block,text,next);
}
export function validateDocument(raw:unknown):RichDocument{const o=raw as RichDocument;if(!o||typeof o!=='object'||Object.keys(o).some(k=>!['version','blocks'].includes(k))||![1,2].includes(o.version)||!Array.isArray(o.blocks)||o.blocks.length<1||o.blocks.length>200)throw Error('invalid_document');let size=0,totalMarks=0;const blocks=o.blocks.map(b=>{if(!b||typeof b!=='object'||Object.keys(b).some(k=>!['text','bold','italic','kind','link','image','marks'].includes(k))||typeof b.text!=='string'||typeof b.bold!=='boolean'||typeof b.italic!=='boolean'||!['paragraph','bullet'].includes(b.kind))throw Error('invalid_block');size+=b.text.length;if(size>32768)throw Error('document_too_large');const n:RichBlock={text:b.text,bold:b.bold,italic:b.italic,kind:b.kind};if(b.marks!==undefined){if(o.version!==2)throw Error('range_document_version_required');const marks=validateRichMarks(b.text,b.marks,b.bold,b.italic);totalMarks+=marks.length;if(totalMarks>4096)throw Error('too_many_marks');if(marks.length)n.marks=marks;}if(b.link!==undefined)n.link=safeHttps(b.link);if(b.image!==undefined){if(!b.image||Object.keys(b.image).some(k=>!['url','alt'].includes(k))||typeof b.image.alt!=='string'||!b.image.alt.trim()||b.image.alt.length>500)throw Error('invalid_image');n.image={url:safeHttps(b.image.url),alt:b.image.alt};}return n;});return {version:o.version,blocks};}
export type FieldConstraint={kind:'date'|'time'|'number'|'mask';required?:boolean;min?:number;max?:number;step?:number;pattern?:string};
export function formatMask(value:string,pattern:string){if(!/^[# ()+.-]{1,80}$/.test(pattern)||!pattern.includes('#'))throw Error('invalid_mask');const digits=value.replace(/\D/g,'');let i=0,result='';for(const c of pattern){if(i>=digits.length)break;result+=c==='#'?digits[i++]:c;}return result;}
export function fieldError(value:string,c:FieldConstraint):'required'|'invalid'|null{if(!value.trim())return c.required?'required':null;if(c.kind==='number'){if(!/^[+-]?(?:\d+(?:\.\d*)?|\.\d+)$/.test(value))return 'invalid';const n=Number(value);if(!Number.isFinite(n)||c.min!==undefined&&n<c.min||c.max!==undefined&&n>c.max||c.step!==undefined&&(c.step<=0||Math.abs((n-(c.min??0))/c.step-Math.round((n-(c.min??0))/c.step))>1e-7))return 'invalid';}if(c.kind==='date'){if(!/^\d{4}-\d{2}-\d{2}$/.test(value)||value.slice(0,4)==='0000')return 'invalid';const t=new Date(value+'T00:00:00Z');if(!Number.isFinite(t.getTime())||t.toISOString().slice(0,10)!==value)return 'invalid';}if(c.kind==='time'&&!/^([01]\d|2[0-3]):[0-5]\d$/.test(value))return 'invalid';if(c.kind==='mask'&&(!c.pattern||formatMask(value,c.pattern)!==value||value.replace(/\D/g,'').length!==(c.pattern.match(/#/g)??[]).length))return 'invalid';return null;}
export type UploadCandidate={name:string;size:number;type:string;handle:unknown};
export type UploadPolicy={maxFiles:number;maxBytes:number;types:readonly string[]};
export function validateFiles(files:readonly UploadCandidate[],p:UploadPolicy){if(!Number.isSafeInteger(p.maxFiles)||p.maxFiles<1||p.maxFiles>100||!Number.isSafeInteger(p.maxBytes)||p.maxBytes<1||!p.types.length||!files.length||files.length>p.maxFiles)throw Error('invalid_files');let size=0;for(const f of files){if(!f.name.trim()||f.name.length>255||/[\/\\\u0000-\u001f\u007f]/.test(f.name)||!Number.isSafeInteger(f.size)||f.size<0||!p.types.includes(f.type))throw Error('invalid_files');size+=f.size;if(!Number.isSafeInteger(size)||size>p.maxBytes)throw Error('invalid_files');}return files.map(f=>({...f}));}
