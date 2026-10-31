import {defaultWorkspaceLayout, parseWorkspaceLayout, validateWorkspaceLayout, type WorkspaceLayout, type PanelDock} from '../../domain/src/workspace_layout';
import {workspaceLayoutStyles} from './workspace-layout-styles';
export {defaultWorkspaceLayout};
export type {WorkspaceLayout, PanelDock};
export type WorkspaceSlots = {navigation: HTMLElement; toolbar: HTMLElement; main: HTMLElement; footer?: HTMLElement; panels: Record<string, HTMLElement>};
type StoragePort = Pick<Storage, 'getItem' | 'setItem'>;
/** Optional shared presentation engine. Callers supply already-authorized DOM slots.
 * Does not create routes, business widgets, permissions, or production editor controls.
 */
export class WorkspaceLayoutManager {
  private profile: WorkspaceLayout;
  private undoStack: WorkspaceLayout[] = [];
  private redoStack: WorkspaceLayout[] = [];
  private ids: string[];
  private stage: HTMLElement;
  private docks = new Map<string, HTMLElement>();
  private originals: {element: HTMLElement; parent: Node; next: Node | null; attributes: [string,string][]}[];
  private rootAttributes: [string,string][];
  private win: Window;
  private abort = new AbortController();
  private observer: ResizeObserver;
  private disposed = false;
  private gesture: {id:string; x:number; y:number; width:number; height:number; startX:number; startY:number; resize:boolean; before:WorkspaceLayout; pointer:number} | null = null;
  constructor(private root: HTMLElement, private slots: WorkspaceSlots, private storageKey: string, private storage: StoragePort = {getItem: key => root.ownerDocument.defaultView!.localStorage.getItem(key), setItem: (key,value) => root.ownerDocument.defaultView!.localStorage.setItem(key,value)}) {
    this.ids = Object.keys(slots.panels);
    this.profile = defaultWorkspaceLayout(this.ids);
    if (!storageKey.trim()) throw Error('An account-and-role-scoped storage key is required');
    const elements = [slots.navigation, slots.toolbar, slots.main, ...(slots.footer ? [slots.footer] : []), ...Object.values(slots.panels)];
    if (new Set(elements).size !== elements.length || elements.some(el => !root.contains(el) || elements.some(other => other !== el && other.contains(el)))) throw Error('Slots must be distinct, non-nested descendants');
    if (root.hasAttribute('data-pc-workspace')) throw Error('Workspace is already managed');
    this.win = root.ownerDocument.defaultView!;
    this.rootAttributes = [...root.attributes].map(a => [a.name,a.value]);
    this.originals = elements.map(element => ({element, parent: element.parentNode!, next: element.nextSibling, attributes: [...element.attributes].map(a => [a.name,a.value])}));
    try { const text = storage.getItem(storageKey); if (text) this.profile = parseWorkspaceLayout(text, this.ids); } catch { /* Invalid or inaccessible preferences keep safe defaults. */ }
    const doc = root.ownerDocument;
    if (!doc.querySelector('[data-primecare-workspace-styles]')) {const style = doc.createElement('style'); style.dataset.primecareWorkspaceStyles = ''; style.textContent = workspaceLayoutStyles; doc.head.append(style);}
    this.stage = doc.createElement('div'); this.stage.dataset.pcStage = '';
    for (const dock of ['left','right','top','bottom']) {const host = doc.createElement('div'); host.dataset.pcDock = dock; this.docks.set(dock, host); this.stage.append(host);}
    slots.navigation.dataset.pcSlot = 'nav'; slots.toolbar.dataset.pcSlot = 'toolbar'; slots.main.dataset.pcSlot = 'main';
    this.stage.append(slots.main); root.append(slots.navigation, slots.toolbar, this.stage);
    if (slots.footer) {slots.footer.dataset.pcSlot = 'footer'; root.append(slots.footer);}
    for (const [id,panel] of Object.entries(slots.panels)) panel.dataset.pcPanel = id;
    const signal = this.abort.signal;
    root.addEventListener('pointerdown', this.pointerDown, {signal});
    this.win.addEventListener('pointermove', this.pointerMove, {signal});
    this.win.addEventListener('pointerup', this.pointerEnd, {signal});
    this.win.addEventListener('pointercancel', this.pointerCancel, {signal});
    this.win.addEventListener('blur', this.pointerCancel, {signal});
    root.addEventListener('keydown', this.keyDown, {signal});
    this.win.addEventListener('resize', this.apply, {signal});
    this.observer = new ResizeObserver(this.apply); this.observer.observe(root); this.observer.observe(slots.toolbar);
    this.apply();
  }
  get current(): WorkspaceLayout { return structuredClone(this.profile); }
  get canUndo(): boolean { return this.undoStack.length > 0; }
  get canRedo(): boolean { return this.redoStack.length > 0; }
  change(value: unknown): void {
    if (this.disposed) throw Error('Workspace disposed');
    const next = validateWorkspaceLayout(value, this.ids);
    if (JSON.stringify(next) === JSON.stringify(this.profile)) return;
    this.remember(this.current); this.profile = next; this.apply();
  }
  private remember(before: WorkspaceLayout): void {this.undoStack.push(before); if (this.undoStack.length > 30) this.undoStack.shift(); this.redoStack = [];}
  undo(): void {const p = this.undoStack.pop(); if (p) {this.redoStack.push(this.current); this.profile = p; this.apply();}}
  redo(): void {const p = this.redoStack.pop(); if (p) {this.undoStack.push(this.current); this.profile = p; this.apply();}}
  reset(): void {this.change(defaultWorkspaceLayout(this.ids));}
  dockPanel(id: string, dock: PanelDock): void {
    if (!Object.hasOwn(this.profile.panels, id)) throw Error('Panel is not permitted');
    this.change({...this.current, panels: {...this.current.panels, [id]: {...this.profile.panels[id], dock}}});
  }
  exportJson(): string {return JSON.stringify(this.profile, null, 2);}
  importJson(text: string): void {this.change(parseWorkspaceLayout(text, this.ids));}
  save(): void {this.storage.setItem(this.storageKey, this.exportJson());}
  private place(element: HTMLElement, parent: HTMLElement): void {if (element.parentElement !== parent) parent.append(element);}
  private apply = (): void => {
    if (this.disposed) return;
    const focused = this.root.ownerDocument.activeElement as HTMLElement | null;
    const restoreFocus = !!focused && this.root.contains(focused);
    const p = this.profile, root = this.root, width = Math.min(this.win.innerWidth, root.getBoundingClientRect().width || this.win.innerWidth);
    const narrow = width < 900;
    root.dataset.pcWorkspace = ''; root.dataset.narrow = String(narrow);
    for (const key of ['navigation','toolbar','toolbarStyle','footer','container','scroll'] as const) root.dataset[key] = p[key];
    root.style.setProperty('--pc-nav-width', p.navigationWidth + 'px'); root.style.setProperty('--pc-max-width', p.maxWidth + 'px');
    root.style.setProperty('--pc-footer-offset', p.toolbar === 'bottom' && p.toolbarStyle === 'sticky' ? this.slots.toolbar.getBoundingClientRect().height + 'px' : '0px');
    const before = p.toolbar === 'top' ? ['toolbar'] : [], after = p.toolbar === 'bottom' ? ['toolbar'] : [];
    let rows = [...before, ...(p.navigation === 'top' ? ['nav'] : []), 'stage', ...(p.navigation === 'bottom' ? ['nav'] : []), 'footer', ...after];
    const vertical = p.navigation === 'left' || p.navigation === 'right';
    root.style.gridTemplateColumns = vertical ? (p.navigation === 'left' ? 'var(--pc-nav-width) minmax(0,1fr)' : 'minmax(0,1fr) var(--pc-nav-width)') : 'minmax(0,1fr)';
    root.style.gridTemplateAreas = rows.map(row => '"' + (vertical ? (p.navigation === 'left' ? 'nav ' + row : row + ' nav') : row) + '"').join(' ');
    root.style.gridTemplateRows = rows.map(row => row === 'stage' ? 'minmax(0,1fr)' : 'auto').join(' ');
    const ordered = [...(p.toolbar === 'top' ? [this.slots.toolbar] : []), ...(p.navigation === 'top' || vertical ? [this.slots.navigation] : []), this.stage, ...(p.navigation === 'bottom' ? [this.slots.navigation] : []), ...(this.slots.footer ? [this.slots.footer] : []), ...(p.toolbar === 'bottom' ? [this.slots.toolbar] : []), ...(p.navigation === 'hidden' ? [this.slots.navigation] : [])];
    // CSS positions desktop slots; DOM order follows visual order for keyboard/mobile users.
    for (let i = 0; i < ordered.length; i++) if (root.children[i] !== ordered[i]) root.insertBefore(ordered[i], root.children[i] ?? null);
    const nav = this.slots.navigation; nav.style.height = vertical && !narrow ? (p.scroll === 'content' ? '100%' : '100dvh') : 'auto';
    if (!vertical) {nav.style.setProperty('position','static','important'); nav.style.maxHeight = '35dvh';} else {nav.style.removeProperty('position'); nav.style.removeProperty('max-height');}
    for (const [id, panel] of Object.entries(this.slots.panels)) {
      const layout = p.panels[id];
      panel.hidden = layout.dock === 'hidden' || this.originals.find(item => item.element === panel)!.attributes.some(([name]) => name === 'hidden');
      panel.dataset.panelDock = layout.dock;
      const dockBudget = vertical ? width - p.navigationWidth : width;
      const sidePanelCount = Object.values(p.panels).filter(panel => panel.dock === 'left' || panel.dock === 'right').length;
      const sideWidth = Math.max(180, Math.floor((dockBudget - 280) / Math.min(2, Math.max(1, sidePanelCount))));
      const panelWidth = Math.min(layout.width, Math.max(180, width - 16), ['left','right'].includes(layout.dock) && !narrow ? sideWidth : 1200);
      const panelHeight = Math.min(layout.height, Math.max(120, this.win.innerHeight - 16));
      panel.style.setProperty('--pc-panel-width', panelWidth + 'px'); panel.style.setProperty('--pc-panel-height', panelHeight + 'px');
      panel.style.setProperty('--pc-panel-x', Math.min(layout.x, Math.max(0, this.win.innerWidth - panelWidth - 8)) + 'px');
      panel.style.setProperty('--pc-panel-y', Math.min(layout.y, Math.max(0, this.win.innerHeight - panelHeight - 8)) + 'px');
      this.place(panel, this.docks.get(layout.dock) ?? this.stage);
    }
    if (restoreFocus && focused?.isConnected && !focused.closest('[hidden]') && this.root.ownerDocument.activeElement !== focused) focused.focus({preventScroll:true});
    root.dispatchEvent(new CustomEvent('primecare:workspace-layout', {detail: this.current}));
  };
  private target(event: Event): {id:string; resize:boolean} | null {
    const el = event.target as Element | null; const handle = el?.closest('[data-layout-drag],[data-layout-resize]');
    const panel = handle?.closest<HTMLElement>('[data-pc-panel]'); const id = panel?.dataset.pcPanel;
    return id && this.slots.panels[id] === panel && handle && this.root.contains(handle) ? {id, resize: handle.hasAttribute('data-layout-resize')} : null;
  }
  private pointerDown = (event: PointerEvent): void => {
    const target = this.target(event); if (!target || event.button !== 0 || this.root.dataset.narrow === 'true') return;
    const box = this.slots.panels[target.id].getBoundingClientRect(), p = this.profile.panels[target.id];
    this.gesture = {id:target.id, x:Math.round(box.x), y:Math.round(box.y), width:p.width, height:p.height, startX:event.clientX, startY:event.clientY, resize:target.resize, before:this.current, pointer:event.pointerId};
    event.preventDefault(); (event.target as HTMLElement).focus();
  };
  private pointerMove = (event: PointerEvent): void => {
    const g = this.gesture; if (!g || g.pointer !== event.pointerId) return;
    const dx = Math.round(event.clientX - g.startX), dy = Math.round(event.clientY - g.startY);
    if (!dx && !dy) return;
    const panel = this.profile.panels[g.id];
    this.profile = validateWorkspaceLayout({...this.current, panels:{...this.current.panels, [g.id]:{...panel, ...(g.resize ? {width:Math.max(180,Math.min(1200,g.width+dx)),height:Math.max(120,Math.min(1200,g.height+dy))} : {dock:'floating', x:Math.max(0,Math.min(10000,g.x+dx)), y:Math.max(0,Math.min(10000,g.y+dy))})}}},this.ids);
    this.apply();
  };
  private pointerEnd = (event: PointerEvent): void => {
    const g = this.gesture; if (!g || g.pointer !== event.pointerId) return;
    this.gesture = null; if (JSON.stringify(g.before) !== JSON.stringify(this.profile)) this.remember(g.before);
  };
  private pointerCancel = (): void => {if (this.gesture) {this.profile = this.gesture.before; this.gesture = null; this.apply();}};
  private keyDown = (event: KeyboardEvent): void => {
    if (event.key === 'Escape' && this.gesture) {event.preventDefault(); this.pointerCancel(); return;}
    const target = this.target(event), directions: Record<string,[number,number,PanelDock]> = {ArrowLeft:[-16,0,'left'],ArrowRight:[16,0,'right'],ArrowUp:[0,-16,'top'],ArrowDown:[0,16,'bottom']};
    const d = directions[event.key]; if (!target || !d || this.root.dataset.narrow === 'true') return;
    event.preventDefault(); if (event.ctrlKey || event.metaKey) {this.dockPanel(target.id, d[2]); return;}
    const p = this.profile.panels[target.id], box = this.slots.panels[target.id].getBoundingClientRect();
    const resize = target.resize || event.shiftKey;
    this.change({...this.current, panels:{...this.current.panels,[target.id]:{...p,...(resize ? {width:Math.min(1200,Math.max(180,p.width+d[0])),height:Math.min(1200,Math.max(120,p.height+d[1]))} : {dock:'floating',x:Math.max(0,Math.min(10000,Math.round(box.x)+d[0])),y:Math.max(0,Math.min(10000,Math.round(box.y)+d[1]))})}}});
  };
  dispose(): void {
    if (this.disposed) return; this.disposed = true; this.abort.abort(); this.observer.disconnect();
    // Restore following siblings first, preserving original DOM order and all live nodes.
    for (const item of [...this.originals].reverse()) {item.parent.insertBefore(item.element,item.next?.parentNode === item.parent ? item.next : null); for (const a of [...item.element.attributes]) item.element.removeAttribute(a.name); for (const [k,v] of item.attributes) item.element.setAttribute(k,v);}
    this.stage.remove(); for (const a of [...this.root.attributes]) this.root.removeAttribute(a.name); for (const [k,v] of this.rootAttributes) this.root.setAttribute(k,v);
  }
}
