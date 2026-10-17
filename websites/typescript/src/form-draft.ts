/** Ephemeral presentation state. Never persists files, credentials or decisions to storage. */
export class FormDraft {
 private values=new Map<string,{value:string;checked?:boolean;file?:HTMLInputElement}>();
 capture(form:HTMLFormElement,excludeInputTypes:readonly string[]=[]):void {
  this.values.clear();
  for(const field of Array.from(form.elements)) {
   if(!(field instanceof HTMLInputElement||field instanceof HTMLSelectElement||field instanceof HTMLTextAreaElement)||!field.name)continue;
   if(field instanceof HTMLInputElement&&excludeInputTypes.includes(field.type))continue;
   this.values.set(field.name,{value:field.value,...(field instanceof HTMLInputElement?{checked:field.checked,...(field.type==='file'?{file:field}: {})}: {})});
  }
 }
 restore(form:HTMLFormElement):void {
  for(const [name,snapshot] of this.values) {
   const field=form.elements.namedItem(name);
   if(!(field instanceof HTMLInputElement||field instanceof HTMLSelectElement||field instanceof HTMLTextAreaElement))continue;
   // Moving the existing input keeps the browser-owned FileList intact.
   if(snapshot.file){field.replaceWith(snapshot.file);continue;}
   if(field instanceof HTMLSelectElement&&!Array.from(field.options).some(o=>o.value===snapshot.value))continue;
   field.value=snapshot.value;
   if(field instanceof HTMLInputElement&&snapshot.checked!==undefined)field.checked=snapshot.checked;
  }
 }
 clear():void {this.values.clear();}
}
