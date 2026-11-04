import {validateAdvancedLibrary, type AdvancedTheme} from './advanced_theme';
import {validateThemeLibrary} from './theme_center';

/** Prepare a lossy legacy-editor preview. This never writes or applies either library. */
export function previewAdvancedLibraryInLegacyEditor(raw: unknown) {
 const source=validateAdvancedLibrary(raw);
 const project=(theme:AdvancedTheme)=>{
  const main=theme.regions.main;
  return {version:1 as const,name:theme.name,preset:'default',
   fontFamily:theme.tokens.fontFamily,fontScale:theme.tokens.fontScale,radius:theme.tokens.radius,
   colors:{primary:main.primary,secondary:main.secondary,background:main.background,
    surface:main.surface,text:main.text,border:main.border,
    sidebar:theme.regions.navigation.background,topbar:theme.regions.toolbar.background}};
 };
 const candidate=validateThemeLibrary({version:1,active:source.active&&project(source.active),
  items:source.items.map(item=>({id:item.id,theme:project(item.theme)}))});
 return {source,candidate,requiresReview:true as const,unmappedFields:[
  'layout','tokens.spacing','tokens.borderWidth','tokens.density',
  'regions.main.mode','regions.main.success','regions.main.warning','regions.main.error','regions.main.info',
  'regions.navigation except background','regions.toolbar except background','regions.footer',
 ] as const};
}
