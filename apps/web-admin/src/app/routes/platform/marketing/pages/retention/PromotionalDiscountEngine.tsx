import React, { useState } from 'react';
import { Tag, Copy, CalendarOff, Ticket, DollarSign, Percent, CheckCircle2 } from 'lucide-react';

interface PromoCode {
    id: string;
    code: string;
    discountType: 'PERCENTAGE' | 'FIXED_AMOUNT';
    value: number;
    expirationDate: string;
    maxRedemptions: number;
    currentRedemptions: number;
    status: 'ACTIVE' | 'EXPIRED' | 'DEPLETED';
}

export const PromotionalDiscountEngine: React.FC = () => {
    const [promos, setPromos] = useState<PromoCode[]>([
        { id: '1', code: 'FREE_ASSESS_2026', discountType: 'FIXED_AMOUNT', value: 150, expirationDate: '2026-12-31', maxRedemptions: 50, currentRedemptions: 12, status: 'ACTIVE' },
        { id: '2', code: 'WINTER_RESPITE_10', discountType: 'PERCENTAGE', value: 10, expirationDate: '2026-03-01', maxRedemptions: 20, currentRedemptions: 20, status: 'DEPLETED' },
        { id: '3', code: 'VETERAN_CARE', discountType: 'PERCENTAGE', value: 15, expirationDate: '2099-12-31', maxRedemptions: 9999, currentRedemptions: 145, status: 'ACTIVE' }
    ]);

    const [newCode, setNewCode] = useState('');
    const [discountType, setDiscountType] = useState<'PERCENTAGE' | 'FIXED_AMOUNT'>('PERCENTAGE');
    const [discountValue, setDiscountValue] = useState('');
    
    const [copiedId, setCopiedId] = useState<string | null>(null);

    const handleCopy = (code: string, id: string) => {
        navigator.clipboard.writeText(code);
        setCopiedId(id);
        setTimeout(() => setCopiedId(null), 2000);
    };

    const handleGenerate = () => {
        const randomString = Math.random().toString(36).substring(2, 8).toUpperCase();
        setNewCode(`PROMO_${randomString}`);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF9C3', padding: '12px', borderRadius: '8px', border: '1px solid #FEF08A' }}>
                        <Ticket size={28} color="#CA8A04" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Promotional Discount Engine</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Generate expiring, trackable coupon codes for the sales team to close hesitant families.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                {/* Generator Form */}
                <div style={{ flex: '0 0 350px', backgroundColor: '#F8FAFC', borderRadius: '12px', padding: '24px', border: '1px solid #E2E8F0', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                     <h4 style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800, borderBottom: '2px solid #E2E8F0', paddingBottom: '12px' }}>Create New Promo Code</h4>
                     
                     <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Code Phrase</label>
                        <div style={{ display: 'flex', gap: '8px' }}>
                            <input 
                                type="text" 
                                value={newCode}
                                onChange={(e) => setNewCode(e.target.value.toUpperCase())}
                                placeholder="e.g., SUMMER50"
                                style={{ flex: 1, padding: '10px', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '1rem', boxSizing: 'border-box', fontFamily: 'monospace' }}
                            />
                            <button onClick={handleGenerate} style={{ padding: '10px', backgroundColor: '#E2E8F0', color: '#334155', border: 'none', borderRadius: '6px', fontWeight: 700, cursor: 'pointer' }}>Auto</button>
                        </div>
                     </div>

                     <div style={{ display: 'flex', gap: '12px' }}>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Type</label>
                            <select value={discountType} onChange={(e: any) => setDiscountType(e.target.value)} style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '0.9rem' }}>
                                <option value="PERCENTAGE">% Off (Monthly)</option>
                                <option value="FIXED_AMOUNT">$ Off (One-time)</option>
                            </select>
                        </div>
                        <div style={{ flex: 1 }}>
                            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#334155', display: 'block', marginBottom: '6px' }}>Value</label>
                            <input type="number" value={discountValue} onChange={(e) => setDiscountValue(e.target.value)} placeholder="e.g., 10" style={{ width: '100%', padding: '10px', borderRadius: '6px', border: '1px solid #CBD5E1', fontSize: '0.9rem', boxSizing: 'border-box' }}/>
                        </div>
                     </div>

                     <button style={{ width: '100%', padding: '12px', backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '6px', fontSize: '0.95rem', fontWeight: 800, cursor: 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '8px', marginTop: '8px' }}>
                        <Tag size={18} /> GENERATE LIVE CODE
                    </button>
                </div>

                {/* Live Codes Ledger */}
                <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Active Promo Ledger</div>
                    
                    {promos.map(promo => {
                        const isDepleted = promo.status === 'DEPLETED';
                        
                        return (
                            <div key={promo.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '16px', backgroundColor: isDepleted ? '#F8FAFC' : 'white', border: `1px solid ${isDepleted ? '#E2E8F0' : '#CBD5E1'}`, borderRadius: '8px', opacity: isDepleted ? 0.6 : 1 }}>
                                
                                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                                    <div style={{ backgroundColor: isDepleted ? '#E2E8F0' : '#EFF6FF', padding: '12px', borderRadius: '8px', color: isDepleted ? '#64748B' : '#1D4ED8', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', minWidth: '60px' }}>
                                        <div style={{ fontSize: '1.2rem', fontWeight: 900 }}>
                                            {promo.discountType === 'PERCENTAGE' ? `${promo.value}%` : `$${promo.value}`}
                                        </div>
                                        <div style={{ fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase' }}>OFF</div>
                                    </div>
                                    
                                    <div>
                                        <div style={{ fontFamily: 'monospace', fontSize: '1.2rem', fontWeight: 900, color: '#0F172A', marginBottom: '4px' }}>{promo.code}</div>
                                        <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', gap: '12px' }}>
                                            <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}><CalendarOff size={12}/> Expires: {promo.expirationDate}</span>
                                            <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                                <Users size={12}/> {promo.currentRedemptions} / {promo.maxRedemptions} Claimed
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                                    {isDepleted ? (
                                        <div style={{ fontSize: '0.8rem', color: '#DC2626', fontWeight: 800, padding: '4px 12px', backgroundColor: '#FEF2F2', borderRadius: '4px' }}>DEPLETED</div>
                                    ) : (
                                        <div style={{ fontSize: '0.8rem', color: '#16A34A', fontWeight: 800, padding: '4px 12px', backgroundColor: '#F0FDF4', borderRadius: '4px' }}>ACTIVE</div>
                                    )}
                                    
                                    <button 
                                        onClick={() => handleCopy(promo.code, promo.id)}
                                        disabled={isDepleted}
                                        style={{ backgroundColor: 'transparent', color: '#64748B', border: '1px solid #CBD5E1', borderRadius: '6px', padding: '8px', cursor: isDepleted ? 'not-allowed' : 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}
                                        title="Copy Code"
                                    >
                                        {copiedId === promo.id ? <CheckCircle2 size={16} color="#10B981" /> : <Copy size={16} />}
                                    </button>
                                </div>

                            </div>
                        );
                    })}
                </div>
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Sales Enablement:</strong> When a family is hesitant to sign a $5,000/mo contract, the local sales rep needs leverage. This tool allows the CMO to generate a highly restricted coupon code (e.g., "Waive the $150 Nurse Assessment Fee"). By setting `maxRedemptions` to 5, it creates extreme urgency, forcing the family to sign today before the coupons run out.
            </div>
        </div>
    );
};
