export type PackageKind = 'library' | 'ui' | 'service' | 'source';
export interface PackageDescriptor {
  readonly id: string;
  readonly kind: PackageKind;
  /** Composition adapter contract version, not the business API's version. */
  readonly contractVersion: number;
  readonly dependencies: readonly string[];
}
export interface RemoteBinding {
  readonly endpoint: string;
  readonly contractVersion: number;
}
export class PackageCatalog {
  constructor(entries: Iterable<PackageDescriptor>);
  get(id: string): Readonly<PackageDescriptor>;
  impact(changedIds: Iterable<string>): readonly string[];
  order(): readonly string[];
}
export function remoteBinding(endpoint: string, contractVersion: number): RemoteBinding;
export class PackageMaster {
  constructor(catalog: PackageCatalog, bindings?: Readonly<Record<string, RemoteBinding>>);
  register<T extends object>(id: string, provider: {
    contractVersion: number;
    local: () => T;
    remote?: (binding: RemoteBinding) => T;
  }): this;
  status(): readonly Readonly<{
    id: string; kind: PackageKind; contractVersion: number;
    placement: 'local' | 'remote';
    state: 'resolved' | 'unregistered' | 'adapter_missing' | 'registered';
  }>[];
  resolve<T extends object>(id: string): T;
}
