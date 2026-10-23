import PostalMime from 'postal-mime';
import {Parser} from 'htmlparser2';
import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import registeredLimits from './registered-mail-preview-limits.json' with {type:'json'};
const limits=Object.freeze({...registeredLimits});

const unavailable=Object.freeze({status:'unavailable'});
const encoder=new TextEncoder();
const controls=/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/;
const blocks=new Set('address article aside blockquote caption dd div dl dt figcaption figure footer h1 h2 h3 h4 h5 h6 header hr li main nav ol p pre section table tbody td tfoot th thead tr ul br'.split(' '));
const textElements=new Set([...blocks,...'html body a abbr b bdi bdo big center cite code del em font i ins kbd mark q s samp small span strike strong sub sup time tt u var wbr'.split(' ')]);

/** Extract displayable text, never HTML. Unknown/active subtrees are omitted.
 * This deliberately does not evaluate CSS, layout, URLs or attachments.
 */
export class HtmlMailTextExtractor extends BoundedBinaryAdapterBase {
 constructor(maximumBytes,maximumTextBytes=limits.maxTextBytes) {
  super(Math.min(maximumBytes,limits.maxHtmlBytes));
  if(!Number.isSafeInteger(maximumBytes)||maximumBytes<1||!Number.isSafeInteger(maximumTextBytes)||maximumTextBytes<1)throw Error('Configured HTML text limits required');
  this.maxTextBytes=Math.min(maximumTextBytes,limits.maxTextBytes);
 }
 extract(html) {
  if(typeof html!=='string')throw Error('HTML text input required');
  this.validateBytes(encoder.encode(html));
  const stack=[],chunks=[];let events=0,outputBytes=0;
  const event=()=>{if(++events>limits.maxHtmlEvents)throw Error('HTML event budget');};
  const append=text=>{
   outputBytes+=encoder.encode(text).byteLength;
   if(outputBytes>this.maxTextBytes)throw Error('HTML text budget');
   chunks.push(text);
  };
  const parser=new Parser({
   onopentagname(){event();if(stack.length>=limits.maxHtmlDepth)throw Error('HTML depth budget');},
   onattribute(){event();},
   onopentag(name,attributes){
    event();
    const omit=Boolean(stack.at(-1)?.omit)||!textElements.has(name)||Object.hasOwn(attributes,'hidden')||attributes['aria-hidden']?.trim().toLowerCase()==='true';
    if(!stack.at(-1)?.omit&&(omit||blocks.has(name)))append('\n');
    stack.push({name,omit});
   },
   onclosetag(name){
    event();const frame=stack.pop();
    if(frame?.name!==name)throw Error('HTML parser structure');
    if(!stack.at(-1)?.omit&&(frame.omit||blocks.has(name)))append('\n');
   },
   ontext(text){event();if(!stack.at(-1)?.omit)append(text.replace(/[\t\n\r\f \u00a0]+/g,' '));},
   oncomment(){event();},onprocessinginstruction(){event();},
   onerror(error){throw error;}
  },{decodeEntities:true,xmlMode:false,lowerCaseTags:true,lowerCaseAttributeNames:true});
  parser.end(html);
  return chunks.join('').replace(/ *\n+ */g,'\n').replace(/ {2,}/g,' ').trim();
 }
}

/** Validate and snapshot every adapter result at the public projection boundary. */
export function boundedMailPreview(value,maximumBytes) {
 try {
  if(!Number.isSafeInteger(maximumBytes)||maximumBytes<1||!value||typeof value!=='object'||Array.isArray(value))return unavailable;
  const {status,text,subject}=value;
  const keys=Object.keys(value);
  if(status==='unavailable')return unavailable;
  if(status!=='available'||keys.some(key=>!['status','text','subject'].includes(key))||typeof text!=='string'||!text.trim()||controls.test(text)||encoder.encode(text).byteLength>Math.min(maximumBytes,limits.maxTextBytes))return unavailable;
  if(subject!==undefined&&(typeof subject!=='string'||subject.length>limits.maxSubjectLength||/[\u0000-\u001f\u007f]/.test(subject)))return unavailable;
  return Object.freeze({status:'available',text,...(subject?.trim()?{subject:subject.trim()}:{})});
 }catch{return unavailable;}
}

/** Parses only after mailbox authorization. Never authenticates the sender,
 * renders HTML, expands attached messages or returns attachment/header objects.
 */
export class InboundMailTextPreview extends BoundedBinaryAdapterBase {
 constructor(maximumBytes,{parse=(bytes,options)=>PostalMime.parse(bytes,options)}={}) {
  super(Math.min(maximumBytes,limits.maxRawBytes));
  if(!Number.isSafeInteger(maximumBytes)||maximumBytes<1||typeof parse!=='function')throw Error('Configured mail preview adapters required');
  this.parse=parse;
  this.htmlText=new HtmlMailTextExtractor(this.maxBytes,this.maxBytes);
 }
 async project(rawBase64) {
  try {
   // Bound the encoded input before atob allocates anything, then require a
   // canonical encoding. Raw stored mail remains private and untouched.
   if(typeof rawBase64!=='string'||!rawBase64.length||rawBase64.length>4*Math.ceil(this.maxBytes/3)||rawBase64.length%4!==0)return unavailable;
   const binary=atob(rawBase64);
   if(binary.length>this.maxBytes||btoa(binary)!==rawBase64)return unavailable;
   const bytes=Uint8Array.from(binary,char=>char.charCodeAt(0));this.validateBytes(bytes);
   const parsed=await this.parse(bytes,{maxNestingDepth:limits.maxNestingDepth,maxHeadersSize:limits.maxHeadersSize,maxPartCount:limits.maxPartCount,rfc822Attachments:true,maxRfc822NestingDepth:0,maxForwardedAddresses:0});
   const {text,html,subject}=parsed??{};
   // A present but invalid plain-text body must not bypass validation via HTML.
   const body=text===undefined?this.htmlText.extract(html):text;
   if(typeof body!=='string')return unavailable;
   return boundedMailPreview({status:'available',text:body.replace(/\r\n?/g,'\n'),...(subject!==undefined?{subject}:{})},this.maxBytes);
  }catch{return unavailable;} // No parser, provider or partial-content details.
 }
}
