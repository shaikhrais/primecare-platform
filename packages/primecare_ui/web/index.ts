/** PrimeCare-owned web appearance components. No vendor implementation. */
export {mountThemeCenter,organizeThemeCenter} from './theme-center';
export {installThemeCenterStyles} from './theme-center-styles';
export {BaseThemeManager,onAccent,contrastRatio} from './theme-manager';
export {BaseLayoutManager,XmlLayoutManager,defaultLayoutProfile} from './layout-manager';
export type {LayoutProfile} from './layout-manager';
export {PersonalThemeLibrary} from './theme-library';
export {mountLayoutCustomizer} from './layout-customizer';
export type {ThemeCenterLocale} from './layout-customizer';
export {shellIcon,navigationIcon} from './icons';
export type {ShellIcon} from './icons';
export {bindSidebar} from './sidebar';
export {mountNavigation} from './navigation';
export type {NavigationLocale,SearchEntry} from './navigation';
export {BaseMediaLook,EntryMediaLook,DashboardMediaLook,applyMediaTokens} from './media-look';
export type {MediaLocale,MediaIcon} from './media-look';
export {shellMarkup,renderShell,bindShell} from './shell';
export type {ShellContent} from './shell';

export {primeCareIcon,primeCareIconPaths} from './original-assets';
export type {PrimeCareIconName} from './original-assets';
export {WorkspaceLayoutManager,defaultWorkspaceLayout} from './workspace-layout';
export type {WorkspaceLayout,WorkspaceSlots,PanelDock} from './workspace-layout';
