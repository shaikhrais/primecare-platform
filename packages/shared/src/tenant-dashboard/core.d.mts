/** Contracts for the existing runtime validation and task-transition module. */
export type TaskPriority = 'low' | 'normal' | 'high' | 'urgent';
export type TaskStatus = 'open' | 'in_progress' | 'blocked' | 'submitted' | 'completed' | 'cancelled';
export type TaskAction = 'start' | 'block' | 'submit' | 'edit' | 'cancel' | 'complete' | 'return';

export interface TaskState {
  status: string;
  owner_id: string;
  submitted_by?: string | null;
}

export interface TaskInput {
  title: string;
  owner_id: string;
  due_on: string;
  priority: TaskPriority;
  flow_id: string;
  notes: string;
}

export interface TenantTask extends TaskInput, TaskState {
  id: string;
  status: TaskStatus;
  evidence: string;
  submitted_by: string | null;
  version: number;
}

export interface TenantDemo {
  stats: Record<'staff' | 'clients' | 'visits' | 'requests' | 'time' | 'care' | 'plans', number>;
  users: {id: string; name: string; email: string; roles: string}[];
  clients: {id: string; name: string}[];
  tasks: TenantTask[];
  cleared: boolean;
}

export function validDate(value: unknown): value is string;
export function taskInput(
  value: unknown,
  owners: readonly {id: string}[],
  workflows: readonly {flow_id: string}[],
): TaskInput;
export function transition(
  task: TaskState,
  action: string,
  evidence: unknown,
  actor: string,
  manager: boolean,
): {status: TaskStatus; evidence: string; submitted_by: string | null | undefined};
export function taskActions(task: TaskState, actor: string, manager: boolean): TaskAction[];
export function seedTenantDemo(): TenantDemo;
export function emptyTenantDemo(): TenantDemo;
