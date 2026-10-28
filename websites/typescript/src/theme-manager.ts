import solidTheme from '../../../packages/shared/src/solid-theme.json';
import {validatePersonalTheme,themePresets,type PersonalTheme} from '../../../packages/domain/src/theme_center';
import type {LayoutProfile} from '../../../packages/domain/src/layout_profile';
const tokens=['--color-primary','--color-primary-hover','--color-secondary','--color-background','--color-surface','--color-surface-soft','--color-text','--color-text-muted','--color-border','--color-info','--color-on-primary','--color-sidebar','--color-sidebar-text','--color-topbar','--color-topbar-text','--color-surface-text','--color-surface-muted','--font-family','--font-size-body','--font-size-heading','--font-size-caption','--radius-md','--radius-lg'];
const bases=new WeakMap<HTMLElement,Map<string,string>>();
export function onAccent(color:string):string {
 const rgb=[1,3,5].map(i=>parseInt(color.slice(i,i+2),16)/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4);const l=.2126*rgb[0]+.7152*rgb[1]+.0722*rgb[2];return (l+.05)/.05>=1.05/(l+.05)?'#000000':'#ffffff';
}
/** Own only presentation tokens, retaining the portal's governed default theme. */
export class BaseThemeManager {
 private readonly base:Map<string,string>;private readonly portal:Map<string,string>;
 constructor(private readonly host:HTMLElement=document.documentElement){let base=bases.get(host);if(!base){base=new Map(tokens.map(k=>[k,host.style.getPropertyValue(k)]));bases.set(host,base);}this.portal=new Map(base);this.base=new Map(base);}
 setDefaults(values:Record<string,string>):void {this.base.clear();for(const [key,value] of this.portal)this.base.set(key,value);for(const [key,value] of Object.entries(this.host.dataset.surfaceStyle==='solid'?{...values,...solidTheme}:values))if(tokens.includes(key))this.base.set(key,value);}
 apply(profile:LayoutProfile,personal?:PersonalTheme|null):void {
  for(const [key,value] of this.base){if(value)this.host.style.setProperty(key,value);else this.host.style.removeProperty(key);}
  const palettes={light:['#ffffff','#f8fafc','#eef2f6','#172033','#526078','#cbd5e1','#0f172a','#1e293b','#0369a1'],dark:['#172033','#0b1220','#243149','#f1f5f9','#b6c4d9','#475569','#5eead4','#99f6e4','#7dd3fc']};
  if(profile.theme!=='default'){const colors=palettes[profile.theme];['--color-surface','--color-background','--color-surface-soft','--color-text','--color-text-muted','--color-border','--color-primary','--color-primary-hover','--color-info'].forEach((k,i)=>this.host.style.setProperty(k,colors[i]));this.host.style.setProperty('--color-secondary',colors[3]);this.host.style.setProperty('--color-sidebar',colors[0]);this.host.style.setProperty('--color-sidebar-text',colors[3]);}
  if(profile.accent){this.host.style.setProperty('--color-primary',profile.accent);this.host.style.setProperty('--color-primary-hover',profile.accent);}
  const primary=this.host.style.getPropertyValue('--color-primary').trim();if(/^#[0-9a-f]{6}$/i.test(primary))this.host.style.setProperty('--color-on-primary',onAccent(primary));
  this.host.style.setProperty('--theme-font-scale','1');
  this.host.style.colorScheme=profile.theme==='dark'?'dark':'light';
  if(profile.theme!=='default'){this.host.style.setProperty('--color-topbar',palettes[profile.theme][0]);this.host.style.setProperty('--color-topbar-text',palettes[profile.theme][3]);this.host.style.setProperty('--color-surface-text',palettes[profile.theme][3]);this.host.style.setProperty('--color-surface-muted',palettes[profile.theme][4]);}
  if(personal)this.applyPersonal(validatePersonalTheme(personal));
 }
 private applyPersonal(personal:PersonalTheme):void {
  const palette=themePresets[personal.preset as keyof typeof themePresets];const colors=personal.colors;
  const resolve=(value:string,background='#ffffff'):string=>{if(/^#[0-9a-f]{6}$/i.test(value))return value;if(/^#[0-9a-f]{3}$/i.test(value))return '#'+value.slice(1).split('').map(x=>x+x).join('');const m=/^rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)(?:\s*,\s*([\d.]+))?\s*\)$/.exec(value);if(!m)throw Error('Unsupported catalog color');const a=m[4]===undefined?1:Number(m[4]);return '#'+[1,2,3].map(i=>Math.round(Number(m[i])*a+parseInt(background.slice(1+(i-1)*2,3+(i-1)*2),16)*(1-a)).toString(16).padStart(2,'0')).join('');};
  const background=colors.background??resolve(palette.background.default),surface=colors.surface??resolve(palette.background.paper),primary=colors.primary??resolve(palette.primary.main),sidebar=colors.sidebar??resolve(palette.sidebarBackground??palette.primary.main),topbar=colors.topbar??resolve(palette.topbarBackground??palette.background.paper);
  const text=colors.text??resolve(palette.text.primary,surface),muted=colors.muted??resolve(palette.text.secondary,surface);
  const safe=(color:string,bg:string)=>contrastRatio(color,bg)>=4.5?color:onAccent(bg);
  const assignments={'--color-background':background,'--color-surface':surface,'--color-surface-soft':surface,'--color-primary':primary,'--color-primary-hover':primary,'--color-on-primary':onAccent(primary),'--color-secondary':colors.secondary??resolve(palette.secondary.main),'--color-sidebar':sidebar,'--color-sidebar-text':onAccent(sidebar),'--color-topbar':topbar,'--color-topbar-text':onAccent(topbar),'--color-text':safe(text,background),'--color-text-muted':safe(muted,background),'--color-surface-text':safe(text,surface),'--color-surface-muted':safe(muted,surface),'--color-border':colors.border??resolve(palette.divider,surface)};
  for(const [key,value] of Object.entries(assignments))this.host.style.setProperty(key,value);
  this.host.style.setProperty('--theme-font-scale',String(personal.fontScale));
  if(personal.fontFamily!=='system')this.host.style.setProperty('--font-family',personal.fontFamily==='serif'?'Georgia, serif':'ui-monospace, monospace');
  for(const [key,fallback] of [['--font-size-body','1rem'],['--font-size-heading','1.5rem'],['--font-size-caption','.875rem']])this.host.style.setProperty(key,`calc(${this.base.get(key)||fallback} * ${personal.fontScale})`);
  this.host.style.setProperty('--radius-md',personal.radius+'px');this.host.style.setProperty('--radius-lg',personal.radius+'px');this.host.style.colorScheme=palette.mode==='dark'?'dark':'light';
 }

}
export function contrastRatio(a:string,b:string):number {const luminance=(hex:string)=>{const values=[1,3,5].map(i=>parseInt(hex.slice(i,i+2),16)/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4);return .2126*values[0]+.7152*values[1]+.0722*values[2];};const x=luminance(a),y=luminance(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05);}
