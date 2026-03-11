import React, { useState } from 'react';
import { Gift, CreditCard, HeartHandshake, CheckCircle2 } from 'lucide-react';

interface ShiftCompletion {
    shiftId: string;
    caregiverName: string;
    date: string;
    servicesRendered: string[];
}

export const GratuityTipBox: React.FC = () => {
    const [amount, setAmount] = useState<number>(10);
    const [customAmount, setCustomAmount] = useState<string>('');
    const [processing, setProcessing] = useState(false);
    const [success, setSuccess] = useState(false);

    // Mock recent shift
    const recentShift: ShiftCompletion = {
        shiftId: 'shift_994',
        caregiverName: 'Sarah Jenkins',
        date: 'Today, 9:00 AM - 1:00 PM',
        servicesRendered: ['Personal Care', 'Light Housekeeping', 'Meal Prep']
    };

    const handleTip = () => {
        setProcessing(true);
        // Mocks Stripe PaymentIntent for Gratuity
        setTimeout(() => {
            setProcessing(false);
            setSuccess(true);
        }, 1500);
    };

    if (success) {
        return (
            <div style={{ backgroundColor: '#F0FDF4', borderRadius: '12px', border: '1px solid #BBF7D0', padding: '32px 20px', textAlign: 'center', marginTop: '16px' }}>
                <div style={{ backgroundColor: '#DCFCE7', width: '64px', height: '64px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 16px auto' }}>
                    <HeartHandshake size={32} color="#16A34A" />
                </div>
                <h3 style={{ margin: 0, color: '#166534', fontSize: '1.4rem', fontWeight: 800 }}>Gratuity Sent!</h3>
                <p style={{ color: '#15803D', fontSize: '0.95rem', margin: '8px 0 0 0', lineHeight: '1.5' }}>
                    100% of your ${amount} tip has been routed securely to {recentShift.caregiverName}. Thank you for recognizing exceptional care!
                </p>
            </div>
        );
    }

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '20px' }}>
                <div style={{ backgroundColor: '#FEF3C7', padding: '10px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <Gift size={20} color="#D97706" />
                </div>
                <div>
                    <h3 style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>Recognize Exceptional Care</h3>
                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Send a direct, out-of-pocket gratuity.</p>
                </div>
            </div>

            <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '24px' }}>
                <div style={{ fontSize: '0.85rem', color: '#64748B', fontWeight: 700, marginBottom: '4px' }}>Recent Shift: {recentShift.date}</div>
                <div style={{ fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>{recentShift.caregiverName}</div>
                <div style={{ display: 'flex', gap: '8px', marginTop: '12px', flexWrap: 'wrap' }}>
                    {recentShift.servicesRendered.map((svc, idx) => (
                        <span key={idx} style={{ backgroundColor: '#E2E8F0', color: '#475569', fontSize: '0.75rem', padding: '2px 8px', borderRadius: '12px', fontWeight: 600 }}>
                            {svc}
                        </span>
                    ))}
                </div>
            </div>

            <div style={{ display: 'flex', gap: '12px', marginBottom: '20px' }}>
                {[5, 10, 20].map(val => (
                    <button
                        key={val}
                        onClick={() => { setAmount(val); setCustomAmount(''); }}
                        style={{
                            flex: 1, padding: '12px', borderRadius: '8px', fontWeight: 800, fontSize: '1rem', cursor: 'pointer',
                            backgroundColor: amount === val ? '#0F172A' : '#F1F5F9',
                            color: amount === val ? 'white' : '#475569',
                            border: amount === val ? '2px solid #0F172A' : '2px solid transparent',
                            transition: 'all 0.2s'
                        }}
                    >
                        ${val}
                    </button>
                ))}
            </div>

            <button 
                onClick={handleTip}
                disabled={processing || amount <= 0}
                style={{ 
                    width: '100%', padding: '14px', backgroundColor: '#4F46E5', color: 'white', 
                    border: 'none', borderRadius: '8px', fontWeight: 700, fontSize: '1.05rem', 
                    cursor: processing ? 'not-allowed' : 'pointer', display: 'flex', alignItems: 'center', 
                    justifyContent: 'center', gap: '8px', opacity: processing ? 0.7 : 1,
                    boxShadow: '0 4px 6px -1px rgba(79, 70, 229, 0.2)'
                }}
            >
                {processing ? <div className="spinner" /> : <CreditCard size={18} />}
                {processing ? 'Processing Secure Payment...' : `Send $${amount} to ${recentShift.caregiverName.split(' ')[0]}`}
            </button>
            <style>{`.spinner { width: 16px; height: 16px; border: 2px solid rgba(255,255,255,0.3); border-radius: 50%; border-top-color: white; animation: spin 1s ease-in-out infinite; } @keyframes spin { to { transform: rotate(360deg); } }`}</style>
        </div>
    );
};
