import React, { useEffect, useState } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '../../../../../../shared/context/NotificationContext';

const { ApiRegistry } = AdminRegistry;

interface TaxReport {
    periodStart: string;
    periodEnd: string;
    totalCollected: number;
    totalInputCredits: number;
    netTaxOwed: number;
    count: number;
}

export default function TaxComplianceHub() {
    const { showToast } = useNotification();
    const [report, setReport] = useState<TaxReport | null>(null);
    const [loading, setLoading] = useState(true);
    const [remitting, setRemitting] = useState(false);
    const [remittanceAmount, setRemittanceAmount] = useState<number>(0);
    const [reference, setReference] = useState('');

    const loadData = async () => {
        setLoading(true);
        try {
            const res = await apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.TAX_FILING);
            if (res.ok) {
                setReport(await res.json());
            }
        } catch (error) {
            showToast('Failed to load tax filing report', 'error');
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    const handleRemit = async () => {
        if (!remittanceAmount || !reference) {
            showToast('Please provide an amount and reference.', 'error');
            return;
        }

        setRemitting(true);
        try {
            const res = await apiClient.post(ApiRegistry.PLATFORM.ADMIN.REPORTING.TAX_REMITTANCE, {
                amount: remittanceAmount,
            });
            if (res.ok) {
                showToast('Tax remittance recorded successfully in the ledger.', 'success');
                loadData();
                setRemittanceAmount(0);
                setReference('');
            }
        } catch (error) {
            showToast('Remittance failed', 'error');
            console.error(error);
        } finally {
            setRemitting(false);
        }
    };

    if (loading) return (
        <div style={{ height: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#0f172a', color: '#fff' }}>
            <div className="loader"></div>
        </div>
    );

    return (
        <div style={{ padding: '40px', background: '#0f172a', minHeight: '100vh', color: '#fff', fontFamily: "'Outfit', 'Inter', sans-serif" }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '48px' }}>
                <div>
                    <h1 style={{ fontSize: '32px', fontWeight: '900', letterSpacing: '-0.02em', margin: '0' }}>Tax Compliance Hub</h1>
                    <p style={{ color: '#64748b', marginTop: '8px', fontSize: '14px', fontWeight: '600' }}>HST / GST FILING & REMITTANCE</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(12, 1fr)', gap: '24px' }}>
                {/* Main Stats */}
                <div style={{ gridColumn: 'span 8', background: 'rgba(30, 41, 59, 0.7)', borderRadius: '24px', padding: '32px', border: '1px solid rgba(255,255,255,0.05)', backdropFilter: 'blur(20px)' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '40px' }}>
                        <div>
                            <div style={{ fontSize: '12px', color: '#94a3b8', fontWeight: '800', textTransform: 'uppercase', marginBottom: '8px' }}>Current Liability</div>
                            <div style={{ fontSize: '64px', fontWeight: '900', color: (report?.netTaxOwed || 0) > 0 ? '#fbbf24' : '#4ade80' }}>
                                ${report?.netTaxOwed?.toLocaleString() || 0}
                            </div>
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            <div style={{ fontSize: '12px', color: '#94a3b8', fontWeight: '800', textTransform: 'uppercase', marginBottom: '8px' }}>Reporting Period</div>
                            <div style={{ fontSize: '18px', fontWeight: '700' }}>{report?.periodStart} to {report?.periodEnd}</div>
                        </div>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                        <div style={{ background: 'rgba(255,255,255,0.02)', padding: '24px', borderRadius: '16px' }}>
                            <div style={{ color: '#94a3b8', fontSize: '12px', fontWeight: '800', marginBottom: '12px' }}>OUTPUT TAX (COLLECTED)</div>
                            <div style={{ fontSize: '24px', fontWeight: '800' }}>${report?.totalCollected?.toLocaleString()}</div>
                        </div>
                        <div style={{ background: 'rgba(255,255,255,0.02)', padding: '24px', borderRadius: '16px' }}>
                            <div style={{ color: '#94a3b8', fontSize: '12px', fontWeight: '800', marginBottom: '12px' }}>INPUT TAX CREDITS (PAID)</div>
                            <div style={{ fontSize: '24px', fontWeight: '800' }}>${report?.totalInputCredits?.toLocaleString()}</div>
                        </div>
                    </div>
                </div>

                {/* Remittance Workflow */}
                <div style={{ gridColumn: 'span 4', background: 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)', borderRadius: '24px', padding: '32px', border: '1px solid rgba(255,255,255,0.1)' }}>
                    <h2 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '24px' }}>Record Remittance</h2>
                    <p style={{ fontSize: '13px', color: '#a5b4fc', marginBottom: '32px', lineHeight: '1.6' }}>After transferring funds to the revenue agency, record the payment below to balance the ledger.</p>

                    <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        <div>
                            <label style={{ fontSize: '11px', fontWeight: '800', color: '#94a3b8', display: 'block', marginBottom: '8px' }}>REMITTANCE AMOUNT ($)</label>
                            <input
                                type="number"
                                value={remittanceAmount}
                                onChange={(e) => setRemittanceAmount(parseFloat(e.target.value))}
                                style={{ width: '100%', background: 'rgba(255,255,255,0.05)', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px', padding: '12px', color: '#fff', fontSize: '16px' }}
                            />
                        </div>
                        <div>
                            <label style={{ fontSize: '11px', fontWeight: '800', color: '#94a3b8', display: 'block', marginBottom: '8px' }}>FILING REFERENCE / CONFIRMATION #</label>
                            <input
                                type="text"
                                value={reference}
                                onChange={(e) => setReference(e.target.value)}
                                style={{ width: '100%', background: 'rgba(255,255,255,0.05)', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px', padding: '12px', color: '#fff', fontSize: '16px' }}
                                placeholder="CRA-XXXXX-2026"
                            />
                        </div>
                        <button
                            onClick={handleRemit}
                            disabled={remitting || !remittanceAmount}
                            style={{
                                marginTop: '12px',
                                background: '#4ade80',
                                color: '#064e3b',
                                border: 'none',
                                borderRadius: '12px',
                                padding: '16px',
                                fontSize: '14px',
                                fontWeight: '800',
                                cursor: 'pointer',
                                opacity: remitting ? 0.5 : 1
                            }}
                        >
                            {remitting ? 'Processing...' : 'Post Remittance to Ledger'}
                        </button>
                    </div>
                </div>
            </div>

            <style>{`
                @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap');
                .loader { width: 48px; height: 48px; border: 5px solid #FFF; border-bottom-color: #3b82f6; border-radius: 50%; display: inline-block; animation: rotation 1s linear infinite; }
                @keyframes rotation { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
            `}</style>
        </div>
    );
}
