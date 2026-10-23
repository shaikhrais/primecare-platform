import {test} from 'node:test';
import assert from 'node:assert/strict';
import {InboundMailTextPreview,HtmlMailTextExtractor} from '../packages/shared/src/communications/mail-preview.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import limits from '../packages/shared/src/communications/registered-mail-preview-limits.json' with {type:'json'};
const encode=value=>Buffer.from(value,'utf8').toString('base64');
const plain=(text,subject='Test')=>'From: forged@example.invalid\r\nSubject: '+subject+'\r\nMIME-Version: 1.0\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n'+text;
const project=raw=>new InboundMailTextPreview(65536).project(encode(raw));
const html=body=>'Content-Type: text/html; charset=utf-8\r\n\r\n'+body;
function multipart(parts){return 'MIME-Version: 1.0\r\nContent-Type: multipart/mixed; boundary="outer"\r\n\r\n'+parts.map(part=>'--outer\r\n'+part+'\r\n').join('')+'--outer--\r\n';}
test('bounded inherited parser decodes real UTF-8 text and encoded subject',async()=>{
 const parser=new InboundMailTextPreview(65536);assert.ok(parser instanceof BoundedBinaryAdapterBase);
 const result=await parser.project(encode(plain('Bonjour café\r\nSecond line','=?UTF-8?B?Q2Fmw6k=?=')));
 assert.equal(result.status,'available');assert.equal(result.text.trim(),'Bonjour café\nSecond line');assert.equal(result.subject,'Café');assert.equal(Object.isFrozen(result),true);
});
test('real quoted-printable and base64 bodies decode to plain text',async()=>{
 for(const [transfer,body] of [['quoted-printable','caf=C3=A9'],['base64',Buffer.from('café').toString('base64')]]){
  const raw='Content-Type: text/plain; charset=utf-8\r\nContent-Transfer-Encoding: '+transfer+'\r\n\r\n'+body;
  assert.equal((await project(raw)).text.trim(),'café');
 }
});
test('HTML-only messages expose text without markup or remote media',async()=>{
 const result=await project(html('<p>Visible body</p><img src="https://example.invalid/tracker" alt="PRIVATE ALT">'));
 assert.deepEqual(result,{status:'available',text:'Visible body'});
});
test('binary attachments and attached messages never enter the preview',async()=>{
 const result=await project(multipart(['Content-Type: text/plain\r\n\r\nVisible main body','Content-Type: application/octet-stream\r\nContent-Disposition: attachment; filename="private.txt"\r\nContent-Transfer-Encoding: base64\r\n\r\n'+encode('PRIVATE ATTACHMENT'),'Content-Type: message/rfc822\r\n\r\nFrom: hidden@example.invalid\r\nSubject: ATTACHED SECRET\r\n\r\nPRIVATE NESTED BODY']));
 assert.equal(result.status,'available');assert.ok(result.text.includes('Visible main body'));
 for(const value of ['PRIVATE ATTACHMENT','ATTACHED SECRET','PRIVATE NESTED BODY','hidden@example.invalid','private.txt'])assert.ok(!JSON.stringify(result).includes(value));
});
test('an attached-message-only email has no exposed preview',async()=>{
 const result=await project('Content-Type: message/rfc822\r\n\r\nSubject: PRIVATE ATTACHED\r\n\r\nSECRET');assert.deepEqual(result,{status:'unavailable'});
});
test('oversized raw base64 is rejected before invoking a parser',async()=>{
 let calls=0;const parser=new InboundMailTextPreview(100,{parse:async()=>{calls++;return {text:'wrong'};}});
 assert.deepEqual(await parser.project(encode('x'.repeat(101))),{status:'unavailable'});assert.equal(calls,0);
});
test('corrupt and noncanonical stored base64 never reaches parsing',async()=>{
 let calls=0;const parser=new InboundMailTextPreview(100,{parse:async()=>{calls++;return {text:'wrong'};}});
 for(const value of [null,'','%%%=', 'YQ=','YQ==\n','YR=='])assert.deepEqual(await parser.project(value),{status:'unavailable'});
 assert.equal(calls,0);
});
test('decoded body byte limit counts UTF-8 instead of character count',async()=>{
 const parser=new InboundMailTextPreview(65536,{parse:async()=>({text:'é'.repeat(40000)})});assert.deepEqual(await parser.project(encode('raw')),{status:'unavailable'});
});
test('the configured raw limit also bounds a decoded preview',async()=>{
 const parser=new InboundMailTextPreview(10,{parse:async()=>({text:'x'.repeat(11)})});assert.deepEqual(await parser.project(encode('raw')),{status:'unavailable'});
});
test('aggregate MIME header budget cannot be renewed for each part',async()=>{
 const parts=Array.from({length:12},()=>('X-Padding: '+'x'.repeat(1500)+'\r\nContent-Type: text/plain\r\n\r\nBody'));
 const raw=multipart(parts);assert.ok(Buffer.byteLength(raw)<limits.maxRawBytes);assert.deepEqual(await project(raw),{status:'unavailable'});
});
test('wide MIME messages fail at the registered total part count',async()=>{
 const raw=multipart(Array.from({length:limits.maxPartCount+1},()=> 'Content-Type: text/plain\r\n\r\nBody'));assert.deepEqual(await project(raw),{status:'unavailable'});
});
test('deep MIME structures fail at the registered nesting depth',async()=>{
 let body='Content-Type: text/plain\r\n\r\nBody';
 for(let n=0;n<limits.maxNestingDepth+2;n++)body='Content-Type: multipart/mixed; boundary="b'+n+'"\r\n\r\n--b'+n+'\r\n'+body+'\r\n--b'+n+'--\r\n';
 assert.deepEqual(await project(body),{status:'unavailable'});
});
test('oversized subjects and decoded control characters do not create partial previews',async()=>{
 assert.deepEqual(await project(plain('Body','x'.repeat(limits.maxSubjectLength+1))),{status:'unavailable'});
 assert.deepEqual(await project(plain('Body\u0000with control')),{status:'unavailable'});
});
test('parser failures and malformed outputs do not expose internal or partial data',async()=>{
 for(const parse of [async()=>{throw Error('PRIVATE PARSER DETAIL');},async()=>({text:4}),async()=>({text:'',subject:'Private partial subject'}),async()=>({text:'Safe',subject:'unsafe\nsubject'})]){
  assert.deepEqual(await new InboundMailTextPreview(100,{parse}).project(encode('raw')),{status:'unavailable'});
 }
});
test('only a snapshot of the allowed text/subject is returned; identity and provider claims are ignored',async()=>{
 const parsed={text:'Safe body',subject:'Safe subject',from:{address:'forged@example.invalid'},senderIdentityVerified:true,tenantId:'wrong',html:'<script>secret</script>',attachments:[{content:'secret'}]};
 const result=await new InboundMailTextPreview(100,{parse:async()=>parsed}).project(encode('raw'));parsed.text='Changed';assert.deepEqual(result,{status:'available',text:'Safe body',subject:'Safe subject'});
});
test('invalid construction cannot silently disable byte limits or parser validation',()=>{
 for(const value of [0,-1,NaN,Infinity,'100',null])assert.throws(()=>new InboundMailTextPreview(value));
 assert.throws(()=>new InboundMailTextPreview(100,{parse:null}));
});
test('HTML extractor shares the bounded base and preserves paragraph, list and table separators',async()=>{
 const parser=new HtmlMailTextExtractor(65536);assert.ok(parser instanceof BoundedBinaryAdapterBase);
 assert.equal(parser.extract('<h1>Title</h1><p>Hello <b>café</b><br>Next</p><ul><li>One<li>Two</ul><table><tr><td>A<td>B</table>'),'Title\nHello café\nNext\nOne\nTwo\nA\nB');
});
test('active, unknown, foreign and embedded HTML subtrees are omitted completely',async()=>{
 const tags=['head','script','style','template','noscript','iframe','object','svg','math','form','textarea','select','button','custom-element'];
 const result=await project(html('<p>Before</p>'+tags.map(tag=>'<'+tag+'>PRIVATE '+tag+'<span>SECRET</span></'+tag+'>').join('')+'<p>After</p>'));
 assert.deepEqual(result,{status:'available',text:'Before\nAfter'});
});
test('explicit hidden subtrees, comments and all attribute values are excluded',async()=>{
 const result=await project(html('Before<span hidden="false">SECRET hidden</span><span ARIA-HIDDEN=" TRUE ">SECRET aria</span><!--SECRET comment--><a href="javascript:SECRET()" title="SECRET title">Link label</a><img alt="SECRET alt" src="https://example.invalid/SECRET">After'));
 assert.deepEqual(result,{status:'available',text:'Before\nLink label\nAfter'});
});
test('entity decoding is single-pass displayable text including markup-shaped text',async()=>{
 const result=await project(html('<p>Caf&eacute; &amp; &#128512; &lt;img src=x onerror=evil()&gt; &amp;lt;b&amp;gt;</p>'));
 assert.deepEqual(result,{status:'available',text:'Café & 😀 <img src=x onerror=evil()> &lt;b&gt;'});
});
test('HTML processing has no browser document and never calls fetch for remote content',async t=>{
 const fetch=t.mock.method(globalThis,'fetch',()=>assert.fail('No HTML fetch permitted'));
 assert.equal(typeof globalThis.document,'undefined');
 assert.deepEqual(await project(html('<link href="https://example.invalid/a"><p style="background:url(https://example.invalid/b)">Body</p><img src="https://example.invalid/c"><iframe src="https://example.invalid/d">secret</iframe>')),{status:'available',text:'Body'});
 assert.equal(fetch.mock.callCount(),0);
});
test('real multipart alternatives prefer plain text even when HTML has another meaning',async()=>{
 const raw=multipart(['Content-Type: text/plain\r\n\r\nPlain body','Content-Type: text/html\r\n\r\n<p>Different HTML body</p>']).replace('multipart/mixed','multipart/alternative');
 assert.equal((await project(raw)).text.trim(),'Plain body');
});
test('invalid, empty or oversized plain text never falls back to alternate HTML',async()=>{
 for(const text of ['',null,4,'bad\u0000text','é'.repeat(40000)]){
  const parser=new InboundMailTextPreview(65536,{parse:async()=>({text,html:'<p>BYPASS</p>'})});
  assert.deepEqual(await parser.project(encode('raw')),{status:'unavailable'});
 }
});
test('decoded HTML input is separately bounded before parsing, including UTF-8 bytes',async()=>{
 for(const body of ['x'.repeat(limits.maxHtmlBytes+1),'é'.repeat(limits.maxHtmlBytes/2+1)]){
  const parser=new InboundMailTextPreview(65536,{parse:async()=>({html:body,subject:'PRIVATE partial'})});
  assert.deepEqual(await parser.project(encode('raw')),{status:'unavailable'});
 }
});
test('deep HTML fails closed without a partial preview or subject',async()=>{
 const raw=html('<p>PRIVATE partial</p>'+'<div>'.repeat(limits.maxHtmlDepth+1)+'body'+'</div>'.repeat(limits.maxHtmlDepth+1));
 assert.deepEqual(await project(raw),{status:'unavailable'});
});
test('wide HTML and excessive callbacks fail inside the raw byte budget',async()=>{
 for(const body of ['<span>x</span>'.repeat(Math.ceil(limits.maxHtmlEvents/4)+1),'<!---->'.repeat(limits.maxHtmlEvents+1),'&amp;'.repeat(limits.maxHtmlEvents+1)]){
  assert.ok(Buffer.byteLength(body)<limits.maxHtmlBytes);
  assert.deepEqual(await project(html(body)),{status:'unavailable'});
 }
});
test('attribute callbacks count toward the shared HTML event budget',async()=>{
 const body='<p '+Array.from({length:limits.maxHtmlEvents},()=> 'x=""').join(' ')+'>PRIVATE partial</p>';
 assert.ok(Buffer.byteLength(body)<limits.maxHtmlBytes);assert.deepEqual(await project(html(body)),{status:'unavailable'});
});
test('UTF-8 output has an independent bound and failed extraction returns no partial content',()=>{
 const parser=new HtmlMailTextExtractor(65536,7);
 assert.throws(()=>parser.extract('<p>éééé</p>'),/text budget/);
 assert.equal(new HtmlMailTextExtractor(65536,10).extract('<p>éééé</p>'),'éééé');
});
test('HTML attachments never become a preview and empty or excluded-only HTML is unavailable',async()=>{
 for(const raw of ['Content-Type: text/html\r\nContent-Disposition: attachment; filename="private.html"\r\n\r\n<p>SECRET</p>',html(''),html('<script>SECRET</script>'),html('<!--SECRET-->')])assert.deepEqual(await project(raw),{status:'unavailable'});
});
test('malformed HTML remains plain text and cannot promote attributes or excluded content',async()=>{
 assert.deepEqual(await project(html('<p>One<p>Two<b> end')),{status:'available',text:'One\nTwo end'});
 assert.deepEqual(await project(html('<p>Safe</p><script>PRIVATE <p>never closes')),{status:'available',text:'Safe'});
});
test('invalid HTML extractor configuration cannot remove limits',()=>{
 for(const value of [0,-1,NaN,Infinity,'100',null]){
  assert.throws(()=>new HtmlMailTextExtractor(value));assert.throws(()=>new HtmlMailTextExtractor(100,value));
 }
 for(const value of [null,4,[],{}])assert.throws(()=>new HtmlMailTextExtractor(100).extract(value));
});
