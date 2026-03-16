# State Ownership Map

> Single source of truth for which system owns each category of state.
> New code **MUST** follow these rules — no exceptions without team review.

## Zustand (Client-Only UI State)

| Store | Owns | Persisted? |
|-------|------|------------|
| `useAuthStore` | User, role, tenant, permissions (synced from AuthContext via `useStoreSync`) | ✅ user + isAuthenticated |
| `useUIStore` | Theme, sidebar collapsed, **toasts**, unread badge count | ✅ theme + sidebar |

### Rules
- **Toasts**: Always use `useToast()` hook (wraps `useUIStore.addToast`)
- **Never** create new React Context for UI state — add a slice to `useUIStore` instead
- Selectors for common patterns live in `stores/index.ts` (e.g. `useTenantId`, `useActiveRole`)

---

## TanStack Query (Server State)

| Concern | Pattern |
|---------|---------|
| All API data (lists, entities, dashboards) | `useQuery` with typed query keys |
| Mutations (create, update, delete) | `useMutation` + `queryClient.invalidateQueries` |
| Optimistic updates | Use `onMutate` → snapshot → rollback on error |

### Rules
- **Never** store API data in Zustand or React Context
- **Never** cache API responses in `localStorage` — let TanStack Query manage the cache
- Use query key factories for consistency

---

## React Context (Infrastructure / Cross-Cutting Concerns)

| Context | Purpose | Why not Zustand? |
|---------|---------|-----------------|
| `AuthContext` | Auth flow (login, logout, token refresh, cookie management) | Manages async effects + HTTP-only cookie lifecycle |
| `OfflineSyncContext` | Network detection, mutation queue, retry sync | Manages browser events + async retry logic |
| `NotificationCenterContext` | Persistent server-side notifications (bell icon, read/unread) | Fetches from API + manages server state |
| `CommandPaletteContext` | Command palette open/close, search state | Tightly coupled to keyboard events + portal rendering |
| `ThemeContext` | Legacy wrapper — wraps `AuthProvider` at root | Candidate for removal |

### Rules
- **Do NOT** add new React Context for data that could be a Zustand slice
- Context is appropriate for: async lifecycle management, browser event subscriptions, provider-tree-dependent behavior

---

## Deprecated (Do Not Use)

| System | Replacement |
|--------|-------------|
| ~~`NotificationProvider`~~ / ~~`useNotification()`~~ | `useToast()` from `@/shared/hooks/useToast` |
| ~~Direct `localStorage.getItem('user')`~~ | `useAuthStore()` or `useAuth()` |
