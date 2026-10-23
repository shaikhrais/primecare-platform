import {test} from 'node:test';
import assert from 'node:assert/strict';
import {InboundMailTextPreview} from '../packages/shared/src/communications/mail-preview.mjs';
import {BoundedBinaryAdapterBase} from '../packages/shared/src/communications/adapter-base.mjs';
import limits from '../packages/shared/src/communications/registered-mail-preview-limits.json' with {type:'json'};
const encode=value=>Buffer.from(value,'utf8').toString('base64');
const plain=(text,subject='Test')=>'From: forged@example.invalid\r\nSubject: '+subject+'\r\nMIME-Version: 1.0\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n'+text;
const project=raw=>new InboundMailTextPreview(65536).project(encode(raw));
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
test('HTML-only messages are withheld instead of forwarding markup or remote media',async()=>{
 const result=await project('Content-Type: text/html; charset=utf-8\r\n\r\n<p>Visible body</p><img src="https://example.invalid/tracker">');
 assert.deepEqual(result,{status:'unavailable'});
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
