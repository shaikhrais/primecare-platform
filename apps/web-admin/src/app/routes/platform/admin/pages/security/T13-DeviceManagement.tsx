// ================================================================
// PAGE IDENTITY: T13 — Device Management
// Registry ID:   page.admin.device-mgmt
// Type:          Tool
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { useDialog } from '@/shared/hooks/useDialog';
import { type Device, type AuditLog, fetchDevices as apiFetchDevices, authorizeDevice, revokeDevice, fetchDeviceActivity } from './deviceHandlers';

export default function DeviceManagement() {
    const { confirm, DialogRenderer } = useDialog();
    const [devices, setDevices] = useState<Device[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedDevice, setSelectedDevice] = useState<Device | null>(null);
    const [activity, setActivity] = useState<AuditLog[]>([]);
    const [activityLoading, setActivityLoading] = useState(false);

    const reload = async () => { const d = await apiFetchDevices(); setDevices(d); setLoading(false); };
    useEffect(() => { reload(); }, []);

    const handleAuthorize = async (id: string) => { if (await authorizeDevice(id)) reload(); };
    const handleRevoke = async (id: string) => { if (!(await confirm('Force Logout Device', 'Are you sure you want to force logout and revoke access for this device?'))) return; if (await revokeDevice(id)) reload(); };
    const viewActivity = async (device: Device) => { setSelectedDevice(device); setActivityLoading(true); const logs = await fetchDeviceActivity(device.deviceId); setActivity(logs); setActivityLoading(false); };

    if (loading) return <div style={{ padding: '24px' }}>Loading device registry...</div>;

    return (
        <div data-cy="page.container" role="main" aria-label="Device Mgmt" style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}><h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Device Registry</h1><p style={{ color: '#6B7280' }}>Monitor and manage all hardware authorized to access the platform. Force logout sessions if suspicious activity is detected.</p></div>

            <div className="pc-card"><div className="pc-card-h">Active & Managed Devices</div><div className="pc-card-b" style={{ padding: '0' }}>
                <table data-cy="table-admin.device-management" style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}><tr>
                        <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>DEVICE / USER</th>
                        <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>TYPE</th>
                        <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>LAST ACCESS</th>
                        <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>STATUS</th>
                        <th style={{ textAlign: 'right', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>ACTIONS</th>
                    </tr></thead>
                    <tbody>{devices.map(device => (
                        <tr key={device.id} style={{ borderBottom: '1px solid #E5E7EB' }}>
                            <td style={{ padding: '16px' }}><div style={{ fontWeight: '600', fontSize: '14px' }}>{device.deviceName || 'Unknown Hardware'}</div><div style={{ fontSize: '12px', color: '#6B7280' }}>{device.user.email}</div><div style={{ fontSize: '10px', color: '#9CA3AF', fontFamily: 'monospace' }}>ID: {device.deviceId}</div></td>
                            <td style={{ padding: '16px' }}><span style={{ padding: '4px 8px', background: '#F3F4F6', borderRadius: '6px', fontSize: '11px', fontWeight: '600', textTransform: 'uppercase' }}>{device.deviceType || 'N/A'}</span></td>
                            <td style={{ padding: '16px' }}><div style={{ fontSize: '13px' }}>{new Date(device.lastActiveAt).toLocaleString()}</div><div style={{ fontSize: '11px', color: '#9CA3AF' }}>{device.lastIp}</div></td>
                            <td style={{ padding: '16px' }}><div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>{device.status === 'revoked' || device.status === 'blocked' ? <span style={{ color: '#EF4444', fontSize: '12px', fontWeight: '600' }}>✖ Revoked</span> : device.isAuthorized ? <span style={{ color: '#059669', fontSize: '12px', fontWeight: '600' }}>✓ Authorized</span> : <span style={{ color: '#D97706', fontSize: '12px', fontWeight: '600' }}>⚠ Pending</span>}{device.isTemporary && <span style={{ color: '#3B82F6', fontSize: '12px', fontWeight: '600' }}>(Temp)</span>}</div>{device.isTemporary && device.expiresAt && <div style={{ fontSize: '10px', color: '#EF4444' }}>Expires: {new Date(device.expiresAt).toLocaleDateString()}</div>}</td>
                            <td style={{ padding: '16px', textAlign: 'right' }}><div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end' }}><button data-cy="btn-admin.device-management-0" className="btn secondary sm" onClick={() => viewActivity(device)} style={{ fontSize: '11px', padding: '4px 12px' }}>Logs</button>{!device.isAuthorized || device.status === 'revoked' ? <button data-cy="btn-admin.device-management-1" className="btn primary sm" onClick={() => handleAuthorize(device.id)} style={{ fontSize: '11px', padding: '4px 12px' }}>{device.status === 'revoked' ? 'Re-Authorize' : 'Approve'}</button> : <button data-cy="btn-admin.device-management-2" className="btn danger sm" onClick={() => handleRevoke(device.id)} style={{ fontSize: '11px', padding: '4px 12px' }}>Force Logout</button>}</div></td>
                        </tr>))}</tbody>
                </table>
                {devices.length === 0 && <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>No devices found in the registry.</div>}
            </div></div>

            {selectedDevice && (
                <div style={{ position: 'fixed', top: 0, left: 0, right: 0, bottom: 0, background: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, backdropFilter: 'blur(4px)' }}>
                    <div className="pc-card" style={{ width: '90%', maxWidth: '800px', maxHeight: '80vh', display: 'flex', flexDirection: 'column' }}>
                        <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}><span>Activity logs for {selectedDevice.deviceName}</span><button data-cy="btn-admin.device-management-3" onClick={() => setSelectedDevice(null)} style={{ background: 'none', border: 'none', color: '#fff', cursor: 'pointer', fontSize: '20px' }}>×</button></div>
                        <div className="pc-card-b" style={{ flex: 1, overflow: 'auto', padding: '0' }}>
                            {activityLoading ? <div style={{ padding: '48px', textAlign: 'center' }}>Loading activity logs...</div> : (
                                <table data-cy="table-admin.device-management" style={{ width: '100%', borderCollapse: 'collapse' }}>
                                    <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB', position: 'sticky', top: 0 }}><tr><th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>TIME</th><th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>ACTION</th><th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>RESOURCE</th><th style={{ textAlign: 'left', padding: '12px 16px', fontSize: '12px', color: '#6B7280' }}>IP ADDRESS</th></tr></thead>
                                    <tbody>{activity.map(log => <tr key={log.id} style={{ borderBottom: '1px solid #F3F4F6' }}><td style={{ padding: '12px 16px', fontSize: '13px' }}>{new Date(log.createdAt).toLocaleString()}</td><td style={{ padding: '12px 16px', fontSize: '13px', fontWeight: '500' }}>{log.action}</td><td style={{ padding: '12px 16px', fontSize: '13px', color: '#6B7280' }}>{log.resourceType}</td><td style={{ padding: '12px 16px', fontSize: '13px', color: '#6B7280' }}>{log.ipAddress || 'Internal'}</td></tr>)}{activity.length === 0 && <tr><td colSpan={4} style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>No activity logs recorded for this device.</td></tr>}</tbody>
                                </table>)}
                        </div>
                        <div style={{ padding: '16px', borderTop: '1px solid #E5E7EB', textAlign: 'right' }}><button data-cy="btn-admin.device-management-4" className="btn secondary" onClick={() => setSelectedDevice(null)}>Close</button></div>
                    </div>
                </div>
            )}
            <DialogRenderer />
        </div>
    );
}
