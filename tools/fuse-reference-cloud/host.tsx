import './styles/index.css';
import {createRoot} from 'react-dom/client';
import {useState} from 'react';
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
const initial=_.merge({},defaultSettings,{layout:{style:'layout1',config:layouts.layout1.defaults}},settingsConfig);
if(new URLSearchParams(location.search).get('mode')==='dark')initial.theme={main:themes.defaultDark,navbar:themes.defaultDark,toolbar:themes.defaultDark,footer:themes.defaultDark};
function Reference(){
 const [data,setData]=useState(initial);
 const update=(change)=>{const next=_.merge({},data,change);setData(next);return next;};
 return <FuseSettingsContext value={{data,initial,defaults:data,setSettings:update}}><RootThemeProvider><MainThemeProvider><SnackbarProvider><SettingsPanel open onClose={()=>{}} settingsHandlers={{}}/></SnackbarProvider></MainThemeProvider></RootThemeProvider></FuseSettingsContext>;
}
createRoot(document.getElementById('app')!).render(<BrowserRouter><Reference/></BrowserRouter>);
