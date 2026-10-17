import registry from './registry.json';
export {registry};
export type BundleLocale='en'|'fr'|'es';
export type BundleActor={id:string;roles:string;tenant_id:string};
export const bundleAccess=(role:string):string|undefined=>Object.hasOwn(registry.roles,role)?(registry.roles as Record<string,string>)[role]:undefined;
export type LaunchCheck={key:string;present:boolean};
export type Launch={state:string;version:number;trainingEvidence:string;checks:LaunchCheck[];ready:boolean;canApprove:boolean;canSubmit:boolean;canRequestChanges:boolean;feedback:{evidence:string;createdAt:string}|null};
export type DocumentRow={id:string;kind:string;revision:number;filename:string;media_type:string;expires_on:string;status:string;version:number;renewal:string;review_evidence:string;canReview:boolean};
export type Ticket={id:string;tenant_id:string;subject:string;priority:string;status:string;owner_id:string|null;version:number;response_due:string;resolution_due:string;first_response_at:string|null;resolved_at:string|null;overdue:boolean;responseLate:boolean;resolutionLate:boolean;messages:{id:string;message:string;created_at:string;author:string}[];timeline:{id:string;action:string;createdAt:string;status:string;priority:string;responseDue:string|null;resolutionDue:string|null;firstResponseAt:string|null;resolvedAt:string|null}[];canTriage:boolean;canReopen:boolean};
export type Enquiry={id:string;fsa:string;service:string;status:string;reason:string;version:number;offer_due:string|null;tenant_name:string|null;lead_id:string|null;contact:{name:string;email:string;phone:string}|null;actions:string[]};
export type BundleData={global:boolean;tenantId:string|null;checkedAt:string;launch:Launch|null;documents:DocumentRow[];tickets:Ticket[];routes:Enquiry[];owners:{id:string;label:string}[];audit:{id:string;action:string;evidence:string;created_at:string}[];summary:{tickets:number;routes:number;overdue:number;unmatched:number;renewals:number};pagination:{list:string;offset:number;limit:number;total:number;hasMore:boolean}};

export type AttentionItem={key:string;kind:string;id:string;reason:string;dueAt:string|null;overdue:boolean;assigned:boolean;tenant:{id:string;name:string;slug:string}|null;destination:string};
export type AttentionData={scope:string;items:AttentionItem[];summary:Record<string,number>;pagination:{offset:number;limit:number;total:number;hasMore:boolean}};

export type SupportMessage=Ticket['messages'][number];
export type DeadlineEvent=Ticket['timeline'][number];
export type LaunchEvent=BundleData['audit'][number];
export type HistoryTarget={tenantId:string;kind:'documents'|'messages'|'deadlines'|'launch';ticketId:string|null};
export type BundleHistory=HistoryTarget&{pagination:{offset:number;limit:number;total:number;hasMore:boolean}}&({kind:'documents';items:DocumentRow[]}|{kind:'messages';items:SupportMessage[]}|{kind:'deadlines';items:DeadlineEvent[]}|{kind:'launch';items:LaunchEvent[]});
