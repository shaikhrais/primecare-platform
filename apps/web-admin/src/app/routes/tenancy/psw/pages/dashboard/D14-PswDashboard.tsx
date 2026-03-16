import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useAuth } from '@/shared/context/AuthContext';
import { apiClient } from '@/shared/utils/apiClient';
import { PageActionBar } from '@/shared/components/ui/PageActionBar';
import { useRealtimeQuery } from '@/shared/hooks/useRealtimeQuery';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { LiveIndicator } from '@/shared/components/ui/LiveIndicator';
import { useQueryClient } from '@tanstack/react-query';
import { PswStats } from './components/PswStats';
import { ShiftList } from './components/ShiftList';
import { ComplianceSection } from './components/ComplianceSection';
import { WellnessPulse } from './components/WellnessPulse';
import { ReliabilityStreak } from './components/ReliabilityStreak';
import { DirectDispatchChat } from './components/DirectDispatchChat';
import { EarningsProjections } from './components/EarningsProjections';
import { AccessibilityControls } from './components/AccessibilityControls';
import { DigitalIdBadge } from './components/DigitalIdBadge';
import { BurnoutPredictor } from './components/BurnoutPredictor';
import { PeerKudosSystem } from './components/PeerKudosSystem';
import { BackgroundSettingsModal } from './components/BackgroundSettingsModal';
import { Sparkline } from '@/shared/components/charts/Sparkline';
import { useTranslation } from 'react-i18next';
import { MessageSquare, Settings } from 'lucide-react';
import { type Shift, handleCheckIn, handleCheckOut } from './pswHandlers';

const { ContentRegistry } = AdminRegistry;

