import {installPortalPresentation} from '../../websites/typescript/src/screen-presentation';
import {resolveManagedRoute} from '../../websites/typescript/src/managed-routes';

/** Isolated browser entry only. Presentation registration never supplies identity or grants. */
export async function presentPlatformFixture(
  root: HTMLElement,
  theme: Record<string, string>,
  gateway: string,
  render: () => unknown | Promise<unknown>,
): Promise<void> {
  const manager = installPortalPresentation(root, theme, gateway);
  const entry = resolveManagedRoute(location.pathname, '');
  manager.registerScope('entry', [entry]);
  await manager.present(entry.id, entry.route, render);
}
