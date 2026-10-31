import {validatePersonalTheme,themePresets,themeContrast,defaultPersonalTheme,type PersonalTheme} from './theme_center';
/** PrimeCare-owned adapter. Contains no vendor components, credentials or access rules.
 * The same validated JSON is already accepted by Flutter PersonalTheme.fromJson.
 */
export type FusePaletteOptions={palette:{mode:'light'|'dark';primary:{main:string;contrastText:string};secondary:{main:string;contrastText:string};background:{default:string;paper:string};text:{primary:string;secondary:string};divider:string};typography:{fontFamily:string;fontSize:number};shape:{borderRadius:number}};
export type PrimeCareFuseAppearance={profile:PersonalTheme;theme:{main:FusePaletteOptions;navbar:FusePaletteOptions;toolbar:FusePaletteOptions;footer:FusePaletteOptions}};
const foreground=(background:string,preferred?:string)=>preferred&&themeContrast(preferred,background)>=4.5?preferred:themeContrast('#000000',background)>=themeContrast('#ffffff',background)?'#000000':'#ffffff';
export function toFuseAppearance(value:unknown):PrimeCareFuseAppearance {
 const profile=validatePersonalTheme(value),base=themePresets[profile.preset as keyof typeof themePresets],c=profile.colors;
 const background=c.background??base.background.default,surface=c.surface??base.background.paper,primary=c.primary??base.primary.main,secondary=c.secondary??base.secondary.main,border=c.border??base.divider;
 const textCandidate=c.text??base.text.primary;
 const text=[textCandidate,'#000000','#ffffff'].find(color=>[background,surface].every(bg=>themeContrast(color,bg)>=4.5));
 if(!text)throw Error('Theme requires readable text on background and surface');
 const mutedCandidate=c.muted??base.text.secondary;
 const muted=[mutedCandidate,text].find(color=>[background,surface].every(bg=>themeContrast(color,bg)>=4.5))!;
 const typography={fontFamily:profile.fontFamily==='system'?'Inter, system-ui, sans-serif':profile.fontFamily==='serif'?'serif':'monospace',fontSize:14*profile.fontScale};
 const shape={borderRadius:profile.radius};
 const palette={mode:base.mode as 'light'|'dark',primary:{main:primary,contrastText:foreground(primary)},secondary:{main:secondary,contrastText:foreground(secondary)},background:{default:background,paper:surface},text:{primary:text,secondary:muted},divider:border};
 const main={palette,typography,shape};
 const chrome=(background:string):FusePaletteOptions=>({palette:{...palette,mode:foreground(background)==='#ffffff'?'dark':'light',background:{default:background,paper:background},text:{primary:foreground(background,text),secondary:foreground(background,muted)}},typography:{...typography},shape:{...shape}});
 const sidebar=c.sidebar??base.sidebarBackground,topbar=c.topbar??base.topbarBackground;
 return {profile,theme:{main,navbar:chrome(sidebar),toolbar:chrome(topbar),footer:chrome(topbar)}};
}

/** Approved skeleton chrome differs from the legacy preset's sidebar aliases. */
export function approvedFuseProfile():PersonalTheme {
 return validatePersonalTheme({...defaultPersonalTheme,name:'PrimeCare shared appearance',colors:{sidebar:themePresets.defaultNavbar.background.default,topbar:themePresets.default.background.default}});
}
