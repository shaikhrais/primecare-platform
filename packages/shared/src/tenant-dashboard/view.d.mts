import type {TaskAction, TaskInput, TenantDemo} from './core.mjs';

/** Presentation data only. The server and runtime core retain all authorization. */
export interface TenantTaskRow {
  id: string;
  title: string;
  flow_id: string;
  due_on: string;
  priority: string;
  status: string;
  ownerName?: string | null;
}

export interface TenantTaskDetail {
  title: string;
  due_on: string;
  status: string;
  ownerName?: string | null;
  notes?: string | null;
  evidence?: string | null;
  actions: readonly TaskAction[];
}

export type TenantIcon = 'layout-dashboard' | 'clipboard-check' | 'database' | 'users' |
  'shield-check' | 'chart-bar' | 'file-text' | 'settings' | 'user-circle' | 'refresh';

export interface TenantWorkflow {
  flow_id: string;
  title: string;
  flow_kind?: string;
  definition_status?: string;
  verification_status?: string | null;
  test_status?: string | null;
  blocker_json?: string | null;
  steps: {action_text: string; expected_text: string}[];
}

export interface TenantFormData {
  today: string;
  users: {id: string; name?: string | null; roles: string; email?: string | null}[];
  workflows: {flow_id: string; title: string}[];
}

export interface TenantViewData extends TenantFormData {
  dataset: string;
  organization: {id: string; name: string};
  synthetic: boolean;
  canCreate: boolean;
  canManage: boolean;
  tenants?: {id: string; name: string}[];
  stats?: Partial<Record<keyof TenantDemo['stats'], number | null>> | null;
  taskStats?: Partial<Record<'open' | 'review' | 'blocked' | 'overdue' | 'completed', number>> | null;
  tasks: TenantTaskRow[];
  taskPage: {total: number; offset: number};
  workflows: TenantWorkflow[];
  workflowPage: {total: number; offset: number; stepsTruncated?: boolean};
  clients: TenantDemo['clients'];
  directoryTruncated?: boolean;
  events: {
    action: string;
    actor_role: string;
    actor_id: string;
    created_at: string;
    detail?: {evidence?: string; title?: string; view?: string} | null;
  }[];
  allowedViews?: string[];
  preference: {view: string};
  globalPreview?: boolean;
  database: string;
}

export interface TenantViewState {
  view?: string;
  search?: string;
  status?: string;
  notice?: string;
}

export function esc(value: unknown): string;
export const tenantStyles: string;
export function tenantNavigation(
  view: string,
  icon: (name: TenantIcon) => string,
  allowed?: readonly string[],
  manage?: boolean,
): string;
export function tenantView(
  data: TenantViewData,
  state: TenantViewState,
  icon?: (name: TenantIcon) => string,
  preview?: boolean,
): string;
export function taskForm(data: TenantFormData, task?: Partial<TaskInput> | null, flowId?: string): string;
export function taskDetail(task: TenantTaskDetail): string;
