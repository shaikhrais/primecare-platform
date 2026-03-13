import React, { useState } from 'react';
import { Store, Globe, RefreshCw, CheckCircle, Image as ImageIcon, BriefcaseMedical } from 'lucide-react';

interface BusinessListing {
    id: string;
    locationName: string;
    address: string;
    syncStatus: 'SYNCED' | 'PENDING' | 'FAILED';
    lastUpdate: string;
}

export const GoogleBusinessSync: React.FC = () => {
    const [listings, setListings] = useState<BusinessListing[]>([
        { id: '1', locationName: 'PrimeCare HQ', address: '100 Main St', syncStatus: 'SYNCED', lastUpdate: 'Just now' },
        { id: '2', locationName: 'PrimeCare Upper East', address: '445 West Blvd', syncStatus: 'SYNCED', lastUpdate: 'Just now' },
        { id: '3', locationName: 'PrimeCare Suburban', address: '99 Valley Rd', syncStatus: 'PENDING', lastUpdate: '2 hours ago' },
        { id: '4', locationName: 'PrimeCare Westside', address: '12 Medical Row', syncStatus: 'FAILED', lastUpdate: '1 day ago' }
    ]);

    const [isPushing, setIsPushing] = useState(false);

    const handleBulkPush = () => {
        setIsPushing(true);
        setTimeout(() => {
            setListings(listings.map(l => ({ ...l, syncStatus: 'SYNCED', lastUpdate: 'Just now' })));
            setIsPushing(false);
        }, 1500);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#E0F2FE', padding: '12px', borderRadius: '8px' }}>
                        <Store size={28} color="#0284C7" />
                    </div>
                    <div>
                        <h3 data-cy="h3-google-business-sync-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Google Business Profile Multi-Sync</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Push hours, holiday updates, and COVID-19 compliance to 20+ local listings instantly.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Control Panel */}
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    <h4 style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800, borderBottom: '1px solid #CBD5E1', paddingBottom: '12px' }}>Bulk Update Global Assets</h4>

                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}><BriefcaseMedical size={16}/> Global Agency Announcement</label>
                        <textarea data-cy="textarea-google-business-sync" placeholder="e.g., We are offering priority Intake for flu season..." style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', outline: 'none', resize: 'vertical', minHeight: '80px', boxSizing: 'border-box' }}></textarea>
                    </div>

                    <div>
                        <label style={{ fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}><ImageIcon size={16}/> Push New Branding Photos</label>
                        <div style={{ border: '2px dashed #CBD5E1', padding: '16px', borderRadius: '8px', textAlign: 'center', backgroundColor: 'white', color: '#64748B', cursor: 'pointer' }}>
                            Click to upload hero images...
                        </div>
                    </div>

                    <button data-cy="btn-google-business-sync-0" 
                        onClick={handleBulkPush}
                        disabled={isPushing}
                        style={{ backgroundColor: '#0284C7', color: 'white', border: 'none', borderRadius: '8px', padding: '16px', fontWeight: 800, fontSize: '1rem', cursor: isPushing ? 'wait' : 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px', marginTop: '12px' }}
                    >
                        {isPushing ? <RefreshCw size={20} className="animate-spin" /> : <Globe size={20} />} 
                        {isPushing ? 'SYNCING TO GOOGLE API...' : 'PUSH TO ALL LISTINGS'}
                    </button>
                    
                    <div style={{ fontSize: '0.8rem', color: '#64748B', textAlign: 'center' }}>Overrides local franchise data. Changes may take 24hrs to reflect on Maps.</div>
                </div>

                {/* Status List */}
                <div style={{ flex: 1 }}>
                     <h4 style={{ margin: '0 0 16px 0', fontSize: '1rem', color: '#334155', fontWeight: 800 }}>Sub-Location Sync Status</h4>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        {listings.map(listing => (
                            <div key={listing.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px 16px', border: '1px solid #E2E8F0', borderRadius: '8px', backgroundColor: listing.syncStatus === 'FAILED' ? '#FEF2F2' : 'white' }}>
                                <div>
                                    <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.95rem' }}>{listing.locationName}</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{listing.address}</div>
                                </div>
                                <div style={{ textAlign: 'right' }}>
                                    {listing.syncStatus === 'SYNCED' && <div style={{ color: '#10B981', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700, fontSize: '0.85rem' }}><CheckCircle size={14}/> LIVE</div>}
                                    {listing.syncStatus === 'PENDING' && <div style={{ color: '#CA8A04', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700, fontSize: '0.85rem' }}><RefreshCw size={14} className="animate-spin"/> PENDING</div>}
                                    {listing.syncStatus === 'FAILED' && <div style={{ color: '#DC2626', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700, fontSize: '0.85rem' }}>AUTH ERROR</div>}
                                    <div style={{ fontSize: '0.75rem', color: '#94A3B8', marginTop: '4px' }}>{listing.lastUpdate}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};
