/**
 * Domain Sub-App Barrel Export
 *
 * Each export is an independent Hono sub-app with its own route tree.
 * Import these in admin.module.ts for federated module composition.
 */
export { default as coreApp } from './core.app';
export { default as clinicalApp } from './clinical.app';
export { default as financeApp } from './finance.app';
export { default as opsApp } from './ops.app';
export { default as contentApp } from './content.app';
export { default as infraApp } from './infra.app';
