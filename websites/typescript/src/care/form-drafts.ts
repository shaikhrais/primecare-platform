export type DraftValue=string|string[];
export type FormDrafts=Map<string,Record<string,DraftValue>>;

/** Preserve input state across redraws without inventing options removed by the API. */
export function captureDrafts(root:HTMLElement):FormDrafts{
 return new Map([...root.querySelectorAll<HTMLFormElement>('form[data-cy]')].map(form=>{
  const values:Record<string,DraftValue>={};
  for(const [name,value] of new FormData(form))if(typeof value==='string')values[name]=value;
  for(const select of form.querySelectorAll<HTMLSelectElement>('select[multiple][name]'))values[select.name]=[...select.selectedOptions].map(option=>option.value);
  for(const checkbox of form.querySelectorAll<HTMLInputElement>('input[type=checkbox][name]'))values[checkbox.name]=checkbox.checked?'true':'false';
  return [form.dataset.cy!,values];
 }));
}
export function restoreDrafts(root:HTMLElement,drafts:FormDrafts){
 for(const form of root.querySelectorAll<HTMLFormElement>('form[data-cy]')){
  const values=drafts.get(form.dataset.cy!);if(!values)continue;
  for(const [name,value] of Object.entries(values)){
   const field=form.elements.namedItem(name) as HTMLInputElement|HTMLSelectElement|null;if(!field||!('tagName' in field))continue;
   if(field.tagName==='SELECT'){
    const select=field as HTMLSelectElement;
    if(select.multiple){const selected=new Set(Array.isArray(value)?value:[value]);for(const option of select.options)option.selected=selected.has(option.value);}
    else if(typeof value==='string'&&[...select.options].some(option=>option.value===value))select.value=value;
   }else if(typeof value==='string'){if(field.type==='checkbox')(field as HTMLInputElement).checked=value==='true';else field.value=value;}
  }
 }
}
