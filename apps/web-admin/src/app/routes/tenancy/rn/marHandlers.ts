// T31-MarClient: medication types, API handlers, and state logic extracted
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';

export interface Medication {
    id: string; name: string; dose: string; route: string; frequency: string;
    status: 'pending' | 'administered' | 'withheld';
    interactionLevel?: 'critical' | 'moderate' | 'none'; interactionMessage?: string;
}

export async function loadMedications(): Promise<Medication[]> {
    const cached = localStorage.getItem('primecare_emar_cache_123');
    if (cached && !navigator.onLine) return JSON.parse(cached);
    try {
        const res = await apiClient.get(AdminRegistry.ApiRegistry.RN.MAR_SCHEDULE('demo-client-1'));
        if (res.ok) { const data = await res.json(); localStorage.setItem('primecare_emar_cache_123', JSON.stringify(data)); return data as Medication[]; }
        throw new Error('Failed to fetch');
    } catch { if (cached) return JSON.parse(cached); return []; }
}

export async function commitAdministeredMeds(meds: Medication[]): Promise<boolean> {
    const administered = meds.filter(m => m.status === 'administered');
    try {
        for (const med of administered) {
            await apiClient.post(AdminRegistry.ApiRegistry.RN.MAR_ADMINISTER, {
                clientId: 'demo-client-1', medicationName: med.name, dosage: med.dose,
                route: med.route, scheduledTime: new Date().toISOString(), status: 'given'
            });
        }
        localStorage.removeItem('primecare_emar_cache_123');
        return true;
    } catch (e) { console.error('Failed to commit ledger:', e); return false; }
}
