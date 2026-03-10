import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';
import { VitalHistoryTooltip } from './components/VitalHistoryTooltip';
import { InAppTimer } from './components/InAppTimer';
import { QuickReportMacros } from './components/QuickReportMacros';

const ConfettiOverlay = () => {
    return (
        <div style={{
            position: 'fixed', top: 0, left: 0, width: '100vw', height: '100vh', pointerEvents: 'none', zIndex: 9999,
            display: 'flex', justifyContent: 'center', alignItems: 'center', backgroundColor: 'rgba(255, 255, 255, 0.85)'
        }}>
            <div style={{ fontSize: '4rem', textAlign: 'center', animation: 'popIn 0.5s ease-out forwards' }}>
                🎉 Great Job! 🎉<br />
                <span style={{ fontSize: '1.5rem', color: '#10B981' }}>100% Care Plan Completed</span>
            </div>
            <style>{`
                @keyframes popIn {
                    0% { transform: scale(0.5); opacity: 0; }
                    80% { transform: scale(1.1); opacity: 1; }
                    100% { transform: scale(1); opacity: 1; }
                }
            `}</style>
        </div>
    );
};
import './LiveVisit.css';

const CONTENT = ContentRegistry.PSW_LIVE_VISIT;

export default function LiveVisit() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [status, setStatus] = useState<'idle' | 'checked_in' | 'completed'>('idle');
    const [currentTime, setCurrentTime] = useState(new Date().toLocaleTimeString());
    const [elapsed, setElapsed] = useState(0);
    const touchStartXRef = React.useRef<number | null>(null);
    const [visit, setVisit] = useState<any>(null);
    const [tasks, setTasks] = useState([
        { id: '1', label: 'Medication Administration', done: false, isStandard: true },
        { id: '2', label: 'Mobility Support & Transfers', done: false, isStandard: true },
        { id: '3', label: 'Hydration & Nutrition Check', done: false, isStandard: true },
        { id: '4', label: 'Documentation Sink', done: false, isStandard: false },
        { id: '5', label: 'ROM Exercises (15 mins)', done: false, isStandard: false, requiresTimer: true },
    ]);
    const [visitNotes, setVisitNotes] = useState('');
    const [showVitalHistory, setShowVitalHistory] = useState(false);
    const [showConfetti, setShowConfetti] = useState(false);

    useEffect(() => {
        const controller = new AbortController();
        const fetchVisit = async () => {
            try {
                const response = await apiClient.get(AdminRegistry.ApiRegistry.PLATFORM.ADMIN.VISITS_UPDATE(id!), { signal: controller.signal });
                if (response.ok) {
                    const data = await response.json();
                    setVisit(data);
                }
            } catch (error: unknown) {
                if ((error as Error).name !== 'AbortError') {
                    console.error('Error fetching visit details:', error);
                }
            }
        };
        if (id) fetchVisit();
        return () => controller.abort();
    }, [id]);

    useEffect(() => {
        const timer = setInterval(() => setCurrentTime(new Date().toLocaleTimeString()), 1000);
        return () => clearInterval(timer);
    }, []);

    useEffect(() => {
        let timer: any;
        if (status === 'checked_in') {
            timer = setInterval(() => setElapsed(e => e + 1), 1000);
        }
        return () => clearInterval(timer);
    }, [status]);

    const formatElapsed = (seconds: number) => {
        const h = Math.floor(seconds / 3600).toString().padStart(2, '0');
        const m = Math.floor((seconds % 3600) / 60).toString().padStart(2, '0');
        const s = (seconds % 60).toString().padStart(2, '0');
        return `${h}:${m}:${s}`;
    };

    const toggleTask = (taskId: string) => {
        setTasks(prev => prev.map(t => t.id === taskId ? { ...t, done: !t.done } : t));
    };

    const applySmartDefaults = () => {
        setTasks(prev => prev.map(t => t.isStandard ? { ...t, done: true } : t));
        showToast('Standard ADLs pre-checked', 'info');
    };

    useEffect(() => {
        // Since we check in via the dedicated screen, we should default to 'checked_in'
        // or fetch the actual status from the API. For this UI refinement, 
        // we'll assume navigation here means we are or should be checked in.
        setStatus('checked_in');
    }, []);

    // Effect for checking 100% completion to trigger confetti gamification
    useEffect(() => {
        if (tasks.length > 0 && tasks.every(t => t.done)) {
            if (!sessionStorage.getItem(`confetti_${id}`)) {
                setShowConfetti(true);
                sessionStorage.setItem(`confetti_${id}`, 'true');
                setTimeout(() => setShowConfetti(false), 3000);
            }
        }
    }, [tasks, id]);

    const handleCheckOut = async () => {
        if (!navigator.geolocation) {
            showToast(CONTENT.MESSAGES.GEOLOCATION_NOT_SUPPORTED, 'error');
            return;
        }

        navigator.geolocation.getCurrentPosition(async (pos) => {
            try {
                const response = await apiClient.post(AdminRegistry.ApiRegistry.TENANCY.PSW.CHECK_OUT(id!), {
                    lat: pos.coords.latitude,
                    lng: pos.coords.longitude,
                    accuracy: pos.coords.accuracy
                });

                if (response.ok) {
                    setStatus('completed');
                    showToast(CONTENT.MESSAGES.SUCCESS, 'success');
                    navigate(AdminRegistry.RouteRegistry.PSW.HANDOVER);
                } else {
                    showToast(CONTENT.MESSAGES.CHECKOUT_ERROR, 'error');
                }
            } catch (error) {
                showToast(CONTENT.MESSAGES.NETWORK_ERROR, 'error');
            }
        });
    };

    const [loading, setLoading] = useState(false);

    const handleDailyEntrySubmit = async () => {
        setLoading(true);
        try {
            const response = await apiClient.post(AdminRegistry.ApiRegistry.TENANCY.PSW.DAILY_ENTRY_SUBMIT, {
                clientId: 'visit-context-client', // In a real application, this would come from the visit object
                visitId: id,
                adlData: tasks.filter(t => t.done).map(t => t.label),
                notes: visitNotes,
                status: 'SUBMITTED'
            });

            if (response.ok) {
                showToast(CONTENT.MESSAGES.DAILY_ENTRY_SUCCESS, 'success');
            } else {
                showToast(CONTENT.MESSAGES.DAILY_ENTRY_ERROR, 'error');
            }
        } catch (error) {
            showToast(CONTENT.MESSAGES.NETWORK_ERROR, 'error');
        } finally {
            setLoading(false);
        }
    };

    const checkInBtn = AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-check-in');
    const checkOutBtn = AdminRegistry.ButtonRegistry.find(b => b.id === 'btn-psw-check-out');
    const COMMON = ContentRegistry.COMMON;

    return (
        <div className="live-visit-container">
            {showConfetti && <ConfettiOverlay />}
            <header className="live-header">
                <div className="header-left">
                    <div className="header-icon">
                        {status === 'checked_in' ? '⏱️' : '🏠'}
                    </div>
                    <div className="header-text">
                        <h1>{status === 'checked_in' ? CONTENT.HEADER.IN_PROGRESS : CONTENT.HEADER.IDLE}</h1>
                        <p>{visit?.client?.fullName || COMMON.FALLBACKS.REGISTRY_NODE} • {visit?.service?.name || COMMON.FALLBACKS.CARE_SERVICE}</p>
                    </div>
                </div>
                <div className="header-right">
                    <div className="clock-face">{currentTime}</div>
                    <div className="clock-label">{CONTENT.HEADER.STAMP}</div>
                </div>
            </header>

            <div className="session-block session-active">
                <div className="pulse-bg" />
                <div className="active-grid">
                    <div className="active-top-bar">
                        <div>
                            <div className="timer-label">{CONTENT.CHECKOUT.DURATION}</div>
                            <div className="timer-value">{formatElapsed(elapsed)}</div>
                        </div>
                        <div className="gps-status">
                            <div className="timer-label">{CONTENT.CHECKOUT.GPS_PULSE}</div>
                            <div className="gps-badge">
                                <div className="gps-dot" />
                                <span className="gps-text">{CONTENT.CHECKOUT.GPS_LOCKED}</span>
                            </div>
                        </div>
                    </div>

                    <div className="tasks-container">
                        <div className="tasks-header-row" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                            <h3 className="tasks-title" style={{ margin: 0 }}>{CONTENT.CLINICAL.TITLE}</h3>
                            <button
                                onClick={applySmartDefaults}
                                style={{
                                    backgroundColor: '#E0E7FF',
                                    color: '#4F46E5',
                                    border: 'none',
                                    padding: '6px 12px',
                                    borderRadius: '16px',
                                    fontSize: '0.8rem',
                                    fontWeight: 700,
                                    cursor: 'pointer'
                                }}
                            >
                                ⚡ Smart Defaults
                            </button>
                        </div>
                        {tasks.map(task => (
                            <React.Fragment key={task.id}>
                                <div
                                    className={`task-item ${task.done ? 'done' : ''}`}
                                    onClick={() => toggleTask(task.id)}
                                    onTouchStart={(e) => { touchStartXRef.current = e.touches[0].clientX; }}
                                    onTouchMove={(e) => {
                                        if (touchStartXRef.current === null) return;
                                        const diff = e.touches[0].clientX - touchStartXRef.current;
                                        if (diff > 80 || diff < -80) {
                                            toggleTask(task.id);
                                            touchStartXRef.current = null;
                                            if (window.navigator?.vibrate) { window.navigator.vibrate(50); }
                                        }
                                    }}
                                    onTouchEnd={() => { touchStartXRef.current = null; }}
                                    style={{ touchAction: 'pan-y' }}
                                >
                                    <span className="task-label">{task.label} <span style={{ fontSize: '0.7rem', color: '#94a3b8', fontStyle: 'italic', display: 'block' }}>Swipe or tap to complete</span></span>
                                    <div className="task-checkbox">
                                        {task.done ? '✓' : ''}
                                    </div>
                                </div>
                                {(task as any).requiresTimer && (
                                    <div style={{ padding: '0 16px 16px 16px' }} onClick={(e) => e.stopPropagation()}>
                                        <InAppTimer onSave={(seconds) => {
                                            toggleTask(task.id);
                                            showToast(`Timer saved: ${Math.floor(seconds / 60)}m ${seconds % 60}s`, 'success');
                                        }} />
                                    </div>
                                )}
                            </React.Fragment>
                        ))}

                        <div style={{ marginTop: '24px', paddingTop: '24px', borderTop: '1px solid #E2E8F0' }}>
                            <h3 style={{ fontSize: '1.2rem', margin: '0 0 16px 0', color: '#0F172A' }}>Daily Notes</h3>
                            <QuickReportMacros onSelectMacro={(m) => setVisitNotes(prev => prev ? `${prev} ${m}` : m)} />
                            <textarea
                                value={visitNotes}
                                onChange={(e) => setVisitNotes(e.target.value)}
                                placeholder="Add any additional observations..."
                                style={{
                                    width: '100%',
                                    minHeight: '100px',
                                    padding: '12px',
                                    borderRadius: '8px',
                                    border: '1px solid #CBD5E1',
                                    fontFamily: 'inherit',
                                    resize: 'vertical',
                                    marginBottom: '16px'
                                }}
                            />
                            <button
                                onClick={handleDailyEntrySubmit}
                                disabled={loading}
                                style={{
                                    width: '100%',
                                    padding: '16px',
                                    backgroundColor: '#0F172A',
                                    color: 'white',
                                    border: 'none',
                                    borderRadius: '8px',
                                    fontWeight: 700,
                                    fontSize: '1.1rem',
                                    cursor: 'pointer'
                                }}
                            >
                                {loading ? 'Submitting...' : 'Submit Charting & Notes'}
                            </button>
                        </div>
                    </div>

                    <button className="check-out-btn" onClick={handleCheckOut}>
                        {checkOutBtn?.label || CONTENT.CHECKOUT.BUTTON}
                    </button>
                </div>
            </div>

            <div className="vitals-grid">
                <div
                    className="vital-card"
                    style={{ position: 'relative', cursor: 'pointer' }}
                    onClick={() => setShowVitalHistory(!showVitalHistory)}
                >
                    <span className="vital-label">{CONTENT.CLINICAL.VITALS_HUB} ℹ️</span>
                    <div className="vital-value">
                        120/80
                        <span className="vital-unit">{COMMON.UNITS.MMHG}</span>
                    </div>
                    {showVitalHistory && (
                        <VitalHistoryTooltip
                            label="Blood Pressure"
                            vitals={[
                                { date: 'Today, 08:00 AM', value: '120/80' },
                                { date: 'Yesterday, 08:00 AM', value: '118/78' },
                                { date: '2 days ago, 08:15 AM', value: '122/82' }
                            ]}
                        />
                    )}
                </div>
                <div className="vital-card" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <div className="rn-connect">
                        <div className="rn-icon-small">📞</div>
                        {CONTENT.CLINICAL.CONNECT_RN}
                    </div>
                </div>
            </div>

            <nav className="visit-nav-overlay">
                <div className="nav-item active" onClick={() => navigate(AdminRegistry.RouteRegistry.PSW.DASHBOARD)}>
                    <span className="nav-icon">🏠</span>
                    <span className="nav-label">{CONTENT.NAV.HOME}</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">📋</span>
                    <span className="nav-label">{CONTENT.NAV.PROTOCOLS}</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">💬</span>
                    <span className="nav-label">{CONTENT.NAV.NURSING}</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">👤</span>
                    <span className="nav-label">{CONTENT.NAV.ACCOUNT}</span>
                </div>
            </nav>
        </div>
    );
}

