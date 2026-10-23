import PostalMime from 'postal-mime';
import {BoundedBinaryAdapterBase} from './adapter-base.mjs';
import registeredLimits from './registered-mail-preview-limits.json' with {type:'json'};
const limits=Object.freeze({...registeredLimits});

const unavailable=Object.freeze({status:'unavailable'});
const encoder=new TextEncoder();
const controls=/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/;

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
   const {text,subject}=parsed??{};
   if(typeof text!=='string')return unavailable;
   return boundedMailPreview({status:'available',text:text.replace(/\r\n?/g,'\n'),...(subject!==undefined?{subject}:{})},this.maxBytes);
  }catch{return unavailable;} // No parser, provider or partial-content details.
 }
}
