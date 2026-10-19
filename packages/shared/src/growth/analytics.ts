import {registry,stages,type Pipeline} from './contract';
export type Plan={start:string;end:string;targets:Record<Pipeline,number[]>;version:number};
export class GrowthAnalytics {
 static funnel(pipeline:Pipeline,counts:Record<string,number>,plan:Plan,now=new Date()) {
  const start=Date.parse(plan.start+'T00:00:00Z'),finish=Date.parse(plan.end+'T00:00:00Z')+86400000;
  const elapsed=Math.max(0,Math.min(1,(now.getTime()-start)/(finish-start)));
  return stages(pipeline).map((stage,i)=>{
   const actual=counts[stage]??0,target=plan.targets[pipeline][i],expected=Math.ceil(target*elapsed);
   const previous=i===0?null:counts[stages(pipeline)[i-1]]??0;
   return {stage,actual,target,expected,gap:Math.max(0,expected-actual),rate:previous?actual/previous:null,status:elapsed===0?'not_started':actual<expected?'behind':'on_track',fix:'fix_'+stage};
  });
 }
 static campaign(budget:number,spend:number,leads:number){return {cplCents:leads>0?spend/leads:null,budgetGapCents:Math.max(0,spend-budget)};}
 static priorities(funnels:Record<Pipeline,ReturnType<typeof GrowthAnalytics.funnel>>){return (['tenant','client'] as Pipeline[]).flatMap(p=>funnels[p].filter(f=>f.status==='behind').slice(0,1).map(f=>({...f,pipeline:p})));}
 static defaultPlan(now=new Date()):Plan {const start=new Date(now);start.setUTCHours(0,0,0,0);start.setUTCDate(1);const end=new Date(start);end.setUTCMonth(end.getUTCMonth()+1);end.setUTCDate(0);return {start:start.toISOString().slice(0,10),end:end.toISOString().slice(0,10),targets:registry.targets,version:0};}
}
