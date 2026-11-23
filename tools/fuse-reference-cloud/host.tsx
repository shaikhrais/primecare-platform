import './styles/index.css';
import {createRoot} from 'react-dom/client';
import {useState,lazy,Suspense} from 'react';
const ShellReference=lazy(()=>import('./cloud-shell-host'));
import {BrowserRouter} from 'react-router';
import _ from 'lodash';
import {SnackbarProvider} from 'notistack';
import FuseSettingsContext from './@fuse/core/FuseSettings/FuseSettingsContext';
import {defaultSettings} from './@fuse/default-settings';
import settingsConfig from './configs/settingsConfig';
import themes from './configs/themesConfig';
import layouts from './components/theme-layouts/themeLayoutConfigs';
import SettingsPanel from './components/theme-layouts/components/configurator/SettingsPanel';
import RootThemeProvider from './contexts/RootThemeProvider';
import MainThemeProvider from './contexts/MainThemeProvider';
const requestedLayout=new URLSearchParams(location.search).get('layout');
const layout=requestedLayout==='layout2'||requestedLayout==='layout3'?requestedLayout:'layout1';
const initial=_.merge({},defaultSettings,settingsConfig,{layout:{style:layout,config:layouts[layout].defaults}});
const sidebarCase = new URLSearchParams(location.search).get('sidebarCase');
if (layout === 'layout1' && sidebarCase === 'folded') {
 initial.layout.config.navbar = { ...initial.layout.config.navbar, style: 'style-2', folded: true };
}
if (layout === 'layout1' && sidebarCase === 'right') {
 initial.layout.config.navbar = { ...initial.layout.config.navbar, position: 'right' };
}
if(new URLSearchParams(location.search).get('mode')==='dark')initial.theme={main:themes.defaultDark,navbar:themes.defaultDark,toolbar:themes.defaultDark,footer:themes.defaultDark};
function Reference(){
 const [data,setData]=useState(initial);
 const update=(change)=>{const next=_.merge({},data,change);setData(next);return next;};
 return <FuseSettingsContext value={{data,initial,defaults:data,setSettings:update}}><RootThemeProvider><MainThemeProvider><SnackbarProvider>{new URLSearchParams(location.search).get('surface')==='shell'?<Suspense fallback={null}><ShellReference layout={layout}/></Suspense>:<SettingsPanel open onClose={()=>{}} settingsHandlers={{}}/>}</SnackbarProvider></MainThemeProvider></RootThemeProvider></FuseSettingsContext>;
}
createRoot(document.getElementById('app')!).render(<BrowserRouter><Reference/></BrowserRouter>);
