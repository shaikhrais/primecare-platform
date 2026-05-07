import { controlCenter } from '../core/ControlCenter';
import { i18n } from '../core/i18n';
import type { Language } from '../core/i18n';

export function Topbar(): HTMLElement {
  const topbar = document.createElement('header');
  topbar.className = 'topbar';

  const title = document.createElement('div');
  title.className = 'topbar-title';

  const actions = document.createElement('div');
  actions.style.display = 'flex';
  actions.style.alignItems = 'center';
  actions.style.gap = '24px';

  const langSwitcher = document.createElement('div');
  langSwitcher.className = 'lang-switcher';
  langSwitcher.style.display = 'flex';
  langSwitcher.style.gap = '4px';
  langSwitcher.style.background = 'var(--pc-surface-container)';
  langSwitcher.style.padding = '4px';
  langSwitcher.style.borderRadius = 'var(--pc-radius-sm)';

  const profile = document.createElement('div');
  profile.className = 'user-profile';

  const render = () => {
    const state = controlCenter.getState();
    title.textContent = state.viewTitle;

    // Render Lang Switcher
    langSwitcher.innerHTML = '';
    (['en', 'fr', 'es'] as Language[]).forEach(lang => {
      const btn = document.createElement('button');
      btn.textContent = lang.toUpperCase();
      btn.style.padding = '4px 8px';
      btn.style.fontSize = '0.75rem';
      btn.style.fontWeight = '600';
      btn.style.border = 'none';
      btn.style.borderRadius = '4px';
      btn.style.cursor = 'pointer';
      btn.style.transition = 'all 0.2s';
      
      if (state.language === lang) {
        btn.style.background = 'var(--pc-primary)';
        btn.style.color = 'white';
      } else {
        btn.style.background = 'transparent';
        btn.style.color = 'var(--pc-on-surface-variant)';
      }

      btn.onclick = () => controlCenter.setLanguage(lang);
      langSwitcher.appendChild(btn);
    });

    profile.innerHTML = `
      <div class="user-info" style="text-align: right">
        <div style="font-weight: 600; font-size: 0.9rem">${i18n.t('admin_portal')}</div>
        <div style="font-size: 0.75rem; color: var(--pc-on-surface-variant)">${i18n.t('superuser')}</div>
      </div>
      <div class="avatar">AD</div>
    `;
  };

  actions.appendChild(langSwitcher);
  actions.appendChild(profile);

  topbar.appendChild(title);
  topbar.appendChild(actions);

  controlCenter.subscribe(render);
  render();

  return topbar;
}
