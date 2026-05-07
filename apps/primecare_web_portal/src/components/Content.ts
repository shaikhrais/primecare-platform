import { controlCenter } from '../core/ControlCenter';
import type { ViewState } from '../core/ControlCenter';
import { viewRegistry } from '../core/ViewRegistry';
import { i18n } from '../core/i18n';

export function Content(): HTMLElement {
  const container = document.createElement('main');
  container.className = 'content';

  const renderView = (state: ViewState) => {
    container.innerHTML = '';
    
    const viewBuilder = viewRegistry.get(state.currentView);
    
    if (viewBuilder) {
      container.appendChild(viewBuilder());
    } else {
      // Fallback for unregistered or under-construction views
      const fallback = document.createElement('div');
      fallback.className = 'view-container';
      fallback.innerHTML = `
        <div class="glass-card">
          <h2>${state.viewTitle}</h2>
          <p style="margin-top: 16px; color: var(--pc-on-surface-variant)">${i18n.t('under_construction')}</p>
        </div>
      `;
      container.appendChild(fallback);
    }
  };

  // Initial render
  renderView(controlCenter.getState());
  
  // Subscribe to state changes
  controlCenter.subscribe(renderView);

  return container;
}
