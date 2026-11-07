import {mountPresentationLayout,clearLayoutCustomizer} from '../../../packages/primecare_ui/web/layout-customizer';
import solidTheme from '../../../packages/shared/src/solid-theme.json';
import {PortalDocumentScroll} from './document-scroll';
import {ShellEnvironment} from '../../../packages/primecare_ui/web/shell-environment';
import {applyMediaTokens} from './media-look';
import {liveScreenText} from './screen-text';
import {ScreenManager, installScreenManager} from '../../../packages/primecare_ui/web/screen-manager';

/** Bridge existing DOM renderers without replacing their business or account-scoped layouts.
 * Shell renderers retain renderShell/bindShell and their BaseLayoutManager/Theme Center.
 * Raw HTML adapters use the same default-only layout owner, without adding shell chrome.
 */
export function installPortalPresentation(root: HTMLElement, theme: Record<string, string>, gateway: string): ScreenManager {
  if (!theme || typeof theme !== 'object' || Array.isArray(theme) ||
      typeof theme['--color-primary'] !== 'string' || !theme['--color-primary'].trim() ||
      Object.entries(theme).some(([key, value]) => !/^--[A-Za-z0-9_-]+$/.test(key) || typeof value !== 'string' || !value.trim())) {
    throw Error('Screen Manager: Missing or invalid portal theme');
  }
  const css = root.ownerDocument.defaultView?.CSS;
  if (css && !css.supports('color', theme['--color-primary'])) throw Error('Screen Manager: Invalid portal primary color');
  const host = root.ownerDocument.documentElement;
  for (const [property, value] of Object.entries({...theme, ...solidTheme})) host.style.setProperty(property, value);
  host.dataset.surfaceStyle = 'solid';
  const language = liveScreenText(gateway);
  const environment = new ShellEnvironment(root, 'ltr');
  const documentScroll = new PortalDocumentScroll(root);
  const manager = new ScreenManager({
    layout: screen => {environment.routeChanged(screen.id);mountPresentationLayout(root,theme);},
    theme: () => {
      // Preserve the established Theme Center's personal/tenant tokens on subsequent draws.
      if (!host.style.getPropertyValue('--color-primary')) throw Error('Screen Manager: Missing portal theme tokens');
      applyMediaTokens();
    },
    language: () => {
      if (typeof language.text !== 'function' || typeof language.subscribe !== 'function') throw Error('Screen Manager: Missing language connection');
      const locale = host.lang === 'fr' || host.lang === 'es' ? host.lang : 'en';
      host.lang = locale; root.dir = 'ltr';
      // Inherit lang from the document: existing renderers update it on language changes.
    },
    responsive: screen => {
      // The production stylesheet owns responsive breakpoints; do not duplicate them here.
      const styles = root.ownerDocument.defaultView?.getComputedStyle(host).getPropertyValue('--primecare-responsive-styles').trim();
      if (styles !== '1') throw Error('Screen Manager: Missing responsive stylesheet connection');
      documentScroll.routeChanged(screen);
    },
  });
  installScreenManager(root, manager);
  root.ownerDocument.defaultView?.addEventListener('pagehide', event => { if (!event.persisted) {documentScroll.dispose();clearLayoutCustomizer(root);void environment.dispose();} });
  return manager;
}
