import {validatePersonalTheme,type PersonalTheme} from '../../domain/src/theme_center';
import {defaultLayoutProfile,validateLayoutProfile,type LayoutProfile} from '../../domain/src/layout_profile';
import {BaseThemeManager} from './theme-manager';
export {defaultLayoutProfile};export type {LayoutProfile};
const maxXml=16384;
/** Strict data-only XML; no component creation, CSS, script, endpoints or access rules. */
export class XmlLayoutManager {
 toXml(profile:LayoutProfile):string {const p=validateLayoutProfile(profile);return `<PrimeCareLayout version="1"><Theme preset="${p.theme}" accent="${p.accent}"/><Shell sidebar="${p.sidebar}" navigation="${p.navigation}" density="${p.density}" contentWidth="${p.contentWidth}"/></PrimeCareLayout>`;}
 fromXml(xml:string):LayoutProfile {
  if(typeof xml!=='string'||new TextEncoder().encode(xml).length>maxXml||/<!|<\?/.test(xml))throw Error('Unsupported XML markup');
  const doc=new DOMParser().parseFromString(xml,'application/xml');if(doc.querySelector('parsererror')||doc.childNodes.length!==1)throw Error('Invalid XML');
  const root=doc.documentElement;const attributes=(node:Element,names:string[])=>{if(node.namespaceURI||node.attributes.length!==names.length||[...node.attributes].some(a=>!names.includes(a.name)))throw Error('Unknown XML setting');};
  const children=(node:Element)=>{if([...node.childNodes].some(n=>n.nodeType!==1&&(n.nodeType!==3||n.textContent?.trim())))throw Error('Unknown XML content');return [...node.children];};
  if(root.tagName!=='PrimeCareLayout')throw Error('Invalid layout root');attributes(root,['version']);if(root.getAttribute('version')!=='1')throw Error('Unsupported layout version');
  const parts=children(root);if(parts.length!==2||parts[0].tagName!=='Theme'||parts[1].tagName!=='Shell')throw Error('Invalid layout elements');const [theme,shell]=parts;attributes(theme,['preset','accent']);attributes(shell,['sidebar','navigation','density','contentWidth']);if(children(theme).length||children(shell).length)throw Error('Nested elements are not supported');
  const width=shell.getAttribute('contentWidth')!;if(!/^\d{2,3}$/.test(width))throw Error('Invalid width');
  return validateLayoutProfile({version:1,theme:theme.getAttribute('preset'),accent:theme.getAttribute('accent'),sidebar:shell.getAttribute('sidebar'),navigation:shell.getAttribute('navigation'),density:shell.getAttribute('density'),contentWidth:Number(width)});
 }
}
export class BaseLayoutManager {
 private personal:PersonalTheme|null=null;
 readonly xml=new XmlLayoutManager();private theme=new BaseThemeManager();private profile:LayoutProfile={...defaultLayoutProfile};private undoStack:LayoutProfile[]=[];private redoStack:LayoutProfile[]=[];
 constructor(private root:HTMLElement,private readonly storageKey:string){try{const saved=localStorage.getItem(storageKey);if(saved)this.profile=this.xml.fromXml(saved);}catch{/* Fall back without applying malformed preferences. */}this.attach();}
 setDefaultTheme(values:Record<string,string>):void {this.theme.setDefaults(values);this.attach();}
 get current():LayoutProfile{return {...this.profile};}get canUndo():boolean{return this.undoStack.length>0;}get canRedo():boolean{return this.redoStack.length>0;}
 change(value:unknown):void {const next=validateLayoutProfile(value);if(JSON.stringify(next)===JSON.stringify(this.profile))return;this.undoStack.push(this.current);if(this.undoStack.length>30)this.undoStack.shift();this.redoStack=[];this.profile=next;this.attach();}
 undo():void {const previous=this.undoStack.pop();if(previous){this.redoStack.push(this.current);this.profile=previous;this.attach();}}
 redo():void {const next=this.redoStack.pop();if(next){this.undoStack.push(this.current);this.profile=next;this.attach();}}
 reset():void {this.change(defaultLayoutProfile);}
 importXml(xml:string):void {this.change(this.xml.fromXml(xml));}
 exportXml():string{return this.xml.toXml(this.profile);}
 setPersonalTheme(value:unknown|null):void {this.personal=value===null?null:validatePersonalTheme(value);this.attach();}
 get personalTheme():PersonalTheme|null{return this.personal?structuredClone(this.personal):null;}
 save():void {localStorage.setItem(this.storageKey,this.exportXml());}
 attach():void {const shell=this.root.querySelector<HTMLElement>('.app-shell');if(!shell)return;this.theme.apply(this.profile,this.personal);shell.dataset.sidebarPosition=this.profile.sidebar;shell.dataset.navigationMode=this.profile.navigation;shell.dataset.density=this.profile.density;shell.style.setProperty('--layout-content-width',this.profile.contentWidth+'%');shell.dataset.layoutVersion='1';if(this.personal||this.profile.theme!=='default'||this.profile.accent)shell.dataset.themeCenterActive='true';else delete shell.dataset.themeCenterActive;for(const dialog of this.root.querySelectorAll<HTMLElement>('.layout-customizer')){if(this.personal||this.profile.theme!=='default'||this.profile.accent)dialog.dataset.themeCenterActive='true';else delete dialog.dataset.themeCenterActive;}}
}
