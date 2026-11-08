import {requireScreenManager,showScreenConfigurationError} from '../../../packages/primecare_ui/web/screen-manager';
import {resolveManagedRoute} from './managed-routes';
import adminEntryRoutes from '../../../packages/shared/src/admin-entry-routes.json';
import {requestMfa} from './auth-mfa';
import {authenticate,revokeProvisionalSession,verifyMfa} from './auth-client';
import {liveScreenText} from './screen-text';
import recovery from '../../../packages/shared/src/auth-recovery.json';
import {EntryMediaLook,applyMediaTokens} from './media-look';
import catalog from '../../../packages/primecare_ui/lib/src/localization/screens/auth.json';
import {renderShell} from './shell';

const owners = new WeakMap<HTMLElement, () => void>();

/** Text updates touch labels only, preserving credentials and the active request. */
export function renderAuth(root: HTMLElement, gateway: string, portalName: string,
  language = (document.documentElement.lang || navigator.language).slice(0, 2)): () => void {
  owners.get(root)?.();
  const manager = requireScreenManager(root), entry = resolveManagedRoute(location.pathname, 'au');
  try {manager.enter(entry.id, entry.route);} catch (error) {showScreenConfigurationError(root, error); throw error;}
  const send: typeof fetch = async (input, init) => {
    // Cleanup may outlive this screen. Never revoke a token now owned by browser storage.
    if (String(input) === gateway.replace(/\/+$/, '') + '/v1/auth/logout') {
      const authorization = new Headers(init?.headers).get('authorization');
      const token = authorization?.startsWith('Bearer ') ? authorization.slice(7) : null;
      try {if (token && sessionStorage.getItem('primecare_session') === token) return Promise.resolve(new Response(null, {status: 204}));}
      catch {return Promise.resolve(new Response(null, {status: 204}));}
    } else {
      await wait(); if (!current()) throw Error('Retired authentication');
    }
    return fetch(input, init);
  };
  const route = location.pathname + location.search, startingSession = sessionStorage.getItem('primecare_session');
  const events = root.ownerDocument.defaultView ?? window, lifetime = new AbortController();
  let loginForm: HTMLFormElement | undefined;
  let alive = true, suspended = false, stop = () => {}, nodes: Node[] = [], observer: MutationObserver | undefined;
  const resumes = new Set<() => void>();
  const release = () => {for (const resolve of resumes) resolve(); resumes.clear();};
  function dispose() {
    if (!alive) return;
    alive = false; suspended = false;
    for (const field of loginForm?.querySelectorAll<HTMLInputElement>('input') ?? []) field.value = '';
    stop(); lifetime.abort(); release(); observer?.disconnect();
    events.removeEventListener('pagehide', hide); events.removeEventListener('pageshow', show);
    events.removeEventListener('popstate', history); events.removeEventListener('hashchange', history);
    if (owners.get(root) === dispose) owners.delete(root);
  }
  function owned() {
    if (!alive || owners.get(root) !== dispose) return false;
    const now = Array.from(root.childNodes);
    if (!root.isConnected || (loginForm && (!loginForm.isConnected || !root.contains(loginForm))) || now.length !== nodes.length || now.some((node, i) => node !== nodes[i])) {dispose(); return false;}
    return true;
  }
  function current() {
    if (suspended || !owned()) return false;
    let sameSession = false;
    try {sameSession = sessionStorage.getItem('primecare_session') === startingSession;} catch {}
    if (location.pathname + location.search !== route || !sameSession) {dispose(); root.replaceChildren(); return false;}
    try {manager.enter(entry.id, entry.route);} catch (error) {if (owned()) {dispose(); showScreenConfigurationError(root, error);} return false;}
    return owned();
  }
  const wait = async () => {
    // A new pagehide may precede the continuation queued by pageshow.
    while (suspended && alive) await new Promise<void>(resolve => resumes.add(resolve));
  };
  const history = () => {if (!suspended) current();};
  const hide = (event: PageTransitionEvent) => {if (event.persisted) suspended = true; else dispose();};
  const show = (event: PageTransitionEvent) => {if (event.persisted && suspended && alive) {suspended = false; current(); release();}};
  const locale = language === 'fr' || language === 'es' ? language : 'en';
  const recoveryQuery=new URLSearchParams();if(locale!=='en')recoveryQuery.set('locale',locale);recoveryQuery.set('enable-semantics','true');
  applyMediaTokens();
  const media = new EntryMediaLook(locale);
  const store = liveScreenText(gateway);
  const fallback = catalog.locales[locale];
  const text = (key: keyof typeof fallback) => store.text('auth', locale, key, fallback[key]);
  renderShell(root, {home: recovery.routes.login + '?enable-semantics=true', role: '', navigation: '', controls: '', hideChrome: true,
    mainAttributes: 'class="auth-shell auth-media-shell" data-cy="screen-auth-login"',
    content: `<div class="auth-media-layout">${media.render()}<div class="auth-form-pane">
    <form class="auth-card" data-cy="login-form" aria-label="">
      ${media.brand()}<p class="eyebrow">${media.text('signin')}</p><h1></h1><p class="auth-media-support">${media.text('support')}</p>
      <label><span data-auth-text="email"></span><span class="media-field">${media.icon('mail','media-login-mail')}<input name="email" type="email" required autocomplete="username" data-cy="login-email"></span></label>
      <label><span data-auth-text="password"></span><span class="media-field">${media.icon('key','media-login-key')}<input name="password" type="password" required autocomplete="current-password" data-cy="login-password"></span></label>
      <button class="media-signin" type="submit" data-cy="login-submit"><span data-auth-text="login"></span>${media.icon('arrow','media-login-arrow')}</button>
      <output class="status" aria-live="polite" data-cy="api-status"></output>
      <a data-cy="login-forgot" href="${recovery.routes.forgot}?${recoveryQuery}" data-auth-text="forgot"></a>
    </form></div></div>`});
  nodes = Array.from(root.childNodes); owners.set(root, dispose);
  observer = new MutationObserver(() => {owned();}); observer.observe(root.ownerDocument, {childList: true, subtree: true});
  events.addEventListener('pagehide', hide); events.addEventListener('pageshow', show);
  events.addEventListener('popstate', history); events.addEventListener('hashchange', history);
  root.querySelector('h1')!.textContent = portalName;
  const form = root.querySelector<HTMLFormElement>('form')!; loginForm = form;
  const status = root.querySelector<HTMLOutputElement>('output')!;
  let statusKey: keyof typeof fallback | null = null;
  let submitting = false;
  const drawText = () => {
    if (!current()) return;
    root.querySelectorAll<HTMLElement>('[data-auth-text]').forEach(element => {
      element.textContent = text(element.dataset.authText as keyof typeof fallback);
    });
    form.setAttribute('aria-label', text('login_body'));
    if (statusKey) status.value = text(statusKey);
  };
  drawText();
  if (alive) stop = store.subscribe(drawText);
  form.addEventListener('submit', async event => {
    event.preventDefault();
    if (submitting || !current()) return;
    submitting = true;
    statusKey = 'loading'; drawText();
    const fields = new FormData(form);
    let provisionalToken: string | null = null, committed = false;
    try {
      const confirmed = await authenticate(gateway, String(fields.get('email') || ''), String(fields.get('password') || ''),send,async challenge => {
        await wait(); if (!current()) throw Error('Retired authentication');
        form.reset(); form.hidden = true;
        try {return await requestMfa(form.parentElement!, challenge, locale, async code => {
          await wait(); if (!current()) throw Error('Retired authentication');
          let token: string;
          try {token = await verifyMfa(gateway, challenge.challenge, code);} catch (error) {
            // requestMfa owns retry UI; do not deliver a failure to it while suspended.
            await wait(); if (!current()) throw Error('Retired authentication');
            throw error;
          }
          await wait();
          if (!current()) {await revokeProvisionalSession(gateway, token, send); throw Error('Retired authentication');}
          return token;
        }, lifetime.signal, token => revokeProvisionalSession(gateway, token, send));} finally {
          if (current()) {form.hidden = false; form.querySelector<HTMLInputElement>('[name=email]')?.focus();}
        }
      });
      provisionalToken = confirmed.token;
      await wait(); if (!current()) throw Error('Retired authentication');
      const claims = confirmed.identity;
      statusKey = 'success_title'; drawText();
      const returnUrl = new URLSearchParams(location.search).get('returnUrl');
      const destination = Object.hasOwn(adminEntryRoutes,claims.roles) ? adminEntryRoutes[claims.roles as keyof typeof adminEntryRoutes] : claims.roles === 'maintenance' || (claims.roles === 'ceo' && returnUrl === '/maintenance/configuration') ? '/maintenance/configuration' : '/';
      const query = new URLSearchParams();
      if (locale !== 'en') query.set('locale', locale);
      query.set('enable-semantics', 'true');
      if (!current()) throw Error('Retired authentication');
      sessionStorage.setItem('primecare_session', provisionalToken);
      committed = true;
      location.assign(destination + '?' + query);
    } catch {
      if (provisionalToken) {
        try {
          if (committed && sessionStorage.getItem('primecare_session') === provisionalToken) sessionStorage.removeItem('primecare_session');
        } catch {/* Storage may be unavailable; never remove another account's session. */}
        await revokeProvisionalSession(gateway,provisionalToken,send);
      }
      // Cleanup above (and authenticate's failed identity cleanup) must not wait for UI.
      await wait(); if (!current()) return;
      statusKey = 'error_body'; drawText();
    } finally {submitting = false;}
  }, {signal: lifetime.signal});
  return dispose;
}
