const idPattern = /^[a-z][a-z0-9_-]*$/;

/** Composition metadata only; it never grants business authority or discovers URLs. */
export class PackageCatalog {
  #entries;
  constructor(entries) {
    this.#entries = new Map();
    for (const entry of entries) {
      if (!idPattern.test(entry.id) || this.#entries.has(entry.id) ||
          !Number.isSafeInteger(entry.contractVersion) || entry.contractVersion < 1 ||
          !['library', 'ui', 'service', 'source'].includes(entry.kind) ||
          !Array.isArray(entry.dependencies) ||
          entry.dependencies.some(id => typeof id !== 'string') ||
          new Set(entry.dependencies).size !== entry.dependencies.length) {
        throw new Error('Invalid or duplicate package descriptor');
      }
      this.#entries.set(entry.id, Object.freeze({
        ...entry, dependencies: Object.freeze([...entry.dependencies]),
      }));
    }
    this.order(); // Validate the complete graph, including disconnected components.
  }
  get(id) {
    const entry = this.#entries.get(id);
    if (!entry) throw new Error(`Unknown package: ${id}`);
    return entry;
  }
  /** Return changed packages and every declared transitive consumer, in build order. */
  impact(changedIds) {
    const affected = new Set(changedIds);
    for (const id of affected) this.get(id);
    const order = this.order();
    for (const id of order) {
      if (this.get(id).dependencies.some(dep => affected.has(dep))) affected.add(id);
    }
    return Object.freeze(order.filter(id => affected.has(id)));
  }
  order() {
    const done = new Set(), active = new Set(), result = [];
    const visit = id => {
      if (active.has(id)) throw new Error(`Package dependency cycle: ${id}`);
      if (done.has(id)) return;
      active.add(id);
      for (const dependency of [...this.get(id).dependencies].sort()) visit(dependency);
      active.delete(id); done.add(id); result.push(id);
    };
    for (const id of [...this.#entries.keys()].sort()) visit(id);
    return Object.freeze(result);
  }
}

export function remoteBinding(endpoint, contractVersion) {
  const url = new URL(endpoint);
  if (url.protocol !== 'https:' || url.username || url.password || url.href.includes('?') || url.href.includes('#')) {
    throw new Error('Remote endpoint requires HTTPS without credentials, query or fragment');
  }
  if (!Number.isSafeInteger(contractVersion) || contractVersion < 1) {
    throw new Error('Invalid remote contract version');
  }
  return Object.freeze({endpoint: url.href, contractVersion});
}

/** One immutable host configuration. Create a new registry to change placement. */
export class PackageMaster {
  #catalog; #bindings; #providers = new Map(); #instances = new Map(); #active = new Set();
  constructor(catalog, bindings = {}) {
    this.#catalog = catalog;
    this.#bindings = new Map();
    for (const [id, input] of Object.entries(bindings)) {
      const entry = catalog.get(id);
      const binding = remoteBinding(input.endpoint, input.contractVersion);
      if (entry.kind !== 'service' || entry.contractVersion !== binding.contractVersion) {
        throw new Error(`Remote binding is not compatible: ${id}`);
      }
      this.#bindings.set(id, binding);
    }
  }
  register(id, {contractVersion, local, remote}) {
    const entry = this.#catalog.get(id);
    if (this.#providers.has(id) || entry.contractVersion !== contractVersion ||
        typeof local !== 'function' || (remote !== undefined && typeof remote !== 'function')) {
      throw new Error(`Invalid, duplicate or incompatible provider: ${id}`);
    }
    this.#providers.set(id, Object.freeze({local, remote}));
    return this;
  }
  /** Composition status only; not a deployment or health check. No adapter is invoked. */
  status() {
    return Object.freeze(this.#catalog.order().map(id => Object.freeze({
      id, kind: this.#catalog.get(id).kind,
      contractVersion: this.#catalog.get(id).contractVersion,
      placement: this.#bindings.has(id) ? 'remote' : 'local',
      state: this.#instances.has(id) ? 'resolved' :
        !this.#providers.has(id) ? 'unregistered' :
        this.#bindings.has(id) && !this.#providers.get(id).remote ? 'adapter_missing' : 'registered',
    })));
  }
  resolve(id) {
    this.#catalog.get(id);
    if (this.#instances.has(id)) return this.#instances.get(id);
    if (this.#active.has(id)) throw new Error(`Provider resolution cycle: ${id}`);
    const provider = this.#providers.get(id);
    if (!provider) throw new Error(`Package has no registered provider: ${id}`);
    const binding = this.#bindings.get(id);
    if (binding && !provider.remote) throw new Error(`Remote adapter unavailable: ${id}`);
    this.#active.add(id);
    try {
      const instance = binding ? provider.remote(binding) : provider.local();
      if (instance === null || typeof instance !== 'object' || typeof instance.then === 'function') {
        throw new Error(`Provider must return a synchronous adapter object: ${id}`);
      }
      this.#instances.set(id, instance);
      return instance;
    } finally { this.#active.delete(id); }
  }
}
