import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import './CareTeam.css';

interface TeamMember {
    id: string;
    name: string;
    role: string;
    specialty: string;
    rating: number;
    visits: number;
    bio: string;
}

export default function CareTeam() {
    const { t } = useTranslation();
    const [team] = useState<TeamMember[]>([
        { id: '1', name: 'Sarah Jenkins', role: 'Primary PSW', specialty: 'Dementia Care', rating: 4.9, visits: 124, bio: 'Sarah has over 8 years of experience in geriatric support and specialized memory care.' },
        { id: '2', name: 'Michael Chen', role: 'Relief PSW', specialty: 'Post-Op Recovery', rating: 4.8, visits: 42, bio: 'Michael specializes in assisting clients during their recovery from major orthopedic surgeries.' },
        { id: '3', name: 'Nurse Sarah', role: 'Nursing Lead', specialty: 'Clinical Oversight', rating: 5.0, visits: 12, bio: 'Sarah oversees clinical protocols and medication management for high-complexity clients.' },
    ]);

    return (
        <div className="care-team-container" style={{ fontFamily: 'var(--font-sans)', display: 'flex', flexDirection: 'column', gap: '2rem' }}>
            <header className="care-team-header">
                <div className="care-team-header-bg">
                    🤝
                </div>
                <div>
                    <div className="care-team-subtitle">
                        <span className="care-team-subtitle-dot" />
                        <span className="care-team-subtitle-text">Active Care Circle</span>
                    </div>
                    <h1 className="care-team-title">My Care Team</h1>
                    <p className="care-team-desc">Meet the dedicated professionals supporting your family's health journey.</p>
                </div>
            </header>

            <div className="care-team-grid">
                {team.map(member => (
                    <div key={member.id} className="care-team-card">
                        <div className="care-team-card-content">
                            <div className="care-team-avatar-wrapper">
                                <div className="care-team-avatar">
                                    {member.name.split(' ').map(n => n[0]).join('')}
                                </div>
                                <div className="care-team-rating">
                                    <span className="care-team-rating-star">★</span>
                                    <span className="care-team-rating-score">{member.rating}</span>
                                </div>
                            </div>

                            <div>
                                <h3 className="care-team-member-name">{member.name}</h3>
                                <div className="care-team-member-role">{member.role}</div>
                            </div>

                            <div className="care-team-stats">
                                <div className="care-team-stat-box">
                                    <div className="care-team-stat-label">Visits</div>
                                    <div className="care-team-stat-value">{member.visits}</div>
                                </div>
                                <div className="care-team-stat-divider" />
                                <div className="care-team-stat-box">
                                    <div className="care-team-stat-label">Focus</div>
                                    <div className="care-team-stat-focus">{member.specialty}</div>
                                </div>
                            </div>

                            <p className="care-team-bio">
                                "{member.bio}"
                            </p>

                            <button className="care-team-action-btn">
                                Send Message
                            </button>
                        </div>
                    </div>
                ))}

                <div className="care-team-request-card">
                    <div className="care-team-request-icon">➕</div>
                    <div>
                        <div className="care-team-request-title">Request Specialist</div>
                        <p className="care-team-request-desc">Need a physical therapist or specialized RMT? Call coordinate to add to team.</p>
                    </div>
                </div>
            </div>

            <div className="care-team-footer">
                <div className="care-team-footer-icon">🔐</div>
                <div>
                    <h3 className="care-team-footer-title">Clinically Verified Network</h3>
                    <p className="care-team-footer-desc">
                        Every professional in your care circle has undergone a mandatory criminal background check, vulnerable sector screening, and rigorous clinical credential verification.
                    </p>
                </div>
            </div>
        </div>
    );
}
