import React from 'react';
import { useTranslation } from 'react-i18next';
import { useAuth } from '@/shared/context/AuthContext';

// Client Specific Components (Zero-Data Grid Architecture)
import { WhosComingCard } from './components/WhosComingCard';
import { CareJourneyMap } from './components/CareJourneyMap';
import { FundingThermometer } from './components/FundingThermometer';
import { TelehealthLauncher } from './components/TelehealthLauncher';
import { PostVisitRatingModal } from '@/shared/components/modals/PostVisitRatingModal';

export default function ClientDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();
    
    const clientName = user?.firstName || 'Marjorie';

    return (
        <div style={{ padding: '0 0 100px 0', maxWidth: '1200px', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: '48px' }}>
            
            <header>
                <h1 style={{ fontSize: '3rem', fontWeight: 900, color: '#0F172A', margin: '0 0 12px 0', lineHeight: 1.1 }}>
                    Good afternoon,<br />
                    <span style={{ color: '#3B82F6' }}>{clientName}</span>.
                </h1>
                <p style={{ fontSize: '1.5rem', color: '#64748B', margin: 0 }}>Here is your care summary for today.</p>
            </header>

            {/* Primary Action Area */}
            <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '32px' }}>
                <WhosComingCard 
                    workerName="Sarah Jenkins"
                    workerRole="Registered Nurse (RN)"
                    arrivalTime="2:30 PM (In 45 mins)"
                    bio="I love gardening, dogs, and making sure my patients are comfortable! Looking forward to our visit today."
                    imageUrl="https://i.pravatar.cc/300?img=47"
                />
                <TelehealthLauncher />
            </section>

            {/* Visual Tracking Area */}
            <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '32px' }}>
                <CareJourneyMap />
                <FundingThermometer 
                    totalHours={90}
                    hoursUsed={72}
                />
            </section>

            {/* Triggering this on mount for the demonstration of the zero-friction pattern */}
            <PostVisitRatingModal />
            
        </div>
    );
}
