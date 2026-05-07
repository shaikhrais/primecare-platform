import type { ViewId } from './ControlCenter';

export type ViewBuilder = () => HTMLElement;

class ViewRegistry {
  private registry: Map<ViewId, ViewBuilder> = new Map();

  public register(id: ViewId, builder: ViewBuilder) {
    this.registry.set(id, builder);
  }

  public get(id: ViewId): ViewBuilder | undefined {
    return this.registry.get(id);
  }

  public has(id: ViewId): boolean {
    return this.registry.has(id);
  }
}

export const viewRegistry = new ViewRegistry();
