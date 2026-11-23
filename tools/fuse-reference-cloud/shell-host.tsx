/** Isolated original-shell capture. Guest fixture only; no production authority. */
import {QueryClient, QueryClientProvider} from '@tanstack/react-query';
import {I18nProvider} from '@i18n/I18nProvider';
import AppContext from './contexts/AppContext';
import {NavbarContextProvider} from './components/theme-layouts/components/navbar/contexts/NavbarContext/NavbarContextProvider';
import {NavigationContextProvider} from './components/theme-layouts/components/navigation/contexts/NavigationContextProvider';
import {QuickPanelProvider} from './components/theme-layouts/components/quickPanel/contexts/QuickPanelContext/QuickPanelContextProvider';
import {FuseDialogContextProvider} from './@fuse/core/FuseDialog/contexts/FuseDialogContext/FuseDialogContextProvider';
import themeLayouts from './components/theme-layouts/themeLayouts';
const client=new QueryClient({defaultOptions:{queries:{retry:false}}});
export default function ShellReference({layout}:{layout:string}){
 const Layout=themeLayouts[layout];
 if(!Layout)throw new Error('Unknown reference shell layout');
 return <AppContext value={{routes:[]}}><QueryClientProvider client={client}><I18nProvider><NavbarContextProvider><NavigationContextProvider><FuseDialogContextProvider><QuickPanelProvider><Layout/></QuickPanelProvider></FuseDialogContextProvider></NavigationContextProvider></NavbarContextProvider></I18nProvider></QueryClientProvider></AppContext>;
}
