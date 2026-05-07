import { i18n } from '../core/i18n';

export function DashboardView(): HTMLElement {
  const view = document.createElement('div');
  view.className = 'view-container';
  view.innerHTML = `
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px;">
      <div class="glass-card">
        <h3>${i18n.t('system_health')}</h3>
        <p style="color: var(--pc-on-surface-variant); margin-top: 8px;">${i18n.t('all_operational')}</p>
        <div style="height: 100px; background: var(--pc-primary-container); border-radius: 8px; margin-top: 16px; opacity: 0.2"></div>
      </div>
      <div class="glass-card">
        <h3>${i18n.t('active_sessions')}</h3>
        <div style="font-size: 2.5rem; font-weight: 700; color: var(--pc-primary); margin: 16px 0;">1,284</div>
      </div>
      <div class="glass-card">
        <h3>${i18n.t('db_latency')}</h3>
        <div style="font-size: 2.5rem; font-weight: 700; color: var(--pc-secondary); margin: 16px 0;">42ms</div>
      </div>
    </div>
  `;
  return view;
}
