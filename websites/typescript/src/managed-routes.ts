import type {ScreenRegistration} from '../../../packages/primecare_ui/web/screen-manager';

/** These are adapters for the existing main.ts dispatcher, not new governance records. */
export type RouteAdapter = 'forgot' | 'reset' | 'enquiry' | 'look' | 'tenant' | 'coordinator' |
  'requests' | 'psw' | 'plans' | 'growth' | 'platform' | 'maintenance' | 'login' | 'workspace';
const exact: Readonly<Record<string, RouteAdapter>> = Object.freeze({
  '/forgot-password': 'forgot', '/generated/forgot-password': 'forgot',
  '/reset-password': 'reset', '/generated/reset-password': 'reset',
  '/appearance-review': 'look', '/tenant-dashboard': 'tenant',
  '/coordinator-charge': 'coordinator', '/psw-requests': 'requests',
  '/psw': 'psw', '/care': 'psw', '/business-plans': 'plans', '/growth': 'growth',
  '/platform/administration': 'platform', '/maintenance/configuration': 'maintenance', '/login': 'login',
});
export function resolveManagedRoute(path: string, appCode: string): ScreenRegistration & {adapter: RouteAdapter} {
  const adapter = exact[path] ?? (path.startsWith('/enquire/') ? 'enquiry' : appCode === 'au' ? 'login' : 'workspace');
  const kind = ['forgot', 'reset', 'enquiry', 'login'].includes(adapter) ? 'public' : adapter === 'workspace' ? 'workspace-host' : 'feature';
  return {id: `typescript:${adapter}:${path}`, route: path, kind, adapter};
}
