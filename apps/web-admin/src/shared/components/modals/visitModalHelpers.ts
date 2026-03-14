// CreateVisitModal: form defaults and submit payload builder extracted
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
const { ApiRegistry } = AdminRegistry;

export interface VisitFormData {
    clientId: string; serviceId: string; requestedStartAt: string; durationMinutes: number;
    assignedPswId: string; clientNotes: string; assignmentType: 'open' | 'direct';
    priority: 'normal' | 'urgent'; recurrence: 'none' | 'daily' | 'weekly' | 'monthly' | 'advanced';
    advancedRRule: string; advancedUntil: string | undefined;
}

export const DEFAULT_FORM: VisitFormData = {
    clientId: '', serviceId: '', requestedStartAt: '', durationMinutes: 60,
    assignedPswId: '', clientNotes: '', assignmentType: 'open', priority: 'normal',
    recurrence: 'none', advancedRRule: '', advancedUntil: undefined
};

export function formFromVisit(visit: any): VisitFormData {
    return {
        clientId: visit.client?.id || visit.clientId || '', serviceId: visit.serviceId || '',
        requestedStartAt: visit.requestedStartAt ? new Date(visit.requestedStartAt).toISOString().slice(0, 16) : '',
        durationMinutes: visit.durationMinutes || 60, assignedPswId: visit.assignedPswId || '',
        clientNotes: visit.clientNotes || '', assignmentType: visit.assignedPswId ? 'direct' : 'open',
        priority: visit.priority || 'normal', recurrence: 'none', advancedRRule: '', advancedUntil: undefined
    };
}

export async function fetchModalData() {
    const [clientsRes, servicesRes, usersRes] = await Promise.all([
        apiClient.get(ApiRegistry.STAFF.CUSTOMERS), apiClient.get(ApiRegistry.ADMIN.SERVICES), apiClient.get(ApiRegistry.ADMIN.USERS)
    ]);
    const clients = clientsRes.ok ? await clientsRes.json() : [];
    const services = servicesRes.ok ? await servicesRes.json() : [];
    const users = usersRes.ok ? await usersRes.json() : [];
    return { clients, services, psws: users.filter((u: any) => u.roles.includes('psw')) };
}

export function buildPayload(formData: VisitFormData): any {
    const payload: any = {
        clientId: formData.clientId, serviceId: formData.serviceId,
        requestedStartAt: new Date(formData.requestedStartAt).toISOString(),
        durationMinutes: Number(formData.durationMinutes),
        assignedPswId: formData.assignmentType === 'direct' ? formData.assignedPswId : undefined,
        clientNotes: formData.clientNotes, priority: formData.priority,
    };
    if (formData.recurrence === 'advanced' && formData.advancedRRule) { payload.recurrenceRuleString = formData.advancedRRule; payload.recurrenceEndDate = formData.advancedUntil; }
    else if (formData.recurrence === 'daily') payload.recurrenceRuleString = 'FREQ=DAILY';
    else if (formData.recurrence === 'weekly') payload.recurrenceRuleString = 'FREQ=WEEKLY';
    else if (formData.recurrence === 'monthly') payload.recurrenceRuleString = 'FREQ=MONTHLY';
    return payload;
}
