export type RecordPageProjection={kind:'activity'|'search';dataset:'live'|'demo';synthetic:boolean;sourceApiId:number;bounded:true;status:'ready'|'empty'|'denied';rows:{type:string;title:string;detail:string}[]};
export function projectRecordPage(kind:string,raw:unknown,scope:{dataset:string;userId:string;tenantId:string;role:string},query?:string):RecordPageProjection;
