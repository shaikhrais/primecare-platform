/** Original, data-only layout contract. Panel IDs come from the caller's permitted registry. */
export const panelDocks = ['left', 'right', 'top', 'bottom', 'floating', 'hidden'] as const;
export type PanelDock = typeof panelDocks[number];
export type PanelLayout = {dock: PanelDock; x: number; y: number; width: number; height: number};
export type WorkspaceLayout = {
  version: 1;
  navigation: 'left' | 'right' | 'top' | 'bottom' | 'hidden';
  navigationWidth: number;
  toolbar: 'top' | 'bottom';
  toolbarStyle: 'sticky' | 'static';
  footer: 'sticky' | 'static' | 'hidden';
  container: 'fullwidth' | 'boxed' | 'content';
  maxWidth: number;
  scroll: 'page' | 'content';
  panels: Record<string, PanelLayout>;
};
const record = (value: unknown): Record<string, unknown> => {
  if (!value || typeof value !== 'object' || Array.isArray(value)) throw Error('Expected layout object');
  return value as Record<string, unknown>;
};
const keys = (value: Record<string, unknown>, expected: string[]) => {
  if (Object.keys(value).length !== expected.length || expected.some(k => !Object.hasOwn(value, k))) throw Error('Unknown or missing layout field');
};
const integer = (value: unknown, min: number, max: number) => {
  if (typeof value !== 'number' || !Number.isInteger(value) || value < min || value > max) throw Error('Invalid layout dimension');
  return value;
};
const choice = <T extends string>(value: unknown, allowed: readonly T[]): T => {
  if (typeof value !== 'string' || !allowed.includes(value as T)) throw Error('Invalid layout choice');
  return value as T;
};
export function defaultWorkspaceLayout(panelIds: readonly string[] = []): WorkspaceLayout {
  return validateWorkspaceLayout({version: 1, navigation: 'left', navigationWidth: 248, toolbar: 'top', toolbarStyle: 'sticky', footer: 'static', container: 'fullwidth', maxWidth: 1280, scroll: 'page', panels: Object.fromEntries(panelIds.map(id => [id, {dock: 'right', x: 32, y: 96, width: 320, height: 360}]))}, panelIds);
}
export function validateWorkspaceLayout(value: unknown, panelIds: readonly string[]): WorkspaceLayout {
  if (new Set(panelIds).size !== panelIds.length || panelIds.some(id => !/^[a-z][a-z0-9-]{0,63}$/.test(id) || ['constructor', 'prototype'].includes(id))) throw Error('Invalid permitted panel registry');
  const v = record(value);
  keys(v, ['version', 'navigation', 'navigationWidth', 'toolbar', 'toolbarStyle', 'footer', 'container', 'maxWidth', 'scroll', 'panels']);
  if (v.version !== 1) throw Error('Unsupported workspace layout version');
  const rawPanels = record(v.panels); keys(rawPanels, [...panelIds]);
  const panels = Object.fromEntries(panelIds.map(id => {
    const p = record(rawPanels[id]); keys(p, ['dock', 'x', 'y', 'width', 'height']);
    return [id, {dock: choice(p.dock, panelDocks), x: integer(p.x, 0, 10000), y: integer(p.y, 0, 10000), width: integer(p.width, 180, 1200), height: integer(p.height, 120, 1200)}];
  }));
  return {version: 1, navigation: choice(v.navigation, ['left', 'right', 'top', 'bottom', 'hidden']), navigationWidth: integer(v.navigationWidth, 160, 400), toolbar: choice(v.toolbar, ['top', 'bottom']), toolbarStyle: choice(v.toolbarStyle, ['sticky', 'static']), footer: choice(v.footer, ['sticky', 'static', 'hidden']), container: choice(v.container, ['fullwidth', 'boxed', 'content']), maxWidth: integer(v.maxWidth, 960, 1920), scroll: choice(v.scroll, ['page', 'content']), panels};
}
export function parseWorkspaceLayout(text: string, panelIds: readonly string[]): WorkspaceLayout {
  if (typeof text !== 'string' || new TextEncoder().encode(text).length > 32768) throw Error('Layout file too large');
  return validateWorkspaceLayout(JSON.parse(text), panelIds);
}
