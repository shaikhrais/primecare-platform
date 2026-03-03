import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';

const { ContentRegistry } = AdminRegistry;

export default function Marketplace() {
    const [listings, setListings] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchListings();
    }, []);

    const fetchListings = async () => {
        // Mock data for now until API is fully wired
        const mockListings = [
            { id: '1', title: 'Overflow Nursing Staff', tenant: 'Grace Health', price: 85, category: 'Staffing' },
            { id: '2', title: 'Compliance Audit Kit', tenant: 'SafeCare Ops', price: 250, category: 'Consulting' },
        ];
        setListings(mockListings);
        setLoading(false);
    };

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '40px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>{ContentRegistry.MARKETPLACE.TITLE}</h1>
                <p style={{ color: '#6B7280' }}>{ContentRegistry.MARKETPLACE.SUBTITLE}</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '24px' }}>
                {listings.map(item => (
                    <div key={item.id} className="pc-card" style={{ display: 'flex', flexDirection: 'column' }}>
                        <div style={{ padding: '20px', flex: 1 }}>
                            <div style={{ fontSize: '12px', fontWeight: '700', color: 'var(--brand-500)', marginBottom: '8px' }}>{item.category.toUpperCase()}</div>
                            <h3 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '4px' }}>{item.title}</h3>
                            <p style={{ fontSize: '14px', color: '#6B7280' }}>Offered by <b>{item.tenant}</b></p>
                            <div style={{ marginTop: '20px', fontSize: '20px', fontWeight: '800' }}>${item.price}<span style={{ fontSize: '14px', color: '#6B7280', fontWeight: '400' }}>{ContentRegistry.MARKETPLACE.PRICE_UNIT}</span></div>
                        </div>
                        <div style={{ borderTop: '1px solid var(--line)', padding: '16px' }}>
                            <button className="btn btn-primary" style={{ width: '100%' }}>{ContentRegistry.MARKETPLACE.INQUIRE_BTN}</button>
                        </div>
                    </div>
                ))}

                <div className="pc-card" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', border: '2px dashed var(--line)', background: 'none' }}>
                    <div style={{ textAlign: 'center', padding: '40px' }}>
                        <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>📦</div>
                        <h4 style={{ fontWeight: '700' }}>{ContentRegistry.MARKETPLACE.OFFER_TITLE}</h4>
                        <p style={{ color: '#6B7280', fontSize: '14px', marginBottom: '1.5rem' }}>{ContentRegistry.MARKETPLACE.OFFER_DESC}</p>
                        <button className="btn">{ContentRegistry.MARKETPLACE.CREATE_BTN}</button>
                    </div>
                </div>
            </div>
        </div>
    );
}
