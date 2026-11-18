type DismissReason = 'discard' | 'escape';
type CloseReason = 'local' | 'history';
export type DashboardDialogOptions = Readonly<{
  className: string;
  headingSelector: string;
  closeSelector: string;
  statusKey: string;
  current: () => boolean;
  revision: () => number;
  canDismiss: (dialog: HTMLDialogElement, reason: DismissReason) => boolean;
  onClosed?: (dialog: HTMLDialogElement, reason: CloseReason) => void;
}>;

let titleSequence = 0;

/** Owns presentation only. Data, drafts policy and route history belong to the registered dashboard. */
export class DashboardDialogManager {
  private readonly dialogs = new Map<HTMLDialogElement, {opener: HTMLElement | null; revision: number; dirty: () => boolean}>();
  private disposed = false;

  constructor(
    private readonly root: HTMLElement,
    private readonly options: DashboardDialogOptions,
    private readonly onDisposed: () => void,
  ) {}

  get size(): number { return this.dialogs.size; }
  has(dialog: HTMLDialogElement): boolean { return this.dialogs.has(dialog); }
  hasOpen(): boolean { return [...this.dialogs.keys()].some(dialog => dialog.open); }
  isDirty(dialog: HTMLDialogElement): boolean { return this.dialogs.get(dialog)?.dirty() ?? false; }
  hasOpenDraft(): boolean { return [...this.dialogs.keys()].some(dialog => dialog.open && this.isDirty(dialog)); }

  /** Only pass markup from the dashboard's registered, escaping view renderer. */
  open(html: string, opener?: HTMLElement): HTMLDialogElement {
    if (!this.current()) throw new Error('Inactive dashboard dialog owner');
    if (this.dialogs.size) throw new Error('Dashboard already has an open dialog');
    const revision = this.options.revision();
    if (!this.current() || this.dialogs.size) throw new Error('Inactive dashboard dialog owner');
    const doc = this.root.ownerDocument;
    const dialog = doc.createElement('dialog');
    dialog.className = this.options.className;
    const origin = opener ?? doc.activeElement;
    const HTMLElementType = doc.defaultView?.HTMLElement;
    this.dialogs.set(dialog, {opener: HTMLElementType && origin instanceof HTMLElementType ? origin : null, revision, dirty: () => false});
    try {
      this.replaceContent(dialog, html);
      dialog.addEventListener('cancel', event => { event.preventDefault(); this.dismiss(dialog, 'escape'); });
      dialog.addEventListener('close', () => this.close(dialog));
      doc.body.append(dialog);
      dialog.showModal();
      if (!this.current() || !this.has(dialog) || !dialog.open) throw new Error('Dashboard dialog owner changed during open');
      dialog.querySelector<HTMLElement>(this.options.headingSelector)?.focus();
      if (!this.current() || !this.has(dialog) || !dialog.open) throw new Error('Dashboard dialog owner changed during open');
      return dialog;
    } catch (error) {
      this.dialogs.delete(dialog);
      if (dialog.open) dialog.close();
      dialog.remove();
      throw error;
    }
  }

  replaceContent(dialog: HTMLDialogElement, html: string): void {
    const state = this.dialogs.get(dialog);
    if (!state || !this.current()) throw new Error('Unmanaged dashboard dialog');
    const template = this.root.ownerDocument.createElement('template');
    template.innerHTML = html;
    const heading = template.content.querySelector<HTMLElement>(this.options.headingSelector);
    const close = template.content.querySelector(this.options.closeSelector);
    if (!heading?.textContent?.trim() || close?.tagName !== 'BUTTON' || close.hasAttribute('disabled'))
      throw new Error('Dashboard dialog requires a named heading and enabled close button');
    if (template.content.querySelector('form[method="dialog" i],[formmethod="dialog" i]'))
      throw new Error('Dashboard dialogs must close through their managed controls');
    close.setAttribute('type','button');
    heading.id = 'primecare-dashboard-dialog-title-' + (++titleSequence);
    heading.tabIndex = -1;
    heading.setAttribute('autofocus', '');
    const fields = [...template.content.querySelectorAll<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>('input,select,textarea')];
    const value = (field: typeof fields[number]) =>
      field.tagName === 'INPUT' && ['checkbox', 'radio'].includes((field as HTMLInputElement).type)
        ? (field as HTMLInputElement).checked
        : field.tagName === 'SELECT' && (field as HTMLSelectElement).multiple
          ? JSON.stringify([...((field as HTMLSelectElement).selectedOptions)].map(option=>option.index))
          : field.value;
    const initial = fields.map(value);
    state.dirty = () => fields.some((field, index) => value(field) !== initial[index]);
    close.addEventListener('click', event => {
      event.preventDefault();
      if (dialog.contains(close)) this.dismiss(dialog, 'discard');
    });
    dialog.replaceChildren(template.content);
    dialog.setAttribute('aria-labelledby', heading.id);
    if (dialog.open) heading.focus();
  }

  status(dialog: HTMLDialogElement, message: string): void {
    if (!this.has(dialog)) return;
    let node = [...dialog.querySelectorAll<HTMLElement>('[data-cy]')].find(element => element.dataset.cy === this.options.statusKey);
    if (!node) {
      node = this.root.ownerDocument.createElement('p');
      node.dataset.cy = this.options.statusKey;
      node.setAttribute('role', 'alert');
      dialog.append(node);
    }
    node.textContent = message;
  }

  private current(): boolean {
    return !this.disposed && this.root.isConnected && this.options.current() && !this.disposed && this.root.isConnected;
  }

  private dismiss(dialog: HTMLDialogElement, reason: DismissReason): void {
    if (dialog.open && this.has(dialog) && this.current() && this.options.canDismiss(dialog, reason)
      && this.current() && this.has(dialog) && dialog.open) this.close(dialog);
  }

  close(dialog: HTMLDialogElement, reason: CloseReason = 'local'): void {
    const state = this.dialogs.get(dialog);
    if (!state) return;
    this.dialogs.delete(dialog);
    if (dialog.open) dialog.close();
    dialog.remove();
    if (this.current()) this.options.onClosed?.(dialog, reason);
    if (!this.dialogs.size && this.current() && state.revision === this.options.revision() && this.current() && state.opener?.isConnected) state.opener.focus();
  }

  dispose(): void {
    if (this.disposed) return;
    this.disposed = true;
    const dialogs = [...this.dialogs.keys()];
    this.dialogs.clear();
    try {
      this.onDisposed();
    } finally {
      for (const dialog of dialogs) {
        if (dialog.open) dialog.close();
        dialog.remove();
      }
    }
  }
}
