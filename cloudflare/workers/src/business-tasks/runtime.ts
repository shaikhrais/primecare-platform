import {validateRegisteredCommunicationSchema} from './schema-validator.ts';
import type {AccessPolicy} from './store.ts';
import {PostgresAtomicStore} from './store.ts';
import {CommunicationService,type PictureRepository,type CommunicationLimits} from './communication.ts';
import {BusinessMailService,type MailboxPolicy} from './mail.ts';
import {CommunicationCore} from './channels.ts';
import {CommunicationHttpWorker} from './http.ts';
import {PostgresCommunicationSession} from './session.ts';
import {PostgresCommunicationEndpointPolicy} from './endpoint-policy.ts';
import {NativeBusinessMailTransport} from './native-mail.ts';
import {PostgresCommunicationAccessPolicy,PostgresCommunicationMailboxPolicy} from './access-policy.ts';
import type {NativeEmailBinding} from '../email';
import {InboundEmailAdapter,type InboundEmailMessage} from '../../../../packages/shared/src/communications/inbound-email.mjs';

type NativeDatabaseClient={query(sql:string,values?:string[]):Promise<{rows:Record<string,unknown>[]}>;release():void};
export type NativeDatabasePool={query:NativeDatabaseClient['query'];connect():Promise<NativeDatabaseClient>};
export type CommunicationRuntimeDependencies={
 businessPool:NativeDatabasePool;
 governancePool:NativeDatabasePool;
 /** Optional trusted specialized port; defaults to registered native account/task rules. */
 casePolicy?:AccessPolicy;
 /** Optional trusted specialized port; defaults to the current native owned-mailbox directory. */
 mailboxes?:MailboxPolicy;
 pictures:PictureRepository;
 limits:CommunicationLimits;
 nativeEmail:NativeEmailBinding;
 sender:string;
 maxMailBytes:number;
 maxRenderedMailBytes:number;
 maxRequestBytes:number;
 /** Optional additional restriction; cannot bypass the registered validator. */
 validate?:(schema:unknown,value:unknown)=>boolean;
};
/** One inherited composition for registered HTTP channels and trusted email events.
 * Deliberately unmounted until explicit endpoint grants and live provider/mailbox
 * configuration and deployed acceptance exist. Default native policies fail closed.
 */
export class PostgresCommunicationWorker<E> extends CommunicationHttpWorker<E> {
 readonly inbound:InboundEmailAdapter;
 constructor(dependencies:CommunicationRuntimeDependencies){
  if(typeof dependencies?.businessPool?.query!=='function'||typeof dependencies.businessPool.connect!=='function'||typeof dependencies.governancePool?.connect!=='function'||typeof dependencies.pictures?.prepare!=='function'||typeof dependencies.pictures.get!=='function'||typeof dependencies.pictures.open!=='function')throw Error('Native communication runtime adapters required');
  if(dependencies.validate!==undefined&&typeof dependencies.validate!=='function')throw Error('Invalid additional communication validator');
  const store=new PostgresAtomicStore(dependencies.businessPool);
  const policy=dependencies.casePolicy===undefined?new PostgresCommunicationAccessPolicy(dependencies.businessPool):dependencies.casePolicy;
  const mailboxes=dependencies.mailboxes===undefined?new PostgresCommunicationMailboxPolicy(dependencies.businessPool):dependencies.mailboxes;
  const service=new CommunicationService(store,policy,dependencies.pictures,dependencies.limits);
  const transport=new NativeBusinessMailTransport(dependencies.nativeEmail,dependencies.sender,dependencies.maxRenderedMailBytes);
  const mail=new BusinessMailService(store,policy,mailboxes,transport,dependencies.sender,dependencies.maxMailBytes);
  const sessions=new PostgresCommunicationSession(dependencies.businessPool);
  const permissions=new PostgresCommunicationEndpointPolicy(dependencies.governancePool);
  super({core:new CommunicationCore(service,mail),authenticate:request=>sessions.authenticate(request),
   authorizeEndpoint:(actor,id,request)=>permissions.authorize(actor,id,request),
   validate:(schema,value)=>validateRegisteredCommunicationSchema(schema,value)&&(dependencies.validate===undefined||dependencies.validate(schema,value)===true&&validateRegisteredCommunicationSchema(schema,value)),maxRequestBytes:dependencies.maxRequestBytes});
  this.inbound=new InboundEmailAdapter(mail,dependencies.maxMailBytes);
 }
 /** Email Routing event only; deliberately absent from ordinary user HTTP dispatch. */
 async email(message:InboundEmailMessage,_env:E):Promise<void>{await this.inbound.receive(message);}
}
