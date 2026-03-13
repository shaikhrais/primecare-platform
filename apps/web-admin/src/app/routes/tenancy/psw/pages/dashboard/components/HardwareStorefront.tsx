import React, { useState } from 'react';
import { ShoppingBag, ChevronRight, Stethoscope, HeartPulse, CreditCard } from 'lucide-react';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface ShopItem {
    id: string;
    name: string;
    price: number;
    icon: any;
    description: string;
}

export const HardwareStorefront: React.FC = () => {
    const [purchasing, setPurchasing] = useState<string | null>(null);

    const inventory: ShopItem[] = [
        { id: 'item_1', name: 'PrimeCare Premium Scrubs (Navy)', price: 45.00, icon: ShoppingBag, description: 'Antimicrobial, wrinkle-resistant 4-way stretch.' },
        { id: 'item_2', name: 'Littmann Classic III Stethoscope', price: 110.00, icon: Stethoscope, description: 'High acoustic sensitivity for performing general physical assessments.' },
        { id: 'item_3', name: 'Omron Platinum BP Monitor', price: 75.00, icon: HeartPulse, description: 'Clinically validated, Bluetooth enabled.' }
    ];

    const { showToast } = useNotification();

    const handlePurchase = async (id: string) => {
        setPurchasing(id);
        try {
            const response = await apiClient.post('/v1/psw/dashboard/hardware/purchase', { itemId: id });
            if (response.ok) {
                showToast('Item ordered successfully. Amount will be deducted from your next pay cycle.', 'success');
            } else {
                throw new Error('Failed to process purchase');
            }
        } catch (error) {
            console.error('Failed to buy hardware:', error);
            showToast('Purchase could not be processed at this time.', 'error');
        } finally {
            setPurchasing(null);
        }
    };

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', marginTop: '16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                <ShoppingBag size={20} color="#0F172A" />
                <h3 data-cy="h3-psw.hardware-storefront-0" style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>Hardware & Gear Store</h3>
            </div>
            <p style={{ color: '#64748B', fontSize: '0.85rem', marginBottom: '20px', lineHeight: '1.4' }}>
                Order agency-approved medical hardware and apparel directly to your home. 
                <strong style={{ color: '#0F172A' }}> No credit card required.</strong> Costs are automatically deducted from your upcoming bi-weekly payroll deposit.
            </p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {inventory.map(item => {
                    const Icon = item.icon;
                    return (
                        <div key={item.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', backgroundColor: '#F8FAFC' }}>
                            <div style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
                                <div style={{ padding: '12px', backgroundColor: 'white', borderRadius: '8px', border: '1px solid #CBD5E1' }}>
                                    <Icon size={24} color="#475569" />
                                </div>
                                <div>
                                    <h4 style={{ margin: 0, color: '#0F172A', fontSize: '0.95rem' }}>{item.name}</h4>
                                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.8rem' }}>{item.description}</p>
                                    <div style={{ marginTop: '8px', fontSize: '0.9rem', fontWeight: 800, color: '#059669' }}>
                                        ${item.price.toFixed(2)} <span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#94A3B8' }}>(Payroll Deduction)</span>
                                    </div>
                                </div>
                            </div>
                            <button data-cy="btn-psw.hardware-storefront-0" 
                                onClick={() => handlePurchase(item.id)}
                                disabled={purchasing !== null}
                                style={{ 
                                    padding: '8px 16px', backgroundColor: '#0F172A', color: 'white', 
                                    border: 'none', borderRadius: '6px', fontWeight: 600, cursor: purchasing !== null ? 'not-allowed' : 'pointer',
                                    display: 'flex', alignItems: 'center', gap: '6px', opacity: purchasing === item.id ? 0.7 : 1
                                }}
                            >
                                {purchasing === item.id ? 'Processing...' : '1-Click Buy'}
                                {purchasing !== item.id && <ChevronRight size={14} />}
                            </button>
                        </div>
                    )
                })}
            </div>
        </div>
    );
};
