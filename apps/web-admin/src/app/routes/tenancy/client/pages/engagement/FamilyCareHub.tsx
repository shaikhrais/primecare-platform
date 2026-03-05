import React, { useState, useEffect } from 'react';
import { History, Users, CreditCard, Heart, MessageSquare, Bell, Star } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import './FamilyCareHub.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;
const { FAMILY_HUB, FEEDBACK_LOOP } = ContentRegistry.CLIENT_DASHBOARD;

const FamilyCareHub: React.FC = () => {
    const [loading, setLoading] = useState(true);
    const [feed, setFeed] = useState<{ notifications: any[], visits: any[] }>({ notifications: [], visits: [] });
    const [feedbackModal, setFeedbackModal] = useState<{ visible: boolean, visitId?: string }>({ visible: false, visitId: undefined });
    const [rating, setRating] = useState(0);
    const [comment, setComment] = useState('');

    useEffect(() => {
        fetchFeed();
    }, []);

    const fetchFeed = async () => {
        // Mock data for initial sweep
        setFeed({
            notifications: [
                { id: '1', type: 'VISIT_STARTED', message: 'Caregiver Clara has arrived at 9:00 AM', createdAt: new Date().toISOString() },
                { id: '2', type: 'BILLING', message: 'New invoice for last week care is ready', createdAt: new Date(Date.now() - 86400000).toISOString() },
            ],
            visits: [
                { id: 'v1', psw: { fullName: 'Clara Oswald', avatarUrl: '' }, requestedStartAt: new Date().toISOString(), status: 'active' },
                { id: 'v2', psw: { fullName: 'Amy Pond', avatarUrl: '' }, requestedStartAt: new Date(Date.now() - 172800000).toISOString(), status: 'completed' },
            ]
        });
        setLoading(false);
    };

    const handleSubmitFeedback = () => {
        // Mock success
        setFeedbackModal({ visible: false, visitId: undefined });
        setRating(0);
        setComment('');
        alert(FEEDBACK_LOOP.SUCCESS_MSG);
    };

    if (loading) {
        return <div className="loading-state">Loading Family Hub...</div>;
    }

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
                        <span className="count">2</span>
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
                        {feed.notifications.map(n => (
                            <div key={n.id} className={`timeline-entry ${n.type.toLowerCase()}`}>
                                <span className="entry-time">{new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                <p className="entry-message">{n.message}</p>
                            </div>
                        ))}
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
                                <div className="avatar">{v.psw.fullName[0]}</div>
                                <div className="member-details">
                                    <h4>{v.psw.fullName}</h4>
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
                            <span className="amount">$240.00</span>
                        </div>
                        <div className="progress-bar">
                            <div className="progress-fill" style={{ width: '70%' }}></div>
                        </div>
                        <button className="btn-pay">Pay Now</button>
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
                        <p>How was today's session?</p>
                        <div className="star-rating-static">
                            {[1, 2, 3, 4, 5].map(s => (
                                <Star key={s} size={20} fill={s <= 4 ? "#fadb14" : "none"} color="#fadb14" />
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
                                <button className="btn btn-primary" onClick={handleSubmitFeedback}>Submit Feedback</button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default FamilyCareHub;
