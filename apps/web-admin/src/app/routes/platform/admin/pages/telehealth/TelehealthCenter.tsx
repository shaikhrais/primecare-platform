import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ButtonRegistry } = AdminRegistry;

export default function TelehealthCenter() {
    const [sessions, setSessions] = useState<any[]>([]);
    const [vitals, setVitals] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState(true);

    const fetchData = async () => {
        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';

            const [sessionsRes, vitalsRes] = await Promise.all([
                fetch(`${apiUrl}${ApiRegistry.PLATFORM.ADMIN.TELEHEALTH.SESSIONS}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                }),
                fetch(`${apiUrl}/v1/admin/telehealth/vitals`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                })
            ]);

            if (sessionsRes.ok) {
                const data = await sessionsRes.json();
                setSessions(data.sessions || []);
            }
            if (vitalsRes.ok) {
                const data = await vitalsRes.json();
                setVitals(data.vitals || []);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => {
        fetchData();
    }, []);

    const startBtn = ButtonRegistry.find((b: any) => b.id === 'btn-telehealth-session-start');
    const verifyBtn = ButtonRegistry.find((b: any) => b.id === 'btn-rpm-vitals-verify');

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: 'var(--brand-50)', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid var(--brand-100)' }}>
                        🩺
                    </div>
                    <div>
                        <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }}>Telehealth & RPM Center</h1>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>Encrypted video consultations and live remote patient monitoring.</p>
                    </div>
                </div>
                <button className="btn primary" onClick={() => alert('Initiating video consulting...')}>
                    {startBtn?.label || 'Start Virtual Visit'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(0, 2fr) minmax(0, 1fr)', gap: '24px' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    {/* Active Sessions */}
                    <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <div className="pc-card-h">Active Consultations</div>
                        <div style={{ padding: '20px' }}>
                            {sessions.map(s => (
                                <div key={s.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', borderRadius: '12px', backgroundColor: 'var(--bg-200)', marginBottom: '12px', border: '1px solid var(--border)' }}>
                                    <div>
                                        <div style={{ fontWeight: '700', color: 'var(--text-100)' }}>{s.patient}</div>
                                        <div style={{ fontSize: '13px', color: 'var(--text-300)' }}>{s.type} • {s.provider}</div>
                                    </div>
                                    <div style={{ textAlign: 'right' }}>
                                        <div className={`pc-badge ${s.status === 'In-Progress' ? 'primary' : 'secondary'}`}>{s.status}</div>
                                        <div style={{ fontSize: '12px', color: 'var(--text-300)', marginTop: '4px' }}>{s.time}</div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                    {/* Live Vitals Feed */}
                    <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                        <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span>Live Vitals Stream</span>
                            <button className="btn secondary" style={{ padding: '4px 12px', fontSize: '12px' }} onClick={fetchData}>Refresh Feed</button>
                        </div>
                        <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                            <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                                <tr>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Patient</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Vital Sign</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Value</th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                {vitals.map(v => (
                                    <tr key={v.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                        <td style={{ padding: '16px 24px', fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{v.patient}</td>
                                        <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-200)' }}>{v.type}</td>
                                        <td style={{ padding: '16px 24px', fontSize: '16px', fontWeight: '800', color: 'var(--brand-600)' }}>{v.value} <span style={{ fontSize: '12px', color: 'var(--text-300)' }}>{v.unit}</span></td>
                                        <td style={{ padding: '16px 24px' }}>
                                            <span className={`pc-badge ${v.status === 'High' ? 'danger' : 'primary'}`}>{v.status}</span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    <div className="pc-card" style={{ padding: '24px' }}>
                        <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: '800' }}>Quick Actions</h3>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            <button className="btn secondary" style={{ width: '100%', justifyContent: 'flex-start' }} onClick={() => alert('Opening triage portal...')}>
                                Open Triage Portal
                            </button>
                            <button className="btn secondary" style={{ width: '100%', justifyContent: 'flex-start' }} onClick={() => alert('Verifying patient data...')}>
                                {verifyBtn?.label || 'Verify Remote Vitals'}
                            </button>
                        </div>
                    </div>

                    <div className="pc-card" style={{ padding: '24px', background: 'linear-gradient(135deg, var(--brand-500) 0%, var(--brand-700) 100%)', color: 'white' }}>
                        <div style={{ fontSize: '14px', opacity: 0.8 }}>System Status</div>
                        <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>Gateway Active</div>
                        <div style={{ marginTop: '16px', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <div style={{ width: '8px', height: '8px', backgroundColor: '#10B981', borderRadius: '50%', boxShadow: '0 0 8px #10B981' }}></div>
                            <span style={{ fontSize: '12px' }}>SSL Enforced • HIPAA Ready</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
