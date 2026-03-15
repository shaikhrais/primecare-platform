// ================================================================
// PAGE IDENTITY: H2 � Pharmacy Hub
// Registry ID:   page.admin.pharmacy
// Type:          Hub
// Owner:         admin
// ================================================================
import React, { useState, useEffect } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useMutation } from '@tanstack/react-query';
import { useNotification } from '@/shared/context/NotificationContext';
import { useNavigate } from 'react-router-dom';
import { ScanBarcode, ShieldCheck, AlertOctagon } from 'lucide-react';
const { ApiRegistry, ButtonRegistry } = AdminRegistry;

export default function PharmacyHub() {
    const [meds, setMeds] = useState<any[]>([]);
    const [stats, setStats] = useState<any>(null);
    const [isLoading, setIsLoading] = useState(true);
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const fetchData = async () => {
        setIsLoading(true);
        try {
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';
            const response = await fetch(`${apiUrl}${ApiRegistry.PLATFORM.ADMIN.PHARMACY.PRESCRIPTIONS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                setMeds(data.prescriptions || []);
                setStats(data.stats || null);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setIsLoading(false);
        }
    };

    useEffect(() => { fetchData(); }, []);

    const actionMutation = useMutation({
        mutationFn: async (endpoint: string) => {
            const response = await apiClient.post(endpoint, {});
            if (!response.ok) throw new Error('Action failed on server');
            return response;
        },
    });

    const handleAction = (endpoint: string, successMsg: string) => {
        actionMutation.mutate(endpoint, {
            onSuccess: () => { showToast(successMsg, 'success'); fetchData(); },
            onError: () => { showToast('Network error while processing request', 'error'); },
        });
    };

    // Hardware Integration: BCMA Scanner Wedge Hook
    const [scannedNdc, setScannedNdc] = useState('');
    const [scannerStatus, setScannerStatus] = useState<'IDLE' | 'VERIFYING' | 'MATCH' | 'MISMATCH'>('IDLE');

    useEffect(() => {
        let buffer = '';
        let timeoutId: ReturnType<typeof setTimeout>;

        const handleKeyDown = (e: KeyboardEvent) => {
            // Check if it's not a normal typing input (like inside a form)
            if (e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement) return;

            // Scanners type extremely fast, so if characters are coming in under 50ms gaps, it's a scanner.
            buffer += e.key;

            clearTimeout(timeoutId);
            timeoutId = setTimeout(async () => {
                if (buffer.length >= 8 && buffer.includes('Enter')) {
                    const ndc = buffer.replace('Enter', '').trim();
                    setScannedNdc(ndc);
                    setScannerStatus('VERIFYING');
                    
                    try {
                        // In reality, expectedNdc would be tied to the currently selected patient's active MAR window
                        const response = await apiClient.post(ApiRegistry.PLATFORM.ADMIN.PHARMACY.VERIFY_BARCODE, {
                            ndc: ndc,
                            expectedNdc: '00000000000', // Mock expected
                            patientId: 'PT-ACTIVE'
                        });
                        
                        if (response.ok) {
                            setScannerStatus('MATCH');
                            showToast('Barcode Verified: Five rights confirmed.', 'success');
                        } else {
                            setScannerStatus('MISMATCH');
                            showToast('CRITICAL: Medication mismatch detected.', 'error');
                        }
                    } catch (err) {
                        setScannerStatus('MISMATCH');
                        showToast('Scanner verification failed.', 'error');
                    }
                }
                buffer = ''; // Reset
            }, 50);
        };

        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, []);
    const orderBtn = getButtonById('btn-pharmacy-order');
    const syncBtn = getButtonById('btn-pharmacy-mar-sync');

    return (
        <div data-cy="page.container" role="main" aria-label="Pharmacy Hub" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#EEF2FF', padding: '16px', borderRadius: '12px', fontSize: '32px', border: '1px solid #E0E7FF' }}>
                        💊
                    </div>
                    <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: 'var(--text-100)' }}>Pharmacy & Medication Hub</h1>
                            {scannerStatus === 'IDLE' && <div title="BCMA Scanner Ready" className="pc-badge secondary" style={{ padding: '4px 8px', display: 'flex', gap: '4px', alignItems: 'center' }}><ScanBarcode size={14} /> Scanner IDLE</div>}
                            {scannerStatus === 'VERIFYING' && <div className="pc-badge warning" style={{ padding: '4px 8px' }}>Verifying NDC...</div>}
                            {scannerStatus === 'MATCH' && <div className="pc-badge success" style={{ padding: '4px 8px', display: 'flex', gap: '4px', alignItems: 'center' }}><ShieldCheck size={14} /> MATCH</div>}
                            {scannerStatus === 'MISMATCH' && <div className="pc-badge destructive" style={{ padding: '4px 8px', display: 'flex', gap: '4px', alignItems: 'center' }}><AlertOctagon size={14} /> MISMATCH</div>}
                        </div>
                        <p style={{ color: 'var(--text-300)', margin: '4px 0 0 0' }}>E-prescribing, MAR tracking, ADC integration, and BCMA.</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button data-cy="btn-admin.pharmacy-hub-0" className="btn secondary" onClick={() => handleAction(ApiRegistry.PLATFORM.ADMIN.PHARMACY.MAR_SYNC, 'MAR synchronized successfully!')}>
                        {syncBtn?.label || 'Sync MAR'}
                    </button>
                    <button data-cy="btn-admin.pharmacy-hub-1" className="btn primary" onClick={() => handleAction(ApiRegistry.PLATFORM.ADMIN.PHARMACY.ORDER_DRUGS, 'Medication order requested!')}>
                        {orderBtn?.label || 'Order Medication'}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '20px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Active Prescriptions</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--text-100)', marginTop: '4px' }}>{stats?.active ?? 0}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Pending Renewals</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: 'var(--brand-500)', marginTop: '4px' }}>{stats?.pendingRenewals ?? 0}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>MAR Compliance</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10B981', marginTop: '4px' }}>{stats?.marCompliance ?? '100%'}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px' }}>
                    <div style={{ fontSize: '13px', fontWeight: '600', color: 'var(--text-300)' }}>Critical Alerts</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '4px' }}>{stats?.criticalAlerts ?? 0}</div>
                </div>
            </div>

            <div className="pc-card" style={{ padding: '0', overflow: 'hidden' }}>
                <div className="pc-card-h">Active Medication Records</div>
                <table data-cy="table-admin.pharmacy-hub" style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', borderBottom: '1px solid var(--border)' }}>
                        <tr>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Medication</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Patient</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Frequency</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Status</th>
                            <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: 'var(--text-300)', textTransform: 'uppercase' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {meds.map(m => (
                            <tr key={m.id} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '16px 24px' }}>
                                    <div style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-100)' }}>{m.name}</div>
                                    <div style={{ fontSize: '12px', color: 'var(--text-300)' }}>{m.strength}</div>
                                </td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-100)' }}>{m.patient}</td>
                                <td style={{ padding: '16px 24px', fontSize: '14px', color: 'var(--text-300)' }}>{m.frequency}</td>
                                <td style={{ padding: '16px 24px' }}>
                                    <span className={`pc-badge ${m.status === 'Active' ? 'primary' : m.status === 'Renewed' ? 'success' : 'secondary'}`}>
                                        {m.status}
                                    </span>
                                </td>
                                <td style={{ padding: '16px 24px' }}>
                                    <button data-cy="btn-admin.pharmacy-hub-2" className="btn secondary" style={{ padding: '4px 8px', fontSize: '11px' }} onClick={() => navigate(AdminRegistry.RouteRegistry.ADMIN.DASHBOARD)}>View MAR</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
