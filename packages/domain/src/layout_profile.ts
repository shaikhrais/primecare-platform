/** Renderer-independent presentation contract. It never grants routes or permissions. */
export type LayoutProfile={version:1;theme:'default'|'light'|'dark';accent:string;sidebar:'left'|'right';navigation:'expanded'|'compact';density:'comfortable'|'compact';contentWidth:number};
export const defaultLayoutProfile:LayoutProfile={version:1,theme:'default',accent:'',sidebar:'left',navigation:'expanded',density:'comfortable',contentWidth:100};
export function validateLayoutProfile(value:unknown):LayoutProfile {
 if(!value||typeof value!=='object'||Array.isArray(value))throw Error('Invalid layout profile');
 const v=value as Record<string,unknown>;const keys=Object.keys(defaultLayoutProfile);
 if(Object.keys(v).length!==keys.length||keys.some(k=>!Object.hasOwn(v,k))||Object.keys(v).some(k=>!keys.includes(k)))throw Error('Unknown or missing layout setting');
 if(v.version!==1||typeof v.theme!=='string'||!['default','light','dark'].includes(v.theme)||typeof v.accent!=='string'||v.accent!==''&&!/^#[0-9a-fA-F]{6}$/.test(v.accent)||typeof v.sidebar!=='string'||!['left','right'].includes(v.sidebar)||typeof v.navigation!=='string'||!['expanded','compact'].includes(v.navigation)||typeof v.density!=='string'||!['comfortable','compact'].includes(v.density)||typeof v.contentWidth!=='number'||!Number.isInteger(v.contentWidth)||v.contentWidth<75||v.contentWidth>100)throw Error('Invalid layout setting');
 return {...v,accent:v.accent.toLowerCase()} as LayoutProfile;
}
