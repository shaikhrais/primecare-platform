import {CommunicationResourceBase} from './adapter-base.mjs';
export type VoiceTaskApprovalState='idle'|'loading'|'ready'|'approving'|'approved'|'unavailable'|'expired'|'closed';
export type VoiceTaskApprovalProposal=Readonly<{intentId:string;summary:string;digest:string;expiresAt:number}>;
export type VoiceTaskApprovalOptions={currentScope:()=>string|null;transport:{preview(intentId:string):Promise<VoiceTaskApprovalProposal>;approve(intentId:string,digest:string):Promise<{approved:true;expiresAt:number}>};onChange?:(value:{state:VoiceTaskApprovalState;proposal:VoiceTaskApprovalProposal|null})=>void};
export class VoiceTaskApprovalSession extends CommunicationResourceBase {constructor(options:VoiceTaskApprovalOptions);readonly state:VoiceTaskApprovalState;readonly proposal:VoiceTaskApprovalProposal|null;preview(intentId:string):Promise<VoiceTaskApprovalProposal|null>;approve():Promise<Readonly<{approved:true;expiresAt:number}>>}
export type VoiceTaskApprovalCopy=Record<VoiceTaskApprovalState|'approve'|'cancel',string>;
export function mountVoiceTaskApprovalPanel(options:Omit<VoiceTaskApprovalOptions,'onChange'>&{element:HTMLElement;intentId:string;copy:VoiceTaskApprovalCopy}):VoiceTaskApprovalSession;
