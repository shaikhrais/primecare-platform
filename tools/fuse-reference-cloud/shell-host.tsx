/** Isolated original-shell capture. Guest fixture only; no production authority. */
import {useEffect, useRef} from 'react';
import {useNavbarContext} from './components/theme-layouts/components/navbar/contexts/NavbarContext/useNavbarContext';
import {QueryClient, QueryClientProvider} from '@tanstack/react-query';
import {I18nProvider} from '@i18n/I18nProvider';
import AppContext from './contexts/AppContext';
import {NavbarContextProvider} from './components/theme-layouts/components/navbar/contexts/NavbarContext/NavbarContextProvider';
import {NavigationContextProvider} from './components/theme-layouts/components/navigation/contexts/NavigationContextProvider';
import {QuickPanelProvider} from './components/theme-layouts/components/quickPanel/contexts/QuickPanelContext/QuickPanelContextProvider';
import {FuseDialogContextProvider} from './@fuse/core/FuseDialog/contexts/FuseDialogContext/FuseDialogContextProvider';
import themeLayouts from './components/theme-layouts/themeLayouts';
import FuseLayout from './@fuse/core/FuseLayout/FuseLayout';
const client=new QueryClient({defaultOptions:{queries:{retry:false}}});
function OpenReferenceDrawer() {
 const {openMobileNavbar} = useNavbarContext();
 const opened = useRef(false);
 useEffect(() => {
  if (opened.current) return;
  opened.current = true;
  openMobileNavbar();
 }, [openMobileNavbar]);
 return null;
}
export default function ShellReference({layout}:{layout:string}){
 if(!themeLayouts[layout])throw new Error('Unknown reference shell layout');
 return <AppContext value={{routes:[]}}><QueryClientProvider client={client}><I18nProvider><NavbarContextProvider>{layout === 'layout1' && new URLSearchParams(location.search).get('sidebarCase') === 'drawer' && <OpenReferenceDrawer />}<NavigationContextProvider><FuseDialogContextProvider><QuickPanelProvider><FuseLayout layouts={themeLayouts}/></QuickPanelProvider></FuseDialogContextProvider></NavigationContextProvider></NavbarContextProvider></I18nProvider></QueryClientProvider></AppContext>;
}
