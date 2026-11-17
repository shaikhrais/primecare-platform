// Pure markup for a host-owned pair of paging controls.
// Use only the authorized state already returned to the active host.
const escapeText=(value:string)=>value.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
type PageControl=Readonly<{testId:string;label:string;disabled:boolean}>;
export function pairedPaginationMarkup(previous:PageControl,next:PageControl):string {
 const button=(control:PageControl)=>`<button data-cy="${escapeText(control.testId)}" ${control.disabled?'disabled':''}>${escapeText(control.label)}</button>`;
 return `<div class="pagination">${button(previous)}${button(next)}</div>`;
}
