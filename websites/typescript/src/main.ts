import {renderPSWRequests} from './psw-personal';
import {renderPSW} from './psw-workspace';
import {renderBusinessPlans} from './business-plans/dashboard';
import solidTheme from '../../../packages/shared/src/solid-theme.json';
import {mountExternalDialer} from './external-calls';
import {initializePortalInstall} from './portal-install';
import {renderCare} from './care/dashboard';
import {renderLookReview} from './look-review';
import {renderAuthRecovery} from './auth-recovery';
import {renderEnquiry} from './growth/enquiry';
import {renderGrowth} from './growth/dashboard';
import {renderPlatformAdmin} from './platform-admin';
import {renderAuth} from './auth-screen';
import {renderMaintenance} from './maintenance';
import {renderWorkspace} from './workspace';

type ElementSpec = { key: string; type: string; label: string; testId: string; required: boolean };
type SectionSpec = { code: string; name: string; type: string; purpose: string; testId: string; elements: ElementSpec[] };
type ScreenSpec = { id: number; code: string; name: string; route: string; roleId: number | null; roleName: string; stage: string; implementation: string; api: string; sections: SectionSpec[] };
type Capability = { code: string; name: string; description: string; view: boolean; create: boolean; edit: boolean; delete: boolean; export: boolean };
type TaskStep = { order: number; name: string; screenId: number | null; route: string | null; expected: string; status: string };
type TaskFlow = { code: string; name: string; roleId: number; steps: TaskStep[] };
type PortalManifest = {
  project: string; appCode: string; name: string; apiGateway: string; authPortal: string;
  roles: { id: number; code: string; name: string }[]; screens: ScreenSpec[];
  capabilities: Record<string, Capability[]>; workflows: TaskFlow[];
  theme: Record<string, string>; resources: Record<string, string>; generatedAt: string;
};

const selectedRoot = document.querySelector<HTMLElement>('#app');
if (!selectedRoot) throw new Error('Missing application root');
const root: HTMLElement = selectedRoot;
initializePortalInstall();
const requestedLocale = new URLSearchParams(location.search).get('locale');
if (requestedLocale === 'en' || requestedLocale === 'fr' || requestedLocale === 'es') document.documentElement.lang = requestedLocale;

const escapeHtml = (value: unknown) => String(value ?? '').replace(/[&<>'"]/g, (character) => ({
  '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;',
}[character] ?? character));

async function loadManifest(): Promise<PortalManifest> {
  const response = await fetch('/portal.json', { cache: 'no-store' });
  if (!response.ok) throw new Error(`Portal manifest failed with HTTP ${response.status}`);
  return response.json() as Promise<PortalManifest>;
}

function applyTheme(theme: Record<string, string>): void {
  for (const [property, value] of Object.entries(theme)) document.documentElement.style.setProperty(property, value);
}


loadManifest().then((manifest) => { applyTheme({...manifest.theme,...solidTheme});document.documentElement.dataset.surfaceStyle='solid';const token=sessionStorage.getItem('primecare_session');if(token&&!/^\/(?:login|forgot-password|reset-password|generated\/(?:forgot-password|reset-password))\/?$/.test(location.pathname))mountExternalDialer(manifest.apiGateway,token); ['/forgot-password','/generated/forgot-password'].includes(location.pathname)?renderAuthRecovery(root,manifest.apiGateway,manifest.name,'forgot'):['/reset-password','/generated/reset-password'].includes(location.pathname)?renderAuthRecovery(root,manifest.apiGateway,manifest.name,'reset'):location.pathname.startsWith('/enquire/')?void renderEnquiry(root,manifest.apiGateway):location.pathname==='/appearance-review'?void renderLookReview(root,manifest.apiGateway):location.pathname==='/psw-requests'?void renderPSWRequests(root,manifest.apiGateway):['/psw','/care'].includes(location.pathname)?void renderPSW(root,manifest.apiGateway):location.pathname==='/business-plans'?void renderBusinessPlans(root,manifest.apiGateway):location.pathname==='/growth'?void renderGrowth(root,manifest.apiGateway):location.pathname==='/platform/administration'?void renderPlatformAdmin(root,manifest.apiGateway):location.pathname==='/maintenance/configuration'?void renderMaintenance(root,manifest.apiGateway):location.pathname==='/login' || manifest.appCode === 'au' ? renderAuth(root,manifest.apiGateway,manifest.name) : void renderWorkspace(root,manifest.apiGateway); })
  .catch((error) => { root.innerHTML = `<main class="fatal" data-cy="error-state"><h1>Unable to start PrimeCare</h1><p>${escapeHtml(error)}</p></main>`; });
