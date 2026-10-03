import { login } from './auth-client';
import {renderMaintenance} from './maintenance';

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

const loadProgress = (key: string): Set<string> => {
  try {
    const stored = JSON.parse(localStorage.getItem(key) || '[]');
    return new Set<string>(Array.isArray(stored) ? stored.map(String) : []);
  } catch {
    localStorage.removeItem(key);
    return new Set<string>();
  }
};

const withSemantics = (route: string) => `${route}${route.includes('?') ? '&' : '?'}enable-semantics=true`;

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

function sectionMarkup(section: SectionSpec): string {
  const elements = section.elements.map((element) => `<div class="element" data-cy="${escapeHtml(element.testId)}">
    <span class="element-type">${escapeHtml(element.type)}</span><strong>${escapeHtml(element.label)}</strong>
  </div>`).join('');
  return `<section class="section" data-cy="${escapeHtml(section.testId)}"><header><div><p class="eyebrow">${escapeHtml(section.type)}</p>
    <h2>${escapeHtml(section.name)}</h2></div></header><p>${escapeHtml(section.purpose)}</p><div class="element-grid">${elements}</div></section>`;
}

function renderPortal(manifest: PortalManifest): void {
  let selectedRole = Number(sessionStorage.getItem(`${manifest.project}:role`) || manifest.roles[0]?.id || 0);
  const routeScreen = () => manifest.screens.find((screen) => screen.route === location.pathname)
    || manifest.screens.find((screen) => !selectedRole || screen.roleId === selectedRole)
    || manifest.screens[0];
  const draw = () => {
    const allowed = manifest.screens.filter((screen) => !selectedRole || screen.roleId === selectedRole);
    const screen = routeScreen();
    const navigation = allowed.map((item) => `<a href="${escapeHtml(withSemantics(item.route))}" data-route="${escapeHtml(item.route)}" data-cy="sidebar-item-${escapeHtml(item.code)}">${escapeHtml(item.name)}</a>`).join('');
    const roles = manifest.roles.map((role) => `<option value="${role.id}" ${role.id === selectedRole ? 'selected' : ''}>${escapeHtml(role.name)}</option>`).join('');
    const capabilities = manifest.capabilities[String(selectedRole)] || [];
    const workflows = manifest.workflows.filter((workflow) => workflow.roleId === selectedRole);
    const capabilityMarkup = capabilities.map((capability) => {
      const actions = [capability.view && 'View', capability.create && 'Create', capability.edit && 'Edit', capability.delete && 'Delete', capability.export && 'Export'].filter(Boolean).join(' · ');
      return `<article class="capability" data-cy="capability-${escapeHtml(capability.code)}"><strong>${escapeHtml(capability.name)}</strong><p>${escapeHtml(capability.description)}</p><span>${escapeHtml(actions)}</span></article>`;
    }).join('');
    const workflowMarkup = workflows.map((workflow) => {
      const progressKey = `${manifest.project}:${selectedRole}:${workflow.code}`;
      const completed = loadProgress(progressKey);
      const steps = workflow.steps.map((step) => `<li class="task-step ${completed.has(String(step.order)) ? 'complete' : ''}">
        <input type="checkbox" data-progress="${escapeHtml(progressKey)}" data-step="${step.order}" ${completed.has(String(step.order)) ? 'checked' : ''} aria-label="Complete ${escapeHtml(step.name)}">
        ${step.route ? `<a href="${escapeHtml(withSemantics(step.route))}" data-route="${escapeHtml(step.route)}">${escapeHtml(step.name)}</a>` : `<span>${escapeHtml(step.name)}</span>`}
        <small>${escapeHtml(step.expected)}</small></li>`).join('');
      return `<article class="workflow" data-cy="workflow-${escapeHtml(workflow.code)}"><h3>${escapeHtml(workflow.name)}</h3><ol>${steps}</ol></article>`;
    }).join('');
    root.innerHTML = `<div class="app-shell" data-cy="app-shell"><aside data-cy="app-sidebar"><a class="brand" href="${withSemantics('/')}">PrimeCare</a>
      <p>${escapeHtml(manifest.name)}</p><label class="role-label">Role<select data-cy="role-selector">${roles}</select></label>
      <nav aria-label="Portal screens">${navigation || '<p class="empty">No governed screens for this role.</p>'}</nav></aside>
      <div class="workspace"><header class="topbar" data-cy="app-topbar"><button class="menu" aria-label="Toggle navigation" data-cy="sidebar-toggle">☰</button>
      <a href="/maintenance/configuration">IT maintenance</a><span id="api-health" data-cy="api-status">Checking API…</span><a href="${escapeHtml(manifest.authPortal)}?enable-semantics=true">Account</a></header>
      <main data-cy="screen-${escapeHtml(screen?.code || 'empty')}"><section class="task-center" data-cy="role-task-center"><div class="screen-header"><div><p class="eyebrow">Role orientation</p><h1>What you can do</h1></div><span class="badge">${workflows.length} workflows · ${capabilities.length} capabilities</span></div>
      <div class="capability-grid">${capabilityMarkup || '<p class="empty">No feature permissions are registered for this role.</p>'}</div>
      <div class="workflow-grid">${workflowMarkup || '<p class="empty">No ordered workflow is registered for this role.</p>'}</div></section>
      ${screen ? `<div class="screen-header"><div><p class="eyebrow">${escapeHtml(screen.stage)}</p>
      <h1>${escapeHtml(screen.name)}</h1><p>${escapeHtml(screen.route)}</p></div><span class="badge">${escapeHtml(screen.api)}</span></div>
      ${screen.sections.map(sectionMarkup).join('')}` : '<section class="section"><h1>No governed screens</h1></section>'}</main></div></div>`;
    root.querySelector<HTMLSelectElement>('select')?.addEventListener('change', (event) => {
      selectedRole = Number((event.currentTarget as HTMLSelectElement).value); sessionStorage.setItem(`${manifest.project}:role`, String(selectedRole));
      const first = manifest.screens.find((item) => item.roleId === selectedRole); if (first) history.replaceState({}, '', withSemantics(first.route)); draw();
    });
    root.querySelectorAll<HTMLAnchorElement>('a[data-route]').forEach((link) => link.addEventListener('click', (event) => {
      event.preventDefault(); history.pushState({}, '', link.href); draw();
    }));
    root.querySelectorAll<HTMLInputElement>('input[data-progress]').forEach((checkbox) => checkbox.addEventListener('change', () => {
      const key = checkbox.dataset.progress; const step = checkbox.dataset.step; if (!key || !step) return;
      const completed = loadProgress(key);
      checkbox.checked ? completed.add(step) : completed.delete(step); localStorage.setItem(key, JSON.stringify([...completed])); draw();
    }));
    root.querySelector<HTMLButtonElement>('.menu')?.addEventListener('click', () => root.querySelector('aside')?.classList.toggle('open'));
    fetch(`${manifest.apiGateway}/health`, { cache: 'no-store' }).then((response) => {
      const health = root.querySelector<HTMLElement>('#api-health'); if (health) health.textContent = response.ok ? 'API connected' : 'API degraded';
    }).catch(() => { const health = root.querySelector<HTMLElement>('#api-health'); if (health) health.textContent = 'API unavailable'; });
  };
  addEventListener('popstate', draw); draw();
}

loadManifest().then((manifest) => { applyTheme(manifest.theme); location.pathname==='/maintenance/configuration'?void renderMaintenance(root,manifest.apiGateway):location.pathname==='/login' || manifest.appCode === 'au' ? renderAuth(manifest) : renderPortal(manifest); })
  .catch((error) => { root.innerHTML = `<main class="fatal" data-cy="error-state"><h1>Unable to start PrimeCare</h1><p>${escapeHtml(error)}</p></main>`; });
