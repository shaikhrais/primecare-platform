import {login} from './auth-client';
import {liveScreenText} from './screen-text';
import recovery from '../../../packages/shared/src/auth-recovery.json';
import {EntryMediaLook,applyMediaTokens} from './media-look';
import catalog from '../../../packages/primecare_ui/lib/src/localization/screens/auth.json';

/** Text updates touch labels only, preserving credentials and the active request. */
export function renderAuth(root: HTMLElement, gateway: string, portalName: string,
  language = (document.documentElement.lang || navigator.language).slice(0, 2)): () => void {
  const locale = language === 'fr' || language === 'es' ? language : 'en';
  applyMediaTokens();
  const media = new EntryMediaLook(locale);
  const store = liveScreenText(gateway);
  const fallback = catalog.locales[locale];
  const text = (key: keyof typeof fallback) => store.text('auth', locale, key, fallback[key]);
  root.innerHTML = `<main class="auth-shell auth-media-shell" data-cy="screen-auth-login"><div class="auth-media-layout">${media.render()}<div class="auth-form-pane">
    <form class="auth-card" data-cy="login-form" aria-label="">
      ${media.brand()}<p class="eyebrow">${media.text('signin')}</p><h1></h1><p class="auth-media-support">${media.text('support')}</p>
      <label><span data-auth-text="email"></span><span class="media-field">${media.icon('mail','media-login-mail')}<input name="email" type="email" required autocomplete="username" data-cy="login-email" aria-label="login-email"></span></label>
      <label><span data-auth-text="password"></span><span class="media-field">${media.icon('key','media-login-key')}<input name="password" type="password" required autocomplete="current-password" data-cy="login-password" aria-label="login-password"></span></label>
      <button class="media-signin" type="submit" data-cy="login-submit" aria-label="login-submit"><span data-auth-text="login"></span>${media.icon('arrow','media-login-arrow')}</button>
      <output class="status" aria-live="polite" data-cy="api-status"></output>
      <a data-cy="login-forgot" href="${recovery.routes.forgot}?enable-semantics=true" data-auth-text="forgot"></a>
    </form></div></div></main>`;
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
    try {
      const token = await login(gateway, String(fields.get('email') || ''), String(fields.get('password') || ''));
      sessionStorage.setItem('primecare_session', token);
      statusKey = 'success_title'; drawText();
      const response = await fetch(`${gateway}/v1/auth/me`, {headers: {authorization: 'Bearer ' + token}, cache: 'no-store'});
      const identity = await response.json() as {roles?: string};
      const returnUrl = new URLSearchParams(location.search).get('returnUrl');
      location.assign(response.ok && identity.roles === 'platform_admin' ? '/platform/administration' : response.ok && (identity.roles === 'maintenance' || (identity.roles === 'ceo' && returnUrl === '/maintenance/configuration')) ? '/maintenance/configuration' : '/');
    } catch {
      statusKey = 'error_body'; drawText();
    } finally {submitting = false;}
  });
  return stop;
}
