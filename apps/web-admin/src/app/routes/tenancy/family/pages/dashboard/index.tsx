import React from 'react';

// Family Portal Components
import { CareUpdatesFeed } from './components/CareUpdatesFeed';
import { LiveETATracker } from './components/LiveETATracker';
import { CoPaySlider } from './components/CoPaySlider';
import { CalendarExportList } from './components/CalendarExportList';
import { iMessageThread } from './components/iMessageThread';
import { MilestoneCelebration } from '@/shared/components/modals/MilestoneCelebration';

export default function FamilyDashboard() {
    
    return (
        <div style={{ padding: '0 0 100px 0', maxWidth: '1400px', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: '48px' }}>
            
            <header>
                <h1 style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A', margin: '0 0 12px 0', lineHeight: 1.1 }}>
                    Care Portal:<br />
                    <span style={{ color: '#8B5CF6' }}>Johnathan Doe Sr.</span>
                </h1>
                <p style={{ fontSize: '1.25rem', color: '#64748B', margin: 0 }}>Monitor updates, track visits, and coordinate logistics with the PrimeCare team.</p>
            </header>

            {/* Top row: Map & Logistics */}
            <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(450px, 1fr))', gap: '32px' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>
                    <LiveETATracker />
                    <CoPaySlider 
                        totalInvoiceAmount={1450.00}
                        primaryPayerName="David Doe"
                        secondaryPayerName="Susan Smith"
                    />
                </div>
                
                <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>
                    <CalendarExportList />
                </div>
            </section>

            {/* Bottom Row: Social & Chat */}
            <section style={{ display: 'grid', gridTemplateColumns: '1fr 400px', gap: '32px' }}>
                <CareUpdatesFeed />
                
                <div style={{ position: 'sticky', top: '96px', alignSelf: 'start' }}>
                    <iMessageThread />
                </div>
            </section>

            {/* This renders globally, triggering on mount for demonstration purposes. */}
            <MilestoneCelebration />

        </div>
    );
};
