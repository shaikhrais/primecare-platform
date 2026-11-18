import {withMasterDashboardShell} from './dashboard-render-policy';
import {bindShell,renderShell,shellMarkup,type ShellContent} from './shell';
import {ScreenConfigurationError,type ScreenManager,type ScreenRegistration} from './screen-manager';
import {clearLayoutCustomizer} from './layout-customizer';
import type {DashboardDialogOptions} from './dashboard-dialog-manager';

type View = Readonly<{id: string; label: string}>;
export type MasterDashboardConfig = Readonly<{
  screenCode: string;
  route: string;
  title: string;
  views: readonly View[];
}>;
type Binding = Readonly<{
  locale: Parameters<typeof bindShell>[2];
  profileScope: string;
  allowedViews: unknown;
  view: string;
  shell: ShellContent;
  panels?: Readonly<Record<string,string>>;
  current: () => boolean;
  select: (id: string) => void;
}>;

/** Configuration and projected view identifiers are validated, never used as an access grant. */
export function dashboardViews(descriptor: MasterDashboardConfig, projected: unknown): readonly View[] {
  if (!descriptor.title.trim() || !descriptor.screenCode.trim() || !descriptor.route.startsWith('/') || !Array.isArray(projected) || !projected.length)
    throw new ScreenConfigurationError('Invalid dashboard configuration or view projection');
  const declared = new Map<string, View>();
  for (const view of descriptor.views) {
    if (!/^[a-z0-9][a-z0-9_-]*$/.test(view.id) || !view.label.trim() || declared.has(view.id))
      throw new ScreenConfigurationError('Invalid or duplicate dashboard view');
    declared.set(view.id, view);
  }
  const allowed = new Set(projected);
  if (allowed.size !== projected.length || projected.some(id => typeof id !== 'string' || !declared.has(id)))
    throw new ScreenConfigurationError('Dashboard view projection does not match registration');
  return [...declared.values()].filter(view => allowed.has(view.id));
}

/** Inherit the presentation contract; domain workflows and transport stay in the caller. */
export abstract class MasterDashboard {
  readonly dialogs: ReturnType<ScreenManager['connectDashboardDialogs']>;
  private readonly descriptor: MasterDashboardConfig;
  private revision = 0;
  private shell: Element | undefined;
  private bound: (() => boolean) | undefined;

  protected constructor(
    private readonly root: HTMLElement,
    private readonly manager: ScreenManager,
    entry: Pick<ScreenRegistration,'id'|'route'>,
    descriptor: MasterDashboardConfig,
    panelOptions: DashboardDialogOptions,
  ) {
    if (entry.route !== descriptor.route) throw new ScreenConfigurationError('Master dashboard route does not match registration');
    dashboardViews(descriptor, descriptor.views.map(view => view.id));
    this.descriptor = Object.freeze({...descriptor,views:Object.freeze(descriptor.views.map(view=>Object.freeze({...view})))});
    this.dialogs = manager.connectDashboardDialogs(root,entry.id,entry.route,panelOptions,()=>this.retire());
  }

  allowedViews(projection: unknown): readonly View[] {
    return dashboardViews(this.descriptor,projection);
  }

  mount(binding: Binding): Element {
    const {root,descriptor} = this;
    const lease = () => this.manager.ownsDashboardDialogs(root,this.dialogs);
    const views = this.allowedViews(binding.allowedViews);
    if (!views.some(({id})=>id===binding.view) || !lease() || !binding.current() || !lease())
      throw new ScreenConfigurationError('Inactive or unavailable dashboard view');

    // Check declared slots in detached markup before replacing any existing content.
    const selectors = Object.entries(binding.panels ?? {});
    const resolvePanels = (container: ParentNode): Record<string,HTMLElement> => Object.fromEntries(selectors.map(([id,selector])=>{
      const nodes = container.querySelectorAll<HTMLElement>(selector);
      if (nodes.length !== 1) throw new ScreenConfigurationError('Dashboard panel slot must resolve exactly once: '+id);
      return [id,nodes[0]];
    }));
    if (selectors.length) {
      const draft = root.ownerDocument.createElement('template');
      draft.innerHTML = shellMarkup(binding.shell);
      resolvePanels(draft.content);
    }

    const revision = ++this.revision;
    let installed = false;
    const current = () => lease() && revision === this.revision && (!installed || binding.current()) && lease() && revision === this.revision;
    try {
      withMasterDashboardShell(root,lease,()=>renderShell(root,binding.shell));
      if (!lease() || revision !== this.revision) throw new ScreenConfigurationError('Dashboard owner changed during mount');
      const shell = root.querySelector('[data-cy=app-shell]');
      if (!shell) throw new ScreenConfigurationError('Master dashboard shell failed to mount');
      const workspace = binding.panels === undefined ? undefined : {screenCode:descriptor.screenCode,panels:resolvePanels(shell)};
      bindShell(root,descriptor.title,binding.locale,descriptor.route.slice(1),
        () => views.map(view => ({title:view.label,detail:descriptor.title,open:()=>{if(installed&&current())binding.select(view.id);}})),
        binding.profileScope,{},workspace,current);
      if (!lease() || revision !== this.revision) throw new ScreenConfigurationError('Dashboard owner changed during mount');
      this.shell = shell;
      this.bound = current;
      installed = true;
      return shell;
    } catch (error) {
      if (lease() && revision === this.revision) {
        clearLayoutCustomizer(root);
        if (lease() && revision === this.revision) root.replaceChildren();
      }
      throw error;
    }
  }

  private retire(): void {
    ++this.revision;
    try {
      if (this.bound) clearLayoutCustomizer(this.root,this.bound);
    } finally {
      this.shell?.remove();
      this.shell = undefined;
      this.bound = undefined;
    }
  }

  dispose(): void {
    this.dialogs.dispose();
  }
}
