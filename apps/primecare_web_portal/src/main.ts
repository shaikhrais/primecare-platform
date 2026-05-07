import './style.css'
import { Sidebar } from './components/Sidebar'
import { Topbar } from './components/Topbar'
import { Content } from './components/Content'
import { viewRegistry } from './core/ViewRegistry'
import { DashboardView } from './views/DashboardView'
import { TelemetryView } from './views/TelemetryView'
import { KitchenSinkView } from './views/KitchenSinkView'

// Register Platform Views
viewRegistry.register('dashboard', DashboardView);
viewRegistry.register('telemetry', TelemetryView);
viewRegistry.register('kitchen_sink', KitchenSinkView);

const app = document.querySelector<HTMLDivElement>('#app')!

// Enterprise Shell Initialization
function initializeShell() {
  app.innerHTML = '';
  
  // Create and mount core layout components
  const sidebar = Sidebar();
  const topbar = Topbar();
  const content = Content();

  app.appendChild(sidebar);
  app.appendChild(topbar);
  app.appendChild(content);

  console.log('⚡ PrimeCare Enterprise Shell Initialized');
}

initializeShell();
