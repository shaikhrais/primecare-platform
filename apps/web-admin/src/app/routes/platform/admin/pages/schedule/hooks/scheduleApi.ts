// useScheduleLogic: types and API fetcher helpers extracted
import { AdminRegistry } from 'prime-care-shared';
const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8787';

export interface Visit {
    id: string; requestedStartAt: string; durationMinutes: number;
    client: { fullName: string }; psw?: { fullName: string }; assignedPswId?: string;
    status: string; isSurgeActive?: boolean; surgeMultiplier?: number;
    service?: { providerRateHourly?: string | number };
}

export function getStatusColor(status: string): string {
    switch (status.toLowerCase()) {
        case 'requested': return '#f57c00'; case 'scheduled': return '#1976d2';
        case 'completed': return '#388e3c'; case 'posted': return '#8e24aa';
        case 'offered': return '#00acc1'; case 'accepted': return '#43a047';
        default: return '#9e9e9e';
    }
}

export async function apiFetchVisits(statusFilter?: string | null): Promise<{ visits: Visit[]; events: any[] }> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS}`, { headers: { Authorization: `Bearer ${token}` } });
    const data = await res.json();
    if (!Array.isArray(data)) return { visits: [], events: [] };
    let filtered = statusFilter ? data.filter((v: Visit) => v.status.toLowerCase() === statusFilter.toLowerCase()) : data;
    const events = filtered.map((v: Visit) => {
        const start = new Date(v.requestedStartAt); const end = new Date(start.getTime() + v.durationMinutes * 60000);
        return { id: v.id, title: `${v.client?.fullName || 'Unknown Client'} (${v.status})`, start, end, resource: v, style: { backgroundColor: getStatusColor(v.status) } };
    });
    return { visits: filtered, events };
}

export async function apiFetchPsws(): Promise<any[]> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS}`, { headers: { Authorization: `Bearer ${token}` } });
    const data = await res.json();
    return Array.isArray(data) ? data.filter((u: any) => u.role === 'psw') : [];
}

export async function apiAssignVisit(visitId: string, pswId: string): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_ASSIGN}`, { method: 'POST', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ visitId, pswId }) });
    return res.ok;
}

export async function apiOfferVisit(visitId: string, pswIds: string[]): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}/offer`, { method: 'POST', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ pswIds }) });
    return res.ok;
}

export async function apiFetchSuggestions(visitId: string): Promise<any[]> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}/suggest`, { headers: { Authorization: `Bearer ${token}` } });
    return await res.json();
}

export async function apiApplySurge(visitId: string, multiplier: number, active: boolean): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}/api/v1/admin/visits/${visitId}/surge`, { method: 'PATCH', headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' }, body: JSON.stringify({ surgeMultiplier: multiplier, isSurgeActive: active }) });
    return res.ok;
}

export async function apiDeleteVisit(visitId: string): Promise<boolean> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.VISITS_UPDATE(visitId)}`, { method: 'DELETE', headers: { 'Authorization': `Bearer ${token}` } });
    return res.ok;
}
