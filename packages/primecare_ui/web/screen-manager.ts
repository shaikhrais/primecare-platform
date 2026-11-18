import {DashboardDialogManager,type DashboardDialogOptions} from './dashboard-dialog-manager';

/** Presentation registration only. This class has no identity, grants or API access. */
export type ScreenConnection = 'layout' | 'theme' | 'language' | 'responsive';
export type ScreenRegistration = Readonly<{
  id: string;
  route: string;
  kind: 'public' | 'workspace-host' | 'governed' | 'feature';
  adapter: string;
}>;
export type ScreenConnections = Readonly<Record<ScreenConnection, (screen: ScreenRegistration) => void>>;
const requiredConnections: readonly ScreenConnection[] = ['layout', 'theme', 'language', 'responsive'];

export class ScreenConfigurationError extends Error {
  constructor(message: string) { super(`Screen Manager: ${message}`); this.name = 'ScreenConfigurationError'; }
}

/** Registrations describe existing renderers, never authorize their content. */
export class ScreenManager {
  private registrations = new Map<string, ScreenRegistration>();
  private scopes = new Map<string, Set<string>>();
  private dashboardRoots = new WeakMap<HTMLElement, DashboardDialogManager>();
  private dashboardScopes = new Map<DashboardDialogManager, ScreenRegistration>();
  constructor(private readonly connections: ScreenConnections) {}

  registerScope(scope: string, registrations: readonly ScreenRegistration[]): void {
    this.replaceScopes([[scope, registrations]]);
  }

  /** Atomically replace presentation owners without ever accepting a duplicate path. */
  replaceScopes(replacements: readonly (readonly [string, readonly ScreenRegistration[]])[]): void {
    const next = new Map(this.registrations);
    const scopes = new Map(this.scopes);
    const changed = new Set<string>();
    for (const [scope] of replacements) {
      if (changed.has(scope)) throw new ScreenConfigurationError('Duplicate scope replacement');
      changed.add(scope);
      for (const id of scopes.get(scope) ?? []) next.delete(id);
    }
    const routes = new Set([...next.values()].map(existing => existing.route));
    for (const [scope, registrations] of replacements) {
      const ids = new Set<string>();
      for (const registration of registrations) {
        if (!registration.id || !registration.adapter || !registration.route.startsWith('/') ||
            registration.route.startsWith('//') || /[?#\\\s]/.test(registration.route) ||
            !['public', 'workspace-host', 'governed', 'feature'].includes(registration.kind)) {
          throw new ScreenConfigurationError('Invalid registration');
        }
        if (next.has(registration.id) || routes.has(registration.route)) {
          throw new ScreenConfigurationError(`Duplicate registration: ${registration.id}`);
        }
        ids.add(registration.id); routes.add(registration.route);
        next.set(registration.id, Object.freeze({...registration}));
      }
      scopes.set(scope, ids);
    }
    // Replace only after the complete snapshot validates; never partially install it.
    const retiring = [...this.dashboardScopes].filter(([, registration]) => next.get(registration.id) !== registration);
    this.registrations = next;
    this.scopes = scopes;
    // Capture identities before native close/focus can synchronously replace scopes again.
    for (const [dialogs] of retiring) dialogs.dispose();
  }

  /** Compose a dashboard's panel lifecycle on the existing registered route. */
  connectDashboardDialogs(root: HTMLElement, id: string, route: string, options: DashboardDialogOptions, retire?: () => void): DashboardDialogManager {
    if (managers.get(root) !== this) throw new ScreenConfigurationError('Dashboard root is not owned by this manager');
    const registration = this.registrations.get(id);
    if (!registration || registration.route !== route || registration.kind === 'public') {
      throw new ScreenConfigurationError(`Missing dashboard registration for ${id} at ${route}`);
    }
    if (this.dashboardRoots.has(root)) throw new ScreenConfigurationError('Duplicate dashboard presentation owner');
    const ownsRegistration = (): boolean => this.ownsDashboardDialogs(root,dialogs);
    const dialogs: DashboardDialogManager = new DashboardDialogManager(root, {
      ...options,
      current: (): boolean => ownsRegistration() && options.current() && ownsRegistration(),
    }, () => {
      this.dashboardScopes.delete(dialogs);
      if (this.dashboardRoots.get(root) === dialogs) {
        try { retire?.(); }
        finally { this.dashboardRoots.delete(root); }
      }
    });
    this.dashboardRoots.set(root, dialogs);
    this.dashboardScopes.set(dialogs, registration);
    return dialogs;
  }

  ownsDashboardDialogs(root: HTMLElement, dialogs: DashboardDialogManager): boolean {
    const registration = this.dashboardScopes.get(dialogs);
    return !!registration && managers.get(root) === this && this.dashboardRoots.get(root) === dialogs
      && this.registrations.get(registration.id) === registration;
  }

  clearDashboardDialogs(root: HTMLElement): void {
    this.dashboardRoots.get(root)?.dispose();
  }

  enter(id: string, route: string): ScreenRegistration {
    const registration = this.registrations.get(id);
    if (!registration || registration.route !== route) {
      throw new ScreenConfigurationError(`Missing registration for ${id} at ${route}`);
    }
    for (const name of requiredConnections) {
      if (typeof this.connections?.[name] !== 'function') {
        throw new ScreenConfigurationError(`Missing ${name} connection for ${id}`);
      }
    }
    for (const name of requiredConnections) {
      // A void callback type also accepts async functions in TypeScript. Connections
      // must finish synchronously before content can be invoked; do not ignore a promise.
      const result: unknown = this.connections[name](registration);
      if (result && typeof (result as {then?: unknown}).then === 'function') {
        void Promise.resolve(result).catch(() => {});
        throw new ScreenConfigurationError(`Asynchronous ${name} connection is unsupported for ${id}`);
      }
      if (this.registrations.get(id) !== registration) {
        throw new ScreenConfigurationError(`Registration changed during ${name} connection for ${id}`);
      }
    }
    return registration;
  }

  async present(id: string, route: string, render: () => unknown | Promise<unknown>): Promise<void> {
    this.enter(id, route);
    await render();
  }
}

const managers = new WeakMap<HTMLElement, ScreenManager>();
/** Check before acquiring presentation resources or changing shared document tokens. */
export function assertScreenManagerAvailable(root: HTMLElement): void {
  if (managers.has(root)) throw new ScreenConfigurationError('Root already has a manager');
}
export function installScreenManager(root: HTMLElement, manager: ScreenManager): void {
  assertScreenManagerAvailable(root);
  managers.set(root, manager);
}
export function requireScreenManager(root: HTMLElement): ScreenManager {
  const manager = managers.get(root);
  if (!manager) { const error = new ScreenConfigurationError('Missing manager at route boundary'); showScreenConfigurationError(root, error); throw error; }
  return manager;
}
export function showScreenConfigurationError(root: HTMLElement, error: unknown): void {
  // Never leave the previous screen visible, and never interpolate errors as HTML.
  managers.get(root)?.clearDashboardDialogs(root);
  const message = root.ownerDocument.createElement('main');
  message.setAttribute('data-cy', 'error-state'); message.setAttribute('role', 'alert');
  message.textContent = error instanceof ScreenConfigurationError ? error.message : 'Screen Manager: Presentation connection failed';
  root.replaceChildren(message);
}
