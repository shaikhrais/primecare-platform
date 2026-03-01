import React, { useState } from 'react';

const AutoPilotDashboard: React.FC = () => {
    const [isProcessing, setIsProcessing] = useState(false);
    const [result, setResult] = useState<{ processedVisits: number, offersCreated: number, message: string } | null>(null);

    const handleRunAutoPilot = async () => {
        setIsProcessing(true);
        setResult(null);

        try {
            // Retrieve JWT token
            const token = localStorage.getItem('token');
            const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8787';

            const response = await fetch(`${apiUrl}/admin/automation/clinical-autopilot/run`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
            });

            if (!response.ok) {
                throw new Error('Failed to run Auto-Pilot');
            }

            const data = await response.json();
            setResult(data);
        } catch (error) {
            console.error(error);
            alert('Error running Auto-Pilot. Please check the logs.');
        } finally {
            setIsProcessing(false);
        }
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginBottom: '32px' }}>
                <div style={{ backgroundColor: '#F0FDF4', padding: '16px', borderRadius: '12px', fontSize: '32px' }}>
                    🤖
                </div>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: '#111827' }}>Clinical Auto-Pilot</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Automated matchmaking and instant financial settlements.</p>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                {/* Auto Pilot Control Panel */}
                <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E5E7EB', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
                    <h2 style={{ fontSize: '18px', fontWeight: '600', marginBottom: '16px', color: '#111827', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        ⚙️ Shift Matchmaking Engine
                    </h2>
                    <p style={{ color: '#4B5563', fontSize: '14px', marginBottom: '24px', lineHeight: '1.5' }}>
                        The Auto-Pilot algorithm scans all upcoming pending visits for the next 48 hours. It evaluates active staff based on required skills, location, and availability, and automatically dispatches shift offers to the top candidates without human intervention.
                    </p>

                    <button
                        onClick={handleRunAutoPilot}
                        disabled={isProcessing}
                        style={{
                            width: '100%',
                            backgroundColor: isProcessing ? '#9CA3AF' : '#2563EB',
                            color: 'white',
                            padding: '12px 16px',
                            borderRadius: '8px',
                            border: 'none',
                            fontWeight: '600',
                            cursor: isProcessing ? 'not-allowed' : 'pointer',
                            display: 'flex',
                            justifyContent: 'center',
                            alignItems: 'center',
                            gap: '8px',
                            transition: 'background-color 0.2s'
                        }}
                    >
                        {isProcessing ? '⚡ Initializing Algorithm...' : '🚀 Engage Auto-Pilot'}
                    </button>

                    {result && (
                        <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F3F4F6', borderRadius: '8px', borderLeft: '4px solid #10B981' }}>
                            <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#065F46', marginBottom: '8px' }}>Execution Summary</h3>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px' }}>
                                <span style={{ color: '#4B5563', fontSize: '14px' }}>Pending Visits Scanned:</span>
                                <span style={{ fontWeight: '600', color: '#111827' }}>{result.processedVisits}</span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                                <span style={{ color: '#4B5563', fontSize: '14px' }}>Smart Offers Dispatched:</span>
                                <span style={{ fontWeight: '600', color: '#10B981' }}>{result.offersCreated}</span>
                            </div>
                            <p style={{ fontSize: '12px', color: '#6B7280', marginTop: '12px', fontStyle: 'italic' }}>
                                {result.message}
                            </p>
                        </div>
                    )}
                </div>

                {/* Instant Settlements Preview */}
                <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '24px', border: '1px solid #E5E7EB', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
                    <h2 style={{ fontSize: '18px', fontWeight: '600', marginBottom: '16px', color: '#111827', display: 'flex', alignItems: 'center', gap: '8px' }}>
                        💸 Instant Settlements
                    </h2>
                    <p style={{ color: '#4B5563', fontSize: '14px', marginBottom: '24px', lineHeight: '1.5' }}>
                        When a Care Provider completes a visit (Check-out) and submits their Daily Entry, the platform bypasses traditional payroll cycles. Funds are instantly settled to the provider's wallet via Stripe Connect.
                    </p>

                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        {/* Mock Settlement Item */}
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px', backgroundColor: '#FAFAFA', borderRadius: '8px', border: '1px solid #F3F4F6' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                <div style={{ width: '40px', height: '40px', borderRadius: '20px', backgroundColor: '#E0E7FF', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '18px' }}>
                                    👩‍⚕️
                                </div>
                                <div>
                                    <h4 style={{ margin: '0', fontSize: '14px', fontWeight: '600', color: '#111827' }}>Sarah Jenkins, RN</h4>
                                    <p style={{ margin: '0', fontSize: '12px', color: '#6B7280' }}>Wound Care • 2h Visit Completed</p>
                                </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                                <span style={{ display: 'block', fontWeight: 'bold', color: '#10B981' }}>+$110.00</span>
                                <span style={{ fontSize: '10px', color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.5px', padding: '2px 6px', backgroundColor: '#D1FAE5', borderRadius: '4px', display: 'inline-block', marginTop: '4px' }}>Settled instantly</span>
                            </div>
                        </div>

                        {/* Mock Settlement Item 2 */}
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px', backgroundColor: '#FAFAFA', borderRadius: '8px', border: '1px solid #F3F4F6' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                <div style={{ width: '40px', height: '40px', borderRadius: '20px', backgroundColor: '#FEF3C7', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '18px' }}>
                                    👨‍⚕️
                                </div>
                                <div>
                                    <h4 style={{ margin: '0', fontSize: '14px', fontWeight: '600', color: '#111827' }}>Michael Chang, PSW</h4>
                                    <p style={{ margin: '0', fontSize: '12px', color: '#6B7280' }}>Personal Care • 4h Visit Completed</p>
                                </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                                <span style={{ display: 'block', fontWeight: 'bold', color: '#10B981' }}>+$96.00</span>
                                <span style={{ fontSize: '10px', color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.5px', padding: '2px 6px', backgroundColor: '#D1FAE5', borderRadius: '4px', display: 'inline-block', marginTop: '4px' }}>Settled instantly</span>
                            </div>
                        </div>
                    </div>

                    <div style={{ marginTop: '24px', paddingTop: '16px', borderTop: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span style={{ fontSize: '14px', color: '#4B5563', fontWeight: '500' }}>Treasury Balance:</span>
                        <span style={{ fontSize: '18px', color: '#111827', fontWeight: '700' }}>$14,250.00</span>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default AutoPilotDashboard;
