/** Isolated original-shell capture. All account/navigation inputs are fixtures. */
import {useEffect,useState} from 'react';
import {QueryClient, QueryClientProvider} from '@tanstack/react-query';
import {I18nProvider} from '@i18n/I18nProvider';
import AppContext from './contexts/AppContext';
import {NavbarContextProvider} from './components/theme-layouts/components/navbar/contexts/NavbarContext/NavbarContextProvider';
import {NavigationContextProvider} from './components/theme-layouts/components/navigation/contexts/NavigationContextProvider';
import {useNavigationContext} from './components/theme-layouts/components/navigation/contexts/useNavigationContext';
import {QuickPanelProvider} from './components/theme-layouts/components/quickPanel/contexts/QuickPanelContext/QuickPanelContextProvider';
import {FuseDialogContextProvider} from './@fuse/core/FuseDialog/contexts/FuseDialogContext/FuseDialogContextProvider';
import themeLayouts from './components/theme-layouts/themeLayouts';
import FuseLayout from './@fuse/core/FuseLayout/FuseLayout';
import {navigationFixture} from './cloud-user-fixture';
const client=new QueryClient({defaultOptions:{queries:{retry:false}}});
function FixtureNavigation() {
 const {setNavigation} = useNavigationContext();
 const [ready,setReady] = useState(!navigationFixture);
 useEffect(() => {
  if (!navigationFixture) return;
  setNavigation(navigationFixture.entries.map(entry => ({
   id: entry.route,
   type: 'item' as const,
   title: entry.label,
   url: entry.route,
   ...(entry.icon ? {icon: entry.icon} : {}),
  })));
  setReady(true);
 }, [setNavigation]);
 if (!ready) return null;
 return <FuseDialogContextProvider><QuickPanelProvider><FuseLayout layouts={themeLayouts}/></QuickPanelProvider></FuseDialogContextProvider>;
}
export default function ShellReference({layout}:{layout:string}){
 if(!themeLayouts[layout])throw new Error('Unknown reference shell layout');
 return <AppContext value={{routes:[]}}><QueryClientProvider client={client}><I18nProvider><NavbarContextProvider><NavigationContextProvider><FixtureNavigation/></NavigationContextProvider></NavbarContextProvider></I18nProvider></QueryClientProvider></AppContext>;
}
