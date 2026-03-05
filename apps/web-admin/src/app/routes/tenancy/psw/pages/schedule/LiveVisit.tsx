import React, { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { AdminRegistry, ContentRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import './LiveVisit.css';

const CONTENT = ContentRegistry.PSW_LIVE_VISIT;

export default function LiveVisit() {
    const { id } = useParams();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [status, setStatus] = useState<'idle' | 'checked_in' | 'completed'>('idle');
    const [currentTime, setCurrentTime] = useState(new Date().toLocaleTimeString());
    const [elapsed, setElapsed] = useState(0);
    const [tasks, setTasks] = useState([
        { id: '1', label: 'Medication Administration', done: false },
        { id: '2', label: 'Mobility Support & Transfers', done: false },
        { id: '3', label: 'Hydration & Nutrition Check', done: false },
        { id: '4', label: 'Documentation Sink', done: false },
    ]);

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

    const handleCheckIn = () => {
        setStatus('checked_in');
        showToast('GPS Verified. Visit Started.', 'success');
    };

    const handleCheckOut = () => {
        setStatus('completed');
        showToast(CONTENT.MESSAGES.SUCCESS, 'success');
        navigate(AdminRegistry.RouteRegistry.PSW.HANDOVER);
    };

    return (
        <div className="live-visit-container">
            <header className="live-header">
                <div className="header-left">
                    <div className="header-icon">
                        {status === 'checked_in' ? '⏱️' : '🏠'}
                    </div>
                    <div className="header-text">
                        <h1>{status === 'checked_in' ? CONTENT.HEADER.IN_PROGRESS : CONTENT.HEADER.IDLE}</h1>
                        <p>Sarah Jenkins • Morning Shift</p>
                    </div>
                </div>
                <div className="header-right">
                    <div className="clock-face">{currentTime}</div>
                    <div className="clock-label">{CONTENT.HEADER.STAMP}</div>
                </div>
            </header>

            <div className={`session-block ${status === 'checked_in' ? 'session-active' : 'session-idle'}`}>
                {status === 'checked_in' && <div className="pulse-bg" />}

                {status === 'idle' ? (
                    <>
                        <div className="idle-icon-container">📍</div>
                        <div className="idle-text-group">
                            <h2>{CONTENT.CHECKIN.TITLE}</h2>
                            <p>{CONTENT.CHECKIN.DESC}</p>
                        </div>
                        <button className="check-in-btn" onClick={handleCheckIn}>
                            {CONTENT.CHECKIN.BUTTON}
                        </button>
                    </>
                ) : (
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
                            <h3 className="tasks-title">{CONTENT.CLINICAL.TITLE}</h3>
                            {tasks.map(task => (
                                <div
                                    key={task.id}
                                    className={`task-item ${task.done ? 'done' : ''}`}
                                    onClick={() => toggleTask(task.id)}
                                >
                                    <span className="task-label">{task.label}</span>
                                    <div className="task-checkbox">
                                        {task.done ? '✓' : ''}
                                    </div>
                                </div>
                            ))}
                        </div>

                        <button className="check-out-btn" onClick={handleCheckOut}>
                            {CONTENT.CHECKOUT.BUTTON}
                        </button>
                    </div>
                )}
            </div>

            <div className="vitals-grid">
                <div className="vital-card">
                    <span className="vital-label">{CONTENT.CLINICAL.VITALS_HUB}</span>
                    <div className="vital-value">
                        120/80
                        <span className="vital-unit">mmHg</span>
                    </div>
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
                    <span className="nav-label">Home</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">📋</span>
                    <span className="nav-label">Protocols</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">💬</span>
                    <span className="nav-label">Nursing</span>
                </div>
                <div className="nav-item">
                    <span className="nav-icon">👤</span>
                    <span className="nav-label">Account</span>
                </div>
            </nav>
        </div>
    );
}

