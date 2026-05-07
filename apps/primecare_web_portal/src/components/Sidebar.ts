import { controlCenter } from '../core/ControlCenter';
import type { ViewId } from '../core/ControlCenter';
import { i18n } from '../core/i18n';

export function Sidebar(): HTMLElement {
  const sidebar = document.createElement('aside');
  sidebar.className = 'sidebar';

  const header = document.createElement('div');
  header.className = 'sidebar-header';
  header.innerHTML = `
    <div class="logo">⚡</div>
    <span>PrimeCare</span>
  `;
  sidebar.appendChild(header);

  const nav = document.createElement('nav');
  const list = document.createElement('ul');
  list.className = 'nav-list';

  const renderMenu = () => {
    const state = controlCenter.getState();
    list.innerHTML = '';
    const menuItems: { id: ViewId; labelKey: any; icon: string }[] = [
      { id: 'dashboard', labelKey: 'dashboard', icon: '📊' },
      { id: 'clients', labelKey: 'clients', icon: '👥' },
      { id: 'telemetry', labelKey: 'telemetry', icon: '📈' },
      { id: 'kitchen_sink', labelKey: 'kitchen_sink', icon: '🧪' },
      { id: 'settings', labelKey: 'settings', icon: '⚙️' },
    ];

    menuItems.forEach(item => {
      const li = document.createElement('li');
      li.className = 'nav-item';
      li.dataset.view = item.id;
      li.innerHTML = `<span>${item.icon}</span> ${i18n.t(item.labelKey)}`;
      
      li.onclick = () => controlCenter.setView(item.id);
      if (state.currentView === item.id) {
        li.classList.add('active');
      }
      list.appendChild(li);
    });
  };

  nav.appendChild(list);
  sidebar.appendChild(nav);

  // Subscribe to state changes
  controlCenter.subscribe(renderMenu);
  renderMenu();

  return sidebar;
}
