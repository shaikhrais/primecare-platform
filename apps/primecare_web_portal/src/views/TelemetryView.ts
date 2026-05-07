import { i18n } from '../core/i18n';

export function TelemetryView(): HTMLElement {
  const view = document.createElement('div');
  view.className = 'view-container';
  view.innerHTML = `
    <div class="glass-card" style="height: 500px; display: flex; align-items: center; justify-content: center; flex-direction: column; gap: 24px;">
      <div style="width: 64px; height: 64px; border: 4px solid var(--pc-primary); border-top-color: transparent; border-radius: 50%; animation: spin 1s linear infinite"></div>
      <p>${i18n.t('fetching_telemetry')}</p>
    </div>
  `;
  return view;
}
