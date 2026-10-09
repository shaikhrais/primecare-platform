import { login } from './auth-client';
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

function renderAuth(manifest: PortalManifest): void {
  const username = manifest.resources['login.username'] || 'Username';
  const password = manifest.resources['login.password'] || 'Password';
  const signIn = manifest.resources['login.sign_in'] || 'Sign in';
  root.innerHTML = `<main class="auth-shell" data-cy="screen-auth-login">
    <form class="auth-card" data-cy="login-form" aria-label="PrimeCare authentication">
      <p class="eyebrow">PrimeCare</p><h1>${escapeHtml(manifest.name)}</h1>
      <label>${escapeHtml(username)}<input name="email" type="email" required autocomplete="username" data-cy="login-email" aria-label="login-email"></label>
      <label>${escapeHtml(password)}<input name="password" type="password" required autocomplete="current-password" data-cy="login-password" aria-label="login-password"></label>
      <button type="submit" data-cy="login-submit" aria-label="login-submit">${escapeHtml(signIn)}</button>
      <output class="status" aria-live="polite" data-cy="api-status"></output>
    </form></main>`;
  const form = root.querySelector<HTMLFormElement>('form');
  const status = root.querySelector<HTMLOutputElement>('output');
  form?.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!status || !form) return;
    status.value = 'Signing in…';
    const fields = new FormData(form);
    try {
      const token = await login(manifest.apiGateway, String(fields.get('email') || ''), String(fields.get('password') || ''));
      sessionStorage.setItem('primecare_session', token);
      status.value = 'Sign in successful';
      const identityResponse=await fetch(`${manifest.apiGateway}/v1/auth/me`,{headers:{authorization:'Bearer '+token},cache:'no-store'});
      const identity=await identityResponse.json() as {roles?:string};
      const returnUrl=new URLSearchParams(location.search).get('returnUrl');
      location.assign(identityResponse.ok && (identity.roles==='maintenance' || (identity.roles==='ceo' && returnUrl==='/maintenance/configuration'))?'/maintenance/configuration':'/');
    } catch (error) { status.value = error instanceof Error ? error.message : 'Sign in failed'; }
  });
}

loadManifest().then((manifest) => { applyTheme(manifest.theme); location.pathname==='/maintenance/configuration'?void renderMaintenance(root,manifest.apiGateway):location.pathname==='/login' || manifest.appCode === 'au' ? renderAuth(manifest) : void renderWorkspace(root,manifest.apiGateway); })
  .catch((error) => { root.innerHTML = `<main class="fatal" data-cy="error-state"><h1>Unable to start PrimeCare</h1><p>${escapeHtml(error)}</p></main>`; });
