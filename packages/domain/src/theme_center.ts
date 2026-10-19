import catalog from '../../../scripts/fuse_presets.json';
export const themePresets=catalog;
export const themeColorKeys=['primary','primaryContainer','secondary','background','surface','text','muted','border','sidebar','topbar'] as const;
export type ThemeColorKey=typeof themeColorKeys[number];
export type PersonalTheme={version:1;name:string;preset:string;fontFamily:'system'|'serif'|'monospace';fontScale:number;radius:number;colors:Partial<Record<ThemeColorKey,string>>};
export const defaultPersonalTheme:PersonalTheme={version:1,name:'My theme',preset:'default',fontFamily:'system',fontScale:1,radius:12,colors:{}};
export function validatePersonalTheme(value:unknown):PersonalTheme {
 if(!value||typeof value!=='object'||Array.isArray(value))throw Error('Invalid theme');const v=value as Record<string,unknown>;const fields=Object.keys(defaultPersonalTheme);
 if(Object.keys(v).length!==fields.length||fields.some(k=>!Object.hasOwn(v,k))||Object.keys(v).some(k=>!fields.includes(k)))throw Error('Unknown theme field');
 if(v.version!==1||typeof v.name!=='string'||!v.name.trim()||v.name.trim().length>60||/[\x00-\x1f\x7f]/.test(v.name)||typeof v.preset!=='string'||!Object.hasOwn(themePresets,v.preset)||typeof v.fontFamily!=='string'||!['system','serif','monospace'].includes(v.fontFamily)||typeof v.fontScale!=='number'||!Number.isFinite(v.fontScale)||v.fontScale<.875||v.fontScale>1.5||typeof v.radius!=='number'||!Number.isInteger(v.radius)||v.radius<0||v.radius>24||!v.colors||typeof v.colors!=='object'||Array.isArray(v.colors))throw Error('Invalid theme setting');
 const colors:Partial<Record<ThemeColorKey,string>>={};for(const [key,color] of Object.entries(v.colors)){if(!themeColorKeys.includes(key as ThemeColorKey)||typeof color!=='string'||!/^#[0-9a-f]{6}$/i.test(color))throw Error('Invalid color');colors[key as ThemeColorKey]=color.toLowerCase();}
 const palette=themePresets[v.preset as keyof typeof themePresets];const backgrounds=[colors.background??palette.background.default,colors.surface??palette.background.paper];
 if(![colors.text,'#000000','#ffffff'].some(color=>color&&backgrounds.every(bg=>themeContrast(color,bg)>=4.5)))throw Error('Choose compatible backgrounds and readable text');
 return {version:1,name:v.name.trim(),preset:v.preset,fontFamily:v.fontFamily as PersonalTheme['fontFamily'],fontScale:v.fontScale,radius:v.radius,colors};
}
export type SavedTheme={id:string;theme:PersonalTheme};
export type ThemeLibrary={version:1;active:PersonalTheme|null;items:SavedTheme[]};
export function validateThemeLibrary(value:unknown):ThemeLibrary {
 if(!value||typeof value!=='object'||Array.isArray(value))throw Error('Invalid theme library');const v=value as Record<string,unknown>;
 if(Object.keys(v).sort().join(',')!=='active,items,version'||v.version!==1||!Array.isArray(v.items)||v.items.length>20)throw Error('Invalid theme library');const ids=new Set<string>(),names=new Set<string>();
 const items=v.items.map(item=>{if(!item||typeof item!=='object'||Object.keys(item).sort().join(',')!=='id,theme'||typeof item.id!=='string'||! /^[0-9a-f-]{36}$/i.test(item.id)||ids.has(item.id))throw Error('Invalid saved theme');const theme=validatePersonalTheme(item.theme);if(names.has(theme.name.toLowerCase()))throw Error('Duplicate theme name');ids.add(item.id);names.add(theme.name.toLowerCase());return {id:item.id,theme};});
 return {version:1,active:v.active===null?null:validatePersonalTheme(v.active),items};
}

export function themeContrast(a:string,b:string):number {const luminance=(color:string)=>{let values:number[];if(color.startsWith('#')){let hex=color.slice(1);if(hex.length===3)hex=hex.split('').map(x=>x+x).join('');values=[0,2,4].map(i=>parseInt(hex.slice(i,i+2),16)/255);}else{const m=/^rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)/.exec(color);if(!m)return NaN;values=[1,2,3].map(i=>Number(m[i])/255);}values=values.map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4);return .2126*values[0]+.7152*values[1]+.0722*values[2];};const x=luminance(a),y=luminance(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05);}
