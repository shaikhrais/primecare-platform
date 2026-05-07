import { i18n } from '../core/i18n';

export function KitchenSinkView(): HTMLElement {
  const view = document.createElement('div');
  view.className = 'view-container';
  view.innerHTML = `
    <div style="display: flex; flex-direction: column; gap: 32px;">
      <section>
        <h2 style="margin-bottom: 16px;">Typography & Colors</h2>
        <div class="glass-card" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px;">
          <div style="padding: 16px; background: var(--pc-primary); color: white; border-radius: 8px;">Primary Color</div>
          <div style="padding: 16px; background: var(--pc-secondary); color: white; border-radius: 8px;">Secondary Color</div>
          <div style="padding: 16px; background: var(--pc-tertiary); color: white; border-radius: 8px;">Tertiary Color</div>
          <div style="padding: 16px; background: var(--pc-error); color: white; border-radius: 8px;">Error Color</div>
        </div>
      </section>

      <section>
        <h2 style="margin-bottom: 16px;">Interactive Elements</h2>
        <div class="glass-card" style="display: flex; gap: 16px; flex-wrap: wrap;">
          <button class="nav-item active" style="padding: 12px 24px; border-radius: 8px; border: none; cursor: pointer;">Primary Action</button>
          <button style="padding: 12px 24px; border-radius: 8px; border: 1px solid var(--pc-outline); background: transparent; color: var(--pc-on-surface); cursor: pointer;">Secondary Action</button>
          <div style="display: flex; align-items: center; gap: 8px; padding: 8px 16px; background: var(--pc-surface-container-high); border-radius: 20px; font-size: 0.85rem;">
             <span style="width: 8px; height: 8px; background: #4CAF50; border-radius: 50%;"></span>
             Status Badge
          </div>
        </div>
      </section>

      <section>
        <h2 style="margin-bottom: 16px;">Glassmorphism Cards</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 24px;">
          <div class="glass-card">
             <div style="font-weight: 600; margin-bottom: 8px;">Standard Card</div>
             <div style="color: var(--pc-on-surface-variant); font-size: 0.9rem;">Modern frosted glass effect with subtle borders.</div>
          </div>
          <div class="glass-card" style="border-left: 4px solid var(--pc-primary);">
             <div style="font-weight: 600; margin-bottom: 8px;">Accented Card</div>
             <div style="color: var(--pc-on-surface-variant); font-size: 0.9rem;">Perfect for highlighting specific data points.</div>
          </div>
        </div>
      </section>
    </div>
  `;
  return view;
}
