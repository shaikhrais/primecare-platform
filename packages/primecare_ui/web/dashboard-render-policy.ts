import {ScreenConfigurationError} from './screen-manager';

/** Routes opt in at the dispatcher before handing off to any feature renderer. */
const required = new WeakSet<HTMLElement>();
const permits = new WeakMap<HTMLElement,()=>boolean>();

export function requireMasterDashboard(root: HTMLElement): void {
  required.add(root);
}

/** Internal to MasterDashboard: one synchronous shell render using a live registration lease. */
export function withMasterDashboardShell<T>(root: HTMLElement, owns: () => boolean, draw:()=>T): T {
  if (!owns() || permits.has(root)) throw new ScreenConfigurationError('Inactive or nested MasterDashboard render');
  permits.set(root,owns);
  try { return draw(); }
  finally { permits.delete(root); }
}

export function assertMasterDashboardShell(root: HTMLElement): void {
  if (!required.has(root)) return;
  const owns=permits.get(root);
  // Consume before checking: even reentrant rendering cannot reuse this authorization.
  permits.delete(root);
  if (!owns?.()) throw new ScreenConfigurationError('Dashboard cannot render: its screen must extend MasterDashboard');
}
