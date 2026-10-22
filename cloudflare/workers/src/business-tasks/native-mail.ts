import type {NativeEmailBinding} from '../email';
import type {BusinessMailTransport} from './mail.ts';

/** Native EMAIL binding adapter for the inherited mail service. Never retries sends. */
export class NativeBusinessMailTransport implements BusinessMailTransport {
 readonly binding:NativeEmailBinding;
 readonly sender:string;
 readonly maxBytes:number;
 constructor(binding:NativeEmailBinding,sender:string,maxBytes:number){
  if(typeof binding?.send!=='function'||!NativeBusinessMailTransport.address(sender)||!Number.isSafeInteger(maxBytes)||maxBytes<1)throw Error('Native business mail configuration required');
  this.binding=binding;this.sender=sender;this.maxBytes=maxBytes;
 }
 private static address(value:unknown):value is string{
  return typeof value==='string'&&value.length<=254&&value.trim()===value&&!/[\u0000-\u0020\u007f<>]/.test(value)&&/^[^@]+@[^@]+\.[^@]+$/.test(value);
 }
 async send(message:Parameters<BusinessMailTransport['send']>[0]):Promise<{messageId:string}>{
  try{
   if(!message||message.from!==this.sender||!NativeBusinessMailTransport.address(message.to)||typeof message.subject!=='string'||!message.subject.trim()||message.subject.length>200||/[\u0000-\u001f\u007f]/.test(message.subject)||typeof message.text!=='string'||typeof message.html!=='string')throw Error('Invalid mail');
   const bytes=new TextEncoder().encode(message.text).length+new TextEncoder().encode(message.html).length;
   if(bytes>this.maxBytes)throw Error('Mail limit');
   // Snapshot before crossing the provider boundary; never forward extra fields.
   const result=await this.binding.send({from:this.sender,to:message.to,subject:message.subject,text:message.text,html:message.html});
   const id=result?.messageId;
   if(typeof id!=='string'||!id||id.length>500||id.trim()!==id||/[\u0000-\u001f\u007f]/.test(id))throw Error('Invalid receipt');
   return {messageId:id};
  }catch{throw Error('Email delivery unavailable');}
 }
}
