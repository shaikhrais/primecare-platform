// ================================================================
// PAGE IDENTITY: T13 � Device Management
// Registry ID:   page.admin.device-mgmt
// Type:          Tool
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { useDialog } from '@/shared/hooks/useDialog';

interface Device {
    id: string;
    userId: string;
    deviceId: string;
    deviceName: string | null;
    deviceType: string | null;
    lastIp: string | null;
    status: string;
    isAuthorized: boolean;
    isTemporary: boolean;
    expiresAt: string | null;
    lastActiveAt: string;
    user: {
        firstName: string | null;
        lastName: string | null;
        email: string;
    };
}

interface AuditLog {
    id: string;
    action: string;
    resourceType: string;
    createdAt: string;
    ipAddress: string | null;
    metadataJson: any;
}

export default function DeviceManagement() {
    const { confirm, DialogRenderer } = useDialog();
    const [devices, setDevices] = useState<Device[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedDevice, setSelectedDevice] = useState<Device | null>(null);
    const [activity, setActivity] = useState<AuditLog[]>([]);
    const [activityLoading, setActivityLoading] = useState(false);

    useEffect(() => {
        fetchDevices();
    }, []);

    const fetchDevices = async () => {
        try {
            const res = await apiClient.get('/v1/admin/settings/security/devices');
            if (res.ok) {
                const data = await res.json();
                setDevices(data);
            }
        } catch (err) {
            console.error('Failed to fetch devices:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleAuthorize = async (id: string) => {
        try {
            const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/authorize`);
            if (res.ok) fetchDevices();
        } catch (err) {
            console.error('Failed to authorize device:', err);
        }
    };

    const handleRevoke = async (id: string) => {
        if (!(await confirm('Force Logout Device', 'Are you sure you want to force logout and revoke access for this device?'))) return;
        try {
            const res = await apiClient.post(`/v1/admin/settings/security/devices/${id}/revoke`);
            if (res.ok) fetchDevices();
        } catch (err) {
            console.error('Failed to revoke device:', err);
        }
    };

    const viewActivity = async (device: Device) => {
        setSelectedDevice(device);
        setActivityLoading(true);
        try {
            const res = await apiClient.get(`/v1/admin/settings/security/devices/${device.deviceId}/activity`);
            if (res.ok) {
                const data = await res.json();
                setActivity(data);
            }
        } catch (err) {
            console.error('Failed to fetch device activity:', err);
        } finally {
            setActivityLoading(false);
        }
    };

    if (loading) return <div style={{ padding: '24px' }}>Loading device registry...</div>;

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Device Registry</h1>
                <p style={{ color: '#6B7280' }}>Monitor and manage all hardware authorized to access the platform. Force logout sessions if suspicious activity is detected.</p>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Active & Managed Devices</div>
                <div className="pc-card-b" style={{ padding: '0' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                            <tr>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>DEVICE / USER</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>TYPE</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>LAST ACCESS</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>STATUS</th>
                                <th style={{ textAlign: 'right', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody>
                            {devices.map(device => (
                                <tr key={device.id} style={{ borderBottom: '1px solid #E5E7EB' }}>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ fontWeight: '600', fontSize: '14px' }}>{device.deviceName || 'Unknown Hardware'}</div>
                                        <div style={{ fontSize: '12px', color: '#6B7280' }}>{device.user.email}</div>
                                        <div style={{ fontSize: '10px', color: '#9CA3AF', fontFamily: 'monospace' }}>ID: {device.deviceId}</div>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            padding: '4px 8px',
                                            background: '#F3F4F6',
                                            borderRadius: '6px',
                                            fontSize: '11px',
                                            fontWeight: '600',
                                            textTransform: 'uppercase'
                                        }}>
                                            {device.deviceType || 'N/A'}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ fontSize: '13px' }}>{new Date(device.lastActiveAt).toLocaleString()}</div>
                                        <div style={{ fontSize: '11px', color: '#9CA3AF' }}>{device.lastIp}</div>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
                                            {device.status === 'revoked' || device.status === 'blocked' ? (
                                                <span style={{ color: '#EF4444', fontSize: '12px', fontWeight: '600' }}>✖ Revoked</span>
                                            ) : device.isAuthorized ? (
                                                <span style={{ color: '#059669', fontSize: '12px', fontWeight: '600' }}>✓ Authorized</span>
                                            ) : (
                                                <span style={{ color: '#D97706', fontSize: '12px', fontWeight: '600' }}>⚠ Pending</span>
                                            )}
                                            {device.isTemporary && (
                                                <span style={{ color: '#3B82F6', fontSize: '12px', fontWeight: '600' }}>(Temp)</span>
                                            )}
                                        </div>
                                        {device.isTemporary && device.expiresAt && (
                                            <div style={{ fontSize: '10px', color: '#EF4444' }}>Expires: {new Date(device.expiresAt).toLocaleDateString()}</div>
                                        )}
                                    </td>
                                    <td style={{ padding: '16px', textAlign: 'right' }}>
                                        <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}>
                                            <button
                                                className="btn secondary sm"
                                                onClick={() => viewActivity(device)}
                                                style={{ fontSize: '11px', padding: '4px 12px' }}
                                            >
                                                Logs
                                            </button>
                                            {!device.isAuthorized || device.status === 'revoked' ? (
                                                <button
                                                    className="btn primary sm"
                                                    onClick={() => handleAuthorize(device.id)}
                                                    style={{ fontSize: '11px', padding: '4px 12px' }}
                                                >
                                                    {device.status === 'revoked' ? 'Re-Authorize' : 'Approve'}
                                                </button>
                                            ) : (
                                                <button
                                                    className="btn danger sm"
                                                    onClick={() => handleRevoke(device.id)}
                                                    style={{ fontSize: '11px', padding: '4px 12px' }}
                                                >
                                                    Force Logout
                                                </button>
                                            )}
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                    {devices.length === 0 && (
                        <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>
                            No devices found in the registry.
                        </div>
                    )}
                </div>
            </div>

            {selectedDevice && (
                <div style={{
                    position: 'fixed',
                    top: 0, left: 0, right: 0, bottom: 0,
                    background: 'rgba(0,0,0,0.5)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 1000,
                    backdropFilter: 'blur(4px)'
                }}>
                    <div className="pc-card" style={{ width: '90%', maxWidth: '800px', maxHeight: '80vh', display: 'flex', flexDirection: 'column' }}>
                        <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span>Activity logs for {selectedDevice.deviceName}</span>
                            <button onClick={() => setSelectedDevice(null)} style={{ background: 'none', border: 'none', color: '#fff', cursor: 'pointer', fontSize: '20px' }}>×</button>
                        </div>
                        <div className="pc-card-b" style={{ flex: 1, overflow: 'auto', padding: '0' }}>
                            {activityLoading ? (
                                <div style={{ padding: '48px', textAlign: 'center' }}>Loading activity logs...</div>
                            ) : (
                                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                    <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB', position: 'sticky', top: 0 }}>
                                        <tr>
                                            <th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>TIME</th>
                                            <th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>ACTION</th>
                                            <th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>RESOURCE</th>
                                            <th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>IP ADDRESS</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {activity.map(log => (
                                            <tr key={log.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                                <td style={{ padding: '12px 16px', fontSize: '13px' }}>{new Date(log.createdAt).toLocaleString()}</td>
                                                <td style={{ padding: '12px 16px', fontSize: '13px', fontWeight: '500' }}>{log.action}</td>
                                                <td style={{ padding: '12px 16px', fontSize: '13px', color: '#6B7280' }}>{log.resourceType}</td>
                                                <td style={{ padding: '12px 16px', fontSize: '13px', color: '#6B7280' }}>{log.ipAddress || 'Internal'}</td>
                                            </tr>
                                        ))}
                                        {activity.length === 0 && (
                                            <tr>
                                                <td colSpan={4} style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>No activity logs recorded for this device.</td>
                                            </tr>
                                        )}
                                    </tbody>
                                </table>
                            )}
                        </div>
                        <div style={{ padding: '16px', borderTop: '1px solid #E5E7EB', textAlign: 'right' }}>
                            <button className="btn secondary" onClick={() => setSelectedDevice(null)}>Close</button>
                        </div>
                    </div>
                </div>
            )}
            <DialogRenderer />
            </div>
    );
}
