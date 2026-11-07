import type {ScreenRegistration} from '../../../packages/primecare_ui/web/screen-manager';

const owners = new WeakMap<Document, PortalDocumentScroll>();

/** Document flow belongs to the portal entry, never to an embedded shell. */
export class PortalDocumentScroll {
  private readonly document: Document;
  private readonly view: Window | null;
  private route: string | null = null;
  private initialHost = false;
  private preservedUrl: string | null;
  private suspended = false;
  private disposed = false;

  constructor(private readonly root: HTMLElement) {
    this.document = root.ownerDocument;
    this.view = this.document.defaultView;
    this.preservedUrl = this.view?.location?.href ?? null;
    if (!this.ownsRoot() || !this.view?.location) { this.disposed = true; return; }
    const previous = owners.get(this.document);
    if (previous?.ownsRoot()) throw Error('Portal document scroll already has an owner');
    previous?.dispose();
    owners.set(this.document, this);
    this.view.addEventListener('popstate', this.preserve);
    this.view.addEventListener('hashchange', this.preserve);
    this.view.addEventListener('pagehide', this.hide);
    this.view.addEventListener('pageshow', this.show);
  }

  private ownsRoot(): boolean {
    return !this.disposed && this.root.isConnected === true &&
      this.root.ownerDocument === this.document && this.root.parentElement === this.document.body &&
      this.document.querySelector('#app') === this.root;
  }

  // Keep the URL protected until another accepted URL arrives. A timer would
  // expire before deferred history reconciliation or restored data loading.
  private preserve = (): void => { this.preservedUrl = this.view!.location.href; };
  private hide = (event: PageTransitionEvent): void => {
    if (!event.persisted) { this.dispose(); return; }
    this.suspended = true;
    this.preserve();
  };
  private show = (event: PageTransitionEvent): void => {
    if (!event.persisted) return;
    this.preserve();
    this.suspended = false;
  };

  routeChanged(screen: ScreenRegistration): void {
    if (!this.ownsRoot() || this.suspended || owners.get(this.document) !== this) return;
    const location = this.view!.location;
    // Pending work may still present the old route after browser history moved.
    if (screen.route !== location.pathname) return;
    const initial = this.route === null;
    const resolvingHost = this.initialHost && screen.kind === 'governed';
    const changed = !initial && this.route !== screen.route;
    const preserve = location.href === this.preservedUrl;
    // Same-path redraws and hashes retain their existing renderer/browser policy.
    if (changed && !resolvingHost && !preserve && !location.hash && !this.document.fullscreenElement) {
      this.view!.scrollTo({top: 0, left: 0, behavior: 'instant'});
    }
    // A rejected scroll must remain retryable at this same route boundary.
    this.route = screen.route;
    this.initialHost = (initial || this.initialHost) && screen.kind === 'workspace-host';
    if (!preserve) this.preservedUrl = null;
  }

  dispose(): void {
    if (this.disposed) return;
    this.disposed = true;
    this.view?.removeEventListener('popstate', this.preserve);
    this.view?.removeEventListener('hashchange', this.preserve);
    this.view?.removeEventListener('pagehide', this.hide);
    this.view?.removeEventListener('pageshow', this.show);
    if (owners.get(this.document) === this) owners.delete(this.document);
  }
}
