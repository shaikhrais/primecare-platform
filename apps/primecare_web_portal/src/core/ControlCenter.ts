import { i18n } from './i18n';
import type { Language } from './i18n';

export type ViewId = 'dashboard' | 'clients' | 'telemetry' | 'settings' | 'kitchen_sink';

export interface ViewState {
  currentView: ViewId;
  viewTitle: string;
  language: Language;
}

type Listener = (state: ViewState) => void;

class ControlCenter {
  private state: ViewState = {
    currentView: 'dashboard',
    viewTitle: i18n.t('sys_overview'),
    language: 'en'
  };

  private listeners: Listener[] = [];

  private getViewTitle(viewId: ViewId): string {
    const map: Record<ViewId, string> = {
      dashboard: i18n.t('sys_overview'),
      clients: i18n.t('client_mgmt'),
      telemetry: i18n.t('real_time_telemetry'),
      settings: i18n.t('platform_settings'),
      kitchen_sink: i18n.t('kitchen_sink')
    };
    return map[viewId];
  }

  public getState() {
    return { ...this.state };
  }

  public setView(viewId: ViewId) {
    if (this.state.currentView === viewId) return;

    this.state = {
      ...this.state,
      currentView: viewId,
      viewTitle: this.getViewTitle(viewId)
    };

    this.notify();
  }

  public setLanguage(lang: Language) {
    if (this.state.language === lang) return;

    i18n.setLanguage(lang);
    this.state = {
      ...this.state,
      language: lang,
      viewTitle: this.getViewTitle(this.state.currentView)
    };

    this.notify();
  }

  public subscribe(listener: Listener) {
    this.listeners.push(listener);
    return () => {
      this.listeners = this.listeners.filter(l => l !== listener);
    };
  }

  private notify() {
    this.listeners.forEach(l => l(this.state));
  }
}

export const controlCenter = new ControlCenter();
