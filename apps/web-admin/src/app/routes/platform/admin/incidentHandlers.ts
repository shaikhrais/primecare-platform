// IncidentList: API handlers and filter logic extracted
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';
const { ApiRegistry } = AdminRegistry;

export async function fetchIncidents(): Promise<any[]> {
    try { const res = await apiClient.get(ApiRegistry.ADMIN.INCIDENTS); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch incidents', e); }
    return [];
}

export async function resolveIncident(id: string, resolutionNotes: string): Promise<boolean> {
    try { const res = await apiClient.patch(`${ApiRegistry.ADMIN.INCIDENTS}/${id}`, { status: 'resolved', resolutionNotes }); return res.ok; } catch { return false; }
}

export async function deleteIncident(id: string): Promise<boolean> {
    try { const res = await apiClient.delete(`${ApiRegistry.ADMIN.INCIDENTS}/${id}`); return res.ok; } catch { return false; }
}

export function filterIncidents(incidents: any[], statusFilter: string, typeFilter: string): any[] {
    return incidents.filter(inc => {
        if (statusFilter !== 'all' && inc.status !== statusFilter) return false;
        if (typeFilter !== 'all' && inc.type?.toLowerCase() !== typeFilter) return false;
        return true;
    });
}