export default function PswDashboard() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const navigate = useNavigate();
    const { user } = useAuth();
    const [isChatOpen, setIsChatOpen] = useState(false);
    const [isIdBadgeOpen, setIsIdBadgeOpen] = useState(false);
    const [isSettingsOpen, setIsSettingsOpen] = useState(false);

    // TanStack Query: live dashboard stats (15s polling — default interval)
    const { data: chartData = null, isLive, isStreaming, lastUpdated } = useRealtimeQuery<any>(
        AdminRegistry.ApiRegistry.PSW.DASHBOARD_STATS,
        { queryKey: ['psw', 'dashboard-stats'] }
    );

    // TanStack Query: shift list
    const { data: shifts = [], isLoading: shiftsLoading } = useRegistryQuery<Shift[]>(
        AdminRegistry.ApiRegistry.PSW.VISITS,
        { queryKey: ['psw', 'shifts'], staleTime: 30_000 }
    );

    const loading = shiftsLoading;
    const queryClient = useQueryClient();

    // Provide setShifts & refresh for legacy shift handlers
    const [localShifts, setLocalShifts] = useState<Shift[]>([]);
    React.useEffect(() => { setLocalShifts(shifts); }, [shifts]);
    const refresh = () => { queryClient.invalidateQueries({ queryKey: ['psw', 'shifts'] }); };

    if (loading) return <div style={{ padding: '2rem', textAlign: 'center' }}>Loading PSW Dashboard...</div>;

    return (
        <div data-cy="page.container" role="main" aria-label="PSW Dashboard" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto', boxSizing: 'border-box' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <AccessibilityControls onOpenIdBadge={() => setIsIdBadgeOpen(true)} />
                <button data-cy="btn-psw.psw-dashboard-0" onClick={() => setIsSettingsOpen(true)} style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '8px', color: '#6B7280' }}><Settings size={22} /></button>
            </div>

            <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between', alignItems: 'center', gap: '1.5rem', marginBottom: '2.5rem' }}>
                <div style={{ flex: '1 1 300px' }}>
                    <h1 data-cy="page.title" style={{ margin: '0', fontSize: '2.5rem', fontWeight: 800, color: '#000000', lineHeight: 1.1 }}>{user?.tenantId ? 'My Provider Dashboard' : t(ContentRegistry.PSW_DASHBOARD.TITLE)}</h1>
                    <p data-cy="page.subtitle" style={{ margin: '12px 0 0 0', color: '#4B5563', fontSize: '1.1rem' }}>{user?.email ? `${user.email} • Independent Provider` : t(ContentRegistry.PSW_DASHBOARD.SUBTITLE)}</p>
                    <LiveIndicator isLive={isLive} isStreaming={isStreaming} lastUpdated={lastUpdated} />
                </div>
                <PageActionBar pageId="psw.dashboard" size="sm" handlers={{
                    'btn-psw-incident-report': async () => { try { const r: any = await apiClient.post('/v1/psw/dashboard/incident', {}); showToast(r?.message || 'Incident report flow launched.', 'success'); } catch { showToast('Failed to trigger incident flow.', 'error'); } },
                    'btn-psw-wellness-pulse': async () => { try { const r: any = await apiClient.post('/v1/psw/dashboard/wellness', {}); showToast(r?.message || 'Wellness pulse recorded.', 'success'); } catch { showToast('Failed to log wellness pulse.', 'error'); } },
                }} />
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px', marginBottom: '32px' }}>
                <EarningsProjections currentEarnings={chartData?.earnings?.[chartData.earnings.length - 1]?.earnings || 0} targetEarnings={1000} trendData={chartData?.earnings?.map((e: any) => e.earnings) || [0]} />
                <div className="pc-card" style={{ padding: '20px', borderLeft: '4px solid #3b82f6', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                    <div><div style={{ color: 'var(--text-300)', fontSize: '0.75rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '4px' }}>Hours Logged</div><div style={{ fontSize: '2.2rem', fontWeight: 900, color: 'var(--text-100)', letterSpacing: '1px' }}>{chartData?.hoursLogged || 0}</div></div>
                    <div style={{ marginBottom: '8px' }}><Sparkline data={chartData?.earnings?.map((e: any) => e.earnings) || [0]} color="#3b82f6" width={80} height={24} /></div>
                </div>
                <ReliabilityStreak score={98} streakDays={chartData?.currentStreak || 0} trendData={[95, 96, 96, 97, 98, 97, 98]} />
            </div>

            <PswStats chartData={chartData} />
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '2rem', marginBottom: '2rem' }}><PeerKudosSystem /><BurnoutPredictor hoursLoggedThisWeek={chartData?.hoursLogged || 0} consecutiveDaysWorked={chartData?.currentStreak || 0} intensityScore={70} /></div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '2rem' }}>
                <div style={{ gridColumn: '1 / -1' }}><ShiftList shifts={localShifts} loading={loading} isMobile={false} onCheckIn={(id) => handleCheckIn(id, localShifts, setLocalShifts, showToast as any, refresh, t)} onCheckOut={(id) => handleCheckOut(id, localShifts, setLocalShifts, showToast as any, refresh, t)} /></div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem', minWidth: '350px' }}><ComplianceSection /><WellnessPulse /></div>
            </div>

            {isIdBadgeOpen && <DigitalIdBadge pswName={user?.email || 'John Doe'} pswRole={user?.roles?.[0] ? 'Personal Support Worker' : 'Care Provider'} agencyName="PrimeCare Independent Network" onClose={() => setIsIdBadgeOpen(false)} />}
            {isSettingsOpen && <BackgroundSettingsModal onClose={() => setIsSettingsOpen(false)} />}
            {!isChatOpen && (<button data-cy="btn-psw.psw-dashboard-4" onClick={() => setIsChatOpen(true)} style={{ position: 'fixed', bottom: '80px', right: '20px', width: '60px', height: '60px', backgroundColor: '#3B82F6', color: 'white', border: 'none', borderRadius: '30px', boxShadow: '0 10px 15px -3px rgba(0,0,0,0.3)', display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer', zIndex: 9997 }}><MessageSquare size={28} /></button>)}
            <DirectDispatchChat isOpen={isChatOpen} onClose={() => setIsChatOpen(false)} />
        </div>
    );
}
