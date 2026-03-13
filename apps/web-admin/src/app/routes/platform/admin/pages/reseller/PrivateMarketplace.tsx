import React, { useState } from 'react';

const PrivateMarketplace: React.FC = () => {
 // local state mimicking a tenant-scoped marketplace
    const [listings] = useState([
        { id: 1, title: 'Advanced Wound Care Certification', type: 'Course', provider: 'Internal Training Dept', price: '$0.00' },
        { id: 2, title: 'Weekend On-Call Overflow Coverage', type: 'B2B Service', provider: 'Apex Staffing Partner (Child Agency)', price: 'Variable Rate' },
        { id: 3, title: 'Dementia Care Protocol v2.4', type: 'Digital Asset', provider: 'Clinical Operations', price: '$0.00' }
    ]);

    return (
        <div data-cy="page.container" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FDF4FF', padding: '16px', borderRadius: '12px', fontSize: '32px' }}>
                        🏪
                    </div>
                    <div>
                        <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0', color: '#111827' }}>Private Marketplace</h1>
                        <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Internal resources, courses, and B2B services shared exclusively within your Tenant network.</p>
                    </div>
                </div>
                <button data-cy="btn-admin.private-marketplace-0"
                    style={{
                        backgroundColor: '#C026D3',
                        color: 'white',
                        padding: '10px 16px',
                        borderRadius: '8px',
                        border: 'none',
                        fontWeight: '600',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '6px'
                    }}
                >
                    ➕ Create Listing
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '24px' }}>
                {listings.map(listing => (
                    <div key={listing.id} style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E5E7EB', overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
                        <div style={{ height: '140px', backgroundColor: '#F3F4F6', display: 'flex', alignItems: 'center', justifyContent: 'center', borderBottom: '1px solid #E5E7EB' }}>
                            <span style={{ fontSize: '48px', opacity: 0.5 }}>
                                {listing.type === 'Course' ? '🎓' : listing.type === 'B2B Service' ? '🤝' : '📄'}
                            </span>
                        </div>
                        <div style={{ padding: '20px', flex: 1, display: 'flex', flexDirection: 'column' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                                <span style={{ fontSize: '12px', fontWeight: '600', color: '#C026D3', textTransform: 'uppercase', letterSpacing: '0.5px' }}>{listing.type}</span>
                                <span style={{ fontSize: '14px', fontWeight: '700', color: '#111827' }}>{listing.price}</span>
                            </div>
                            <h3 data-cy="h3-admin.private-marketplace-0" style={{ margin: '0 0 8px 0', fontSize: '16px', fontWeight: '700', color: '#111827' }}>{listing.title}</h3>
                            <p style={{ margin: '0 0 16px 0', fontSize: '14px', color: '#6B7280' }}>Provided by: <span style={{ fontWeight: '500' }}>{listing.provider}</span></p>

                            <div style={{ marginTop: 'auto' }}>
                                <button data-cy="btn-admin.private-marketplace-1" style={{ width: '100%', padding: '10px', backgroundColor: '#FDF4FF', color: '#C026D3', border: '1px solid #F0ABFC', borderRadius: '6px', fontWeight: '600', cursor: 'pointer', transition: 'all 0.2s' }}>
                                    View Details
                                </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>

            <div style={{ marginTop: '48px', padding: '24px', backgroundColor: '#F8FAFC', borderRadius: '12px', border: '1px solid #E2E8F0', display: 'flex', alignItems: 'flex-start', gap: '16px' }}>
                <div style={{ fontSize: '24px' }}>💡</div>
                <div>
                    <h4 style={{ margin: '0 0 4px 0', fontSize: '14px', fontWeight: '600', color: '#0F172A' }}>The Fractal Advantage</h4>
                    <p style={{ margin: '0', fontSize: '14px', color: '#475569', lineHeight: '1.5' }}>
                        Your Private Marketplace is isolated to your Tenant environment. Any Child Agencies you spawn via the Reseller Hub will automatically gain access to these listings, allowing you to monetize training programs and operational playbooks at scale.
                    </p>
                </div>
            </div>
        </div>
    );
};

export default PrivateMarketplace;
