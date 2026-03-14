// T13 Device Management: interfaces and API handlers extracted
import { apiClient } from '@/shared/utils/apiClient';

export interface Device {
    id: string; userId: string; deviceId: string; deviceName: string | null;
    deviceType: string | null; lastIp: string | null; status: string;
    isAuthorized: boolean; isTemporary: boolean; expiresAt: string | null;
    lastActiveAt: string; user: { firstName: string | null; lastName: string | null; email: string; };
}

export interface AuditLog { id: string; action: string; resourceType: string; createdAt: string; ipAddress: string | null; metadataJson: any; }

export async function fetchDevices(): Promise<Device[]> {
    try { const res = await apiClient.get('/v1/admin/settings/security/devices'); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch devices:', e); }
    return [];
}

export async function authorizeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/authorize`); return res.ok; } catch { return false; }
}

export async function revokeDevice(id: string): Promise<boolean> {
    try { const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/revoke`); return res.ok; } catch { return false; }
}

export async function fetchDeviceActivity(deviceId: string): Promise<AuditLog[]> {
    try { const res = await apiClient.get(`/v1/admin/settings/security/devices/${deviceId}/activity`); if (res.ok) return await res.json(); } catch (e) { console.error('Failed to fetch activity:', e); }
    return [];
}
