import adminEntryRoutes from '../../../packages/shared/src/admin-entry-routes.json';
import {requestMfa} from './auth-mfa';
import {authenticate,revokeProvisionalSession,verifyMfa} from './auth-client';
import {liveScreenText} from './screen-text';
import recovery from '../../../packages/shared/src/auth-recovery.json';
import {EntryMediaLook,applyMediaTokens} from './media-look';
import catalog from '../../../packages/primecare_ui/lib/src/localization/screens/auth.json';
import {renderShell} from './shell';

/** Text updates touch labels only, preserving credentials and the active request. */
export function renderAuth(root: HTMLElement, gateway: string, portalName: string,
  language = (document.documentElement.lang || navigator.language).slice(0, 2)): () => void {
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
      <label><span data-auth-text="email"></span><span class="media-field">${media.icon('mail','media-login-mail')}<input name="email" type="email" required autocomplete="username" data-cy="login-email" aria-label="login-email"></span></label>
      <label><span data-auth-text="password"></span><span class="media-field">${media.icon('key','media-login-key')}<input name="password" type="password" required autocomplete="current-password" data-cy="login-password" aria-label="login-password"></span></label>
      <button class="media-signin" type="submit" data-cy="login-submit" aria-label="login-submit"><span data-auth-text="login"></span>${media.icon('arrow','media-login-arrow')}</button>
      <output class="status" aria-live="polite" data-cy="api-status"></output>
      <a data-cy="login-forgot" href="${recovery.routes.forgot}?${recoveryQuery}" data-auth-text="forgot"></a>
    </form></div></div>`});
  root.querySelector('h1')!.textContent = portalName;
  const form = root.querySelector<HTMLFormElement>('form')!;
  const status = root.querySelector<HTMLOutputElement>('output')!;
  let statusKey: keyof typeof fallback | null = null;
  let submitting = false;
  const drawText = () => {
    root.querySelectorAll<HTMLElement>('[data-auth-text]').forEach(element => {
      element.textContent = text(element.dataset.authText as keyof typeof fallback);
    });
    form.setAttribute('aria-label', text('login_body'));
    if (statusKey) status.value = text(statusKey);
  };
  drawText();
  const stop = store.subscribe(drawText);
  form.addEventListener('submit', async event => {
    event.preventDefault();
    if (submitting) return;
    submitting = true;
    statusKey = 'loading'; drawText();
    const fields = new FormData(form);
    let provisionalToken: string | null = null;
    try {
      const confirmed = await authenticate(gateway, String(fields.get('email') || ''), String(fields.get('password') || ''),fetch,async challenge=>{form.reset();form.hidden=true;try{return await requestMfa(form.parentElement!,challenge,locale,code=>verifyMfa(gateway,challenge.challenge,code));}finally{form.hidden=false;}});
      provisionalToken = confirmed.token;
      const claims = confirmed.identity;
      sessionStorage.setItem('primecare_session', provisionalToken);
      statusKey = 'success_title'; drawText();
      const returnUrl = new URLSearchParams(location.search).get('returnUrl');
      const destination = Object.hasOwn(adminEntryRoutes,claims.roles) ? adminEntryRoutes[claims.roles as keyof typeof adminEntryRoutes] : claims.roles === 'maintenance' || (claims.roles === 'ceo' && returnUrl === '/maintenance/configuration') ? '/maintenance/configuration' : '/';
      const query = new URLSearchParams();
      if (locale !== 'en') query.set('locale', locale);
      query.set('enable-semantics', 'true');
      location.assign(destination + '?' + query);
    } catch {
      if (provisionalToken) {
        try {
          if (sessionStorage.getItem('primecare_session') === provisionalToken) sessionStorage.removeItem('primecare_session');
        } catch {/* Storage may be unavailable; never remove another account's session. */}
        await revokeProvisionalSession(gateway,provisionalToken);
      }
      statusKey = 'error_body'; drawText();
    } finally {submitting = false;}
  });
  return stop;
}
