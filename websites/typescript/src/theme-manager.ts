import type {LayoutProfile} from '../../../packages/domain/src/layout_profile';
const tokens=['--color-primary','--color-primary-hover','--color-secondary','--color-background','--color-surface','--color-surface-soft','--color-text','--color-text-muted','--color-border','--color-info','--color-on-primary'];
const bases=new WeakMap<HTMLElement,Map<string,string>>();
export function onAccent(color:string):string {
 const rgb=[1,3,5].map(i=>parseInt(color.slice(i,i+2),16)/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4);const l=.2126*rgb[0]+.7152*rgb[1]+.0722*rgb[2];return (l+.05)/.05>=1.05/(l+.05)?'#000000':'#ffffff';
}
/** Own only presentation tokens, retaining the portal's governed default theme. */
export class BaseThemeManager {
 private readonly base:Map<string,string>;
 constructor(private readonly host:HTMLElement=document.documentElement){let base=bases.get(host);if(!base){base=new Map(tokens.map(k=>[k,host.style.getPropertyValue(k)]));bases.set(host,base);}this.base=base;}
 apply(profile:LayoutProfile):void {
  for(const [key,value] of this.base){if(value)this.host.style.setProperty(key,value);else this.host.style.removeProperty(key);}
  const palettes={light:['#ffffff','#f8fafc','#eef2f6','#172033','#526078','#cbd5e1','#0f172a','#1e293b','#0369a1'],dark:['#172033','#0b1220','#243149','#f1f5f9','#b6c4d9','#475569','#5eead4','#99f6e4','#7dd3fc']};
  if(profile.theme!=='default'){const colors=palettes[profile.theme];['--color-surface','--color-background','--color-surface-soft','--color-text','--color-text-muted','--color-border','--color-primary','--color-primary-hover','--color-info'].forEach((k,i)=>this.host.style.setProperty(k,colors[i]));this.host.style.setProperty('--color-secondary',colors[3]);}
  if(profile.accent){this.host.style.setProperty('--color-primary',profile.accent);this.host.style.setProperty('--color-primary-hover',profile.accent);}
  const primary=this.host.style.getPropertyValue('--color-primary').trim();if(/^#[0-9a-f]{6}$/i.test(primary))this.host.style.setProperty('--color-on-primary',onAccent(primary));
  this.host.style.colorScheme=profile.theme==='dark'?'dark':'light';
 }
}
