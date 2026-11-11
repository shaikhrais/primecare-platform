import palette from '../../packages/shared/src/solid-theme.json';
import catalog from '../../packages/shared/src/tenant-dashboard/catalog.json';

/** Test presentation tokens only; supplies no identity, route grants or business data. */
export const tenantPresentationTheme = Object.freeze({...palette, ...catalog.previewTheme});
