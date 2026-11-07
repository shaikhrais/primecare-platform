import {renderTenantDashboard} from './tenant-dashboard';
import {renderCoordinatorCharge} from './coordinator-charge';
import {renderPSWRequests} from './psw-personal';
import {renderPSW} from './psw-workspace';
import {renderBusinessPlans} from './business-plans/dashboard';
import {installPortalPresentation} from './screen-presentation';
import {resolveManagedRoute} from './managed-routes';
import {mountExternalDialer} from './external-calls';
import {initializePortalInstall} from './portal-install';
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

// The manifest can settle before the first renderer has installed its own
// lifecycle. Keep this entry's pending delivery silent while hidden or retired.
const startupView = root.ownerDocument.defaultView ?? window;
let startupRetired = false;
let startupSuspended = false;
let dispatchedUrl: string | undefined;
let wakeStartup: (() => void) | undefined;
const releaseStartup = () => {
  startupView.removeEventListener('pagehide', hideStartup);
  startupView.removeEventListener('pageshow', showStartup);
  wakeStartup?.(); wakeStartup = undefined;
};
const retireStartup = () => { startupRetired = true; releaseStartup(); };
const hideStartup = (event: PageTransitionEvent) => {
  if (!event.persisted) { retireStartup(); return; }
  startupSuspended = true;
};
const showStartup = (event: PageTransitionEvent) => {
  if (!event.persisted || startupRetired) return;
  startupSuspended = false;
  wakeStartup?.(); wakeStartup = undefined;
};
const startupCurrent = () => {
  if (startupRetired) return false;
  if (root.isConnected === false || root.ownerDocument.querySelector('#app') !== root ||
      (dispatchedUrl !== undefined && dispatchedUrl !== location.pathname + location.search + (location.hash ?? ''))) {
    retireStartup(); return false;
  }
  return true;
};
const awaitStartup = async () => {
  while (startupCurrent()) {
    if (!startupSuspended) return true;
    await new Promise<void>(resolve => { wakeStartup = resolve; });
  }
  return false;
};
startupView.addEventListener('pagehide', hideStartup);
startupView.addEventListener('pageshow', showStartup);

loadManifest().then(async manifest => {
  while (await awaitStartup()) {
    // Another hide may arrive after the wait resolves but before this continuation.
    if (startupSuspended) continue;
    if (!startupCurrent()) return;
    const manager = installPortalPresentation(root, manifest.theme, manifest.apiGateway);
    const route = resolveManagedRoute(location.pathname, manifest.appCode);
    manager.registerScope('entry', [route]);
    dispatchedUrl = location.pathname + location.search + (location.hash ?? '');
    await manager.present(route.id, route.route, async () => {
      const token = sessionStorage.getItem('primecare_session');
      if (token && !/^\/(?:login|forgot-password|reset-password|generated\/(?:forgot-password|reset-password))\/?$/.test(location.pathname)) {
        mountExternalDialer(manifest.apiGateway, token);
      }
      // Authentication, grants, tenant scope and API checks stay inside the existing renderers/services.
      switch (route.adapter) {
        case 'forgot': return renderAuthRecovery(root, manifest.apiGateway, manifest.name, 'forgot');
        case 'reset': return renderAuthRecovery(root, manifest.apiGateway, manifest.name, 'reset');
        case 'enquiry': return renderEnquiry(root, manifest.apiGateway);
        case 'look': return renderLookReview(root, manifest.apiGateway);
        case 'tenant': return renderTenantDashboard(root, manifest.apiGateway);
        case 'coordinator': return renderCoordinatorCharge(root, manifest.apiGateway);
        case 'requests': return renderPSWRequests(root, manifest.apiGateway);
        case 'psw': return renderPSW(root, manifest.apiGateway);
        case 'plans': return renderBusinessPlans(root, manifest.apiGateway);
        case 'growth': return renderGrowth(root, manifest.apiGateway);
        case 'platform': return renderPlatformAdmin(root, manifest.apiGateway);
        case 'maintenance': return renderMaintenance(root, manifest.apiGateway);
        case 'login': renderAuth(root, manifest.apiGateway, manifest.name); return;
        case 'workspace': return renderWorkspace(root, manifest.apiGateway);
      }
    });
    return;
  }
}).catch(async error => {
  while (await awaitStartup()) {
    if (startupSuspended) continue;
    if (!startupCurrent()) return;
    root.innerHTML = `<main class="fatal" data-cy="error-state"><h1>Unable to start PrimeCare</h1><p>${escapeHtml(error)}</p></main>`;
    return;
  }
}).finally(releaseStartup);
