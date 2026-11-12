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
  constructor(private readonly connections: ScreenConnections) {}

  registerScope(scope: string, registrations: readonly ScreenRegistration[]): void {
    const next = new Map(this.registrations);
    for (const id of this.scopes.get(scope) ?? []) next.delete(id);
    const ids = new Set<string>();
    const routes = new Set<string>();
    for (const registration of registrations) {
      if (!registration.id || !registration.adapter || !registration.route.startsWith('/') ||
          registration.route.startsWith('//') || /[?#\\\s]/.test(registration.route) ||
          !['public', 'workspace-host', 'governed', 'feature'].includes(registration.kind)) {
        throw new ScreenConfigurationError('Invalid registration');
      }
      if (next.has(registration.id) || ids.has(registration.id) || routes.has(registration.route)) {
        throw new ScreenConfigurationError(`Duplicate registration: ${registration.id}`);
      }
      ids.add(registration.id); routes.add(registration.route);
      next.set(registration.id, Object.freeze({...registration}));
    }
    // Replace only after the complete snapshot validates; never partially install it.
    this.registrations = next;
    this.scopes.set(scope, ids);
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
export function installScreenManager(root: HTMLElement, manager: ScreenManager): void {
  if (managers.has(root)) throw new ScreenConfigurationError('Root already has a manager');
  managers.set(root, manager);
}
export function requireScreenManager(root: HTMLElement): ScreenManager {
  const manager = managers.get(root);
  if (!manager) { const error = new ScreenConfigurationError('Missing manager at route boundary'); showScreenConfigurationError(root, error); throw error; }
  return manager;
}
export function showScreenConfigurationError(root: HTMLElement, error: unknown): void {
  // Never leave the previous screen visible, and never interpolate errors as HTML.
  const message = root.ownerDocument.createElement('main');
  message.setAttribute('data-cy', 'error-state'); message.setAttribute('role', 'alert');
  message.textContent = error instanceof ScreenConfigurationError ? error.message : 'Screen Manager: Presentation connection failed';
  root.replaceChildren(message);
}
