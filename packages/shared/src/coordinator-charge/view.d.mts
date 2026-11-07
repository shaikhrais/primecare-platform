/** Read model consumed by the existing coordinator-charge presentation. */
export interface ChargeAssignment {
  id: string;
  user_id: string;
  name?: string | null;
  email: string;
  state: string;
  starts_at: string;
  ends_at?: string | null;
  reason: string;
  version: number;
}

export interface ChargeViewData {
  preview?: boolean;
  identity: {userId: string};
  organization?: string | null;
  assignments: ChargeAssignment[];
  tenants?: {id: string; name: string}[];
  tenant?: string;
  canManage: boolean;
  users: {id: string; name: string; email: string}[];
  events: {
    created_at: string;
    actor_email?: string | null;
    actor_id: string;
    action: string;
    detail?: {reason?: string; path?: string} | null;
    effective_role: string;
  }[];
}

export function escape(value: unknown): string;
export const chargeStyles: string;
export function chargeView(data: ChargeViewData): string;
