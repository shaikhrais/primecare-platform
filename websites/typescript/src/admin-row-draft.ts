import policy from '../../../packages/shared/src/admin-form-draft.json';

type Snapshot={id:string;baseline:string;values:Record<string,string>};
/** Unsaved presentation values, scoped by the caller and never written to storage. */
export class AdminRowDraft {
 private rows:Snapshot[]=[];
 capture(root:HTMLElement,excluded:ReadonlySet<string>):void {
  this.rows=[];
  for(const table of policy.rowTables)for(const row of root.querySelectorAll<HTMLElement>(`[data-cy="${table}"] [data-row-draft]`)){
   const id=row.dataset.rowDraft!;if(excluded.has(id))continue;
   const values:Record<string,string>={};
   for(const attr of policy.rowFields){const field=row.querySelector<HTMLInputElement|HTMLSelectElement>(`[${attr}]`);if(field&&!field.hasAttribute('data-protected'))values[attr]=field.value;}
   this.rows.push({id,baseline:row.dataset.draftBaseline!,values});
  }
 }
 restore(root:HTMLElement):void {
  for(const row of root.querySelectorAll<HTMLElement>('[data-row-draft]')){
   const snapshot=this.rows.find(s=>s.id===row.dataset.rowDraft&&s.baseline===row.dataset.draftBaseline);if(!snapshot)continue;
   for(const [attr,value] of Object.entries(snapshot.values)){
    const field=row.querySelector<HTMLInputElement|HTMLSelectElement>(`[${attr}]`);if(!field||field.hasAttribute('data-protected'))continue;
    if(field instanceof HTMLSelectElement&&!Array.from(field.options).some(o=>o.value===value))continue;
    field.value=value;
   }
  }
 }
}
