import React, { useState, useEffect } from 'react';
import { History, Users, CreditCard, Heart, MessageSquare, Bell, Star } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './FamilyCareHub.css';

const { ContentRegistry, ApiRegistry, ButtonRegistry } = AdminRegistry;
const { FAMILY_HUB, FEEDBACK_LOOP } = ContentRegistry.CLIENT_DASHBOARD;

const FamilyCareHub: React.FC = () => {
    const [loading, setLoading] = useState(true);
    const [feed, setFeed] = useState<{ feed: any[], notifications: any[], visits: any[] }>({ feed: [], notifications: [], visits: [] });
    const [stats, setStats] = useState<any>(null);
    const [feedbackModal, setFeedbackModal] = useState<{ visible: boolean, visitId?: string }>({ visible: false, visitId: undefined });
    const [rating, setRating] = useState(0);
    const [comment, setComment] = useState('');

    const fetchHubData = async () => {
        try {
            const [feedRes, statsRes] = await Promise.all([
                apiClient.get(ApiRegistry.TENANCY.CLIENT.FAMILY_FEED),
                apiClient.get(ApiRegistry.TENANCY.CLIENT.DASHBOARD_STATS)
            ]);
            const feedData = await feedRes.json();
            const statsData = await statsRes.json();
            setFeed(feedData);
            setStats(statsData);
        } catch (error) {
            console.error('Failed to load family hub data', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchHubData();
    }, []);

    const handleSubmitFeedback = async () => {
        if (!feedbackModal.visitId) return;

        try {
            const response = await apiClient.post(ApiRegistry.TENANCY.CLIENT.FEEDBACK_SUBMIT, {
                visitId: feedbackModal.visitId,
                rating,
                comment
            });
            const data = await response.json();
            if (response.ok) {
            } catch (error) {
                console.error('Feedback submission failed', error);
            }
        };

        if (loading) {
            return <div className="loading-state">{ContentRegistry.CLIENT_DASHBOARD.MESSAGES.LOADING}</div>;
        }

        const outstandingBalance = stats?.budget?.[0]?.value || 0;

        return (
            <div className="family-hub-container">
                <header className="hub-header">
                    <div className="header-info">
                        <h1>{FAMILY_HUB.TITLE}</h1>
                        <p className="subtitle">{FAMILY_HUB.SUBTITLE}</p>
                    </div>
                    <div className="hub-actions">
                        <div className="notification-badge">
                            <Bell size={20} />
                            {feed.notifications.length > 0 && <span className="count">{feed.notifications.length}</span>}
                        </div>
                    </div>
                </header>

                <div className="bento-grid">
                    {/* CARE TIMELINE */}
                    <div className="bento-item timeline-card">
                        <div className="card-header">
                            <History size={18} />
                            <h3>{FAMILY_HUB.FEED_TITLE}</h3>
                        </div>
                        <div className="timeline-body">
                            {feed.feed && feed.feed.length > 0 ? feed.feed.map((n: any) => (
                                <div key={n.id} className={`timeline-entry ${n.type.toLowerCase()}`}>
                                    <span className="entry-time">{new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                    <p className="entry-message">{n.message}</p>
                                </div>
                            )) : (
                                <p className="empty-msg">No recent activity.</p>
                            )}
                        </div>
                    </div>

                    {/* TEAM PROFILES */}
                    <div className="bento-item team-card">
                        <div className="card-header">
                            <Users size={18} />
                            <h3>{FAMILY_HUB.TEAM_TITLE}</h3>
                        </div>
                        <div className="team-body">
                            {feed.visits.map(v => (
                                <div key={v.id} className="team-member-row">
                                    <div className="avatar">{v.psw?.fullName?.[0] || '?'}</div>
                                    <div className="member-details">
                                        <h4>{v.psw?.fullName || 'Unknown Staff'}</h4>
                                        <span className={`status-pill ${v.status}`}>{v.status}</span>
                                    </div>
                                    {v.status === 'completed' && (
                                        <button className="btn-rate" onClick={() => setFeedbackModal({ visible: true, visitId: v.id })}>
                                            Rate
                                        </button>
                                    )}
                                </div>
                            ))}
                        </div>
                    </div>

                    {/* BILLING PULSE */}
                    <div className="bento-item billing-card">
                        <div className="card-header">
                            <CreditCard size={18} />
                            <h3>{FAMILY_HUB.BILLING_TITLE}</h3>
                        </div>
                        <div className="billing-body">
                            <div className="amount-row">
                                <span className="label">Outstanding</span>
                                <span className="amount">${outstandingBalance.toLocaleString()}</span>
                            </div>
                            <div className="progress-bar">
                                <div className="progress-fill" style={{ width: `${Math.min(100, (outstandingBalance / 5000) * 100)}%` }}></div>
                            </div>
                            <button className="btn-pay" onClick={() => {
                                const btn = ButtonRegistry.find(b => b.id === 'btn-client-family-pay');
                                if (btn?.apiPath) apiClient.post(btn.apiPath, { amount: outstandingBalance });
                            }}>
                                {ButtonRegistry.find(b => b.id === 'btn-client-family-pay')?.label || 'Pay Now'}
                            </button>
                        </div>
                    </div>

                    {/* CARE PULSE (FEEDBACK) */}
                    <div className="bento-item pulse-card">
                        <div className="card-header">
                            <Heart size={18} />
                            <h3>{FAMILY_HUB.PULSE_TITLE}</h3>
                        </div>
                        <div className="pulse-body">
                            <div className="heart-icon-large">
                                <Heart size={48} fill="#ff4d4f" color="#ff4d4f" />
                            </div>
                            <p>{stats?.wellness?.[0]?.day ? `Mood Trend: ${stats.wellness[0].day}` : 'Wellness Pulse'}</p>
                            <div className="star-rating-static">
                                {[1, 2, 3, 4, 5].map(s => (
                                    <Star key={s} size={20} fill={s <= (stats?.wellness?.[0]?.mood || 4) ? "#fadb14" : "none"} color="#fadb14" />
                                ))}
                            </div>
                            <button className="btn-dashed">
                                <MessageSquare size={14} /> Leave a Note
                            </button>
                        </div>
                    </div>
                </div>

                {feedbackModal.visible && (
                    <div className="modal-overlay">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h2>{FEEDBACK_LOOP.TITLE}</h2>
                                <button className="close-btn" onClick={() => setFeedbackModal({ visible: false, visitId: undefined })}>×</button>
                            </div>
                            <div className="modal-body">
                                <p className="modal-subtitle">{FEEDBACK_LOOP.SUBTITLE}</p>
                                <div className="star-rating-input">
                                    {[1, 2, 3, 4, 5].map(s => (
                                        <Star
                                            key={s}
                                            size={32}
                                            onClick={() => setRating(s)}
                                            fill={s <= rating ? "#fadb14" : "none"}
                                            color="#fadb14"
                                            style={{ cursor: 'pointer' }}
                                        />
                                    ))}
                                </div>
                                <textarea
                                    rows={4}
                                    className="feedback-textarea"
                                    placeholder="Additional comments..."
                                    value={comment}
                                    onChange={(e) => setComment(e.target.value)}
                                />
                                <div className="modal-footer">
                                    <button className="btn btn-secondary" onClick={() => setFeedbackModal({ visible: false, visitId: undefined })}>Cancel</button>
                                    <button className="btn btn-primary" onClick={handleSubmitFeedback}>
                                        {ButtonRegistry.find(b => b.id === 'btn-client-star-rating')?.label || 'Submit Feedback'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        );
    };

    export default FamilyCareHub;
