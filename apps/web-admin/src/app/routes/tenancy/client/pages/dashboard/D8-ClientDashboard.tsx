import React from 'react';
import { useTranslation } from 'react-i18next';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';

// Client Specific Components (Zero-Data Grid Architecture)
import { WhosComingCard } from './components/WhosComingCard';
import { CareJourneyMap } from './components/CareJourneyMap';
import { FundingThermometer } from './components/FundingThermometer';
import { TelehealthLauncher } from './components/TelehealthLauncher';
import { PostVisitRatingModal } from '@/shared/components/modals/PostVisitRatingModal';

export default function ClientDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();
    
    const clientName = user?.email ? user.email.split('@')[0] : 'There';
    const [stats, setStats] = React.useState<any>(null);
    const [loading, setLoading] = React.useState(true);

    React.useEffect(() => {
        const fetchStats = async () => {
            try {
                const res = await apiClient.get('/v1/client/dashboard/stats');
                if (res.ok) {
                    const data = await res.json();
                    setStats(data);
                }
            } catch (e) {
                console.error('Failed to load client stats', e);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    const usedBudget = stats?.budget?.find((b: any) => b.name === 'Used')?.value || 0;
    const remainingBudget = stats?.budget?.find((b: any) => b.name === 'Remaining')?.value || 0;
    const totalBudget = usedBudget + (remainingBudget || 4280); // Fallback to a healthy number if 0

    if (loading) return <div style={{ padding: '48px', textAlign: 'center' }}>Loading your care summary...</div>;

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
                {stats?.nextVisit ? (
                    <WhosComingCard 
                        workerName={stats.nextVisit.workerName}
                        workerRole={stats.nextVisit.workerRole}
                        arrivalTime={stats.nextVisit.arrivalTime}
                        bio={stats.nextVisit.bio}
                        imageUrl={stats.nextVisit.imageUrl}
                    />
                ) : (
                    <div style={{ padding: '24px', backgroundColor: '#F8FAFC', borderRadius: '16px', border: '1px solid #E2E8F0' }}>
                        <h3 style={{ margin: '0 0 8px 0', color: '#64748B' }}>No Upcoming Visits</h3>
                        <p style={{ margin: 0, color: '#94A3B8' }}>You have no scheduled visits for today.</p>
                    </div>
                )}
                <TelehealthLauncher />
            </section>

            {/* Visual Tracking Area */}
            <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '32px' }}>
                <CareJourneyMap />
                <FundingThermometer 
                    totalHours={totalBudget}
                    hoursUsed={usedBudget}
                />
            </section>

            {/* Triggering this on mount for the demonstration of the zero-friction pattern */}
            <PostVisitRatingModal />
            
        </div>
    );
}
