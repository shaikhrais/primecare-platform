# Shared communication inheritance

The user requires one reusable core for all permitted users and portals.

- New server channels extend CommunicationChannelBase and delegate to the scoped services; never copy authorization or channel business logic into a UI or a role-specific implementation.
- Server services extend ScopedServiceBase. Browser media resources and binary adapters inherit CommunicationResourceBase and BoundedBinaryAdapterBase respectively. Dart channel clients extend CommunicationChannelClient.
- Composition roots compose derived channels; storage and transport adapters implement their ports. Do not force unrelated provider classes into a meaningless inheritance tree.
- Keep current identity and permissions in authenticated server context. Never add a permissive runtime policy or allow request actor/tenant/role overrides.
- Preserve existing API behavior and compatibility exports. Keep inbound email ingestion separate from ordinary user channel dispatch.
- Update README.md and run the corresponding service, adapter, native PostgreSQL, browser and Dart checks when changing a contract.
- Existing parent governance and release gates still apply. Core code does not authorize exposing an unregistered route, screen or permission.
