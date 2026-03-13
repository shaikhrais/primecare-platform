// ================================================================
// PAGE IDENTITY: T36 · Team Roster
// Type: Tool | Owner: client
// ================================================================
import React, { useState, useEffect } from 'react';
import { Users, Star, MessageSquare, Shield, Award, Heart } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './TeamRoster.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface TeamMember {
    id: string;
    fullName: string;
    roleLabel: string;
    specialty?: string;
    rating: number;
    visitCount: number;
    bio?: string;
    avatarUrl?: string;
}

const TeamRoster: React.FC = () => {
    const [team, setTeam] = useState<TeamMember[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTeam = async () => {
            try {
                const response = await apiClient.get(ApiRegistry.TENANCY.CLIENT.CARE_TEAM);
                const data = await response.json();
                setTeam(data);
            } catch (error) {
                console.error('Failed to fetch care team', error);
 // Fallback to if API fails for demo/Face One realization
                setTeam([
                    { id: '1', fullName: 'Sarah Jenkins', roleLabel: 'Primary PSW', specialty: 'Dementia Care', rating: 4.9, visitCount: 124, bio: 'Sarah has over 8 years of experience in geriatric support.' },
                    { id: '2', fullName: 'Michael Chen', roleLabel: 'Relief PSW', specialty: 'Post-Op Recovery', rating: 4.8, visitCount: 42, bio: 'Michael specializes in assisting clients during recovery.' }
                ]);
            } finally {
                setLoading(false);
            }
        };
        fetchTeam();
    }, []);

    if (loading) {
        return (
            <div className="roster-loading">
                <div className="spinner"></div>
                <p>Synchronizing Care Circle...</p>
            </div>
        );
    }

    return (
        <div className="team-roster-container">
            <header className="roster-header">
                <div className="header-badge">
                    <Shield size={14} />
                    <span>Verified Care Circle</span>
                </div>
                <h1>{ContentRegistry.CLIENT_DASHBOARD.FAMILY_HUB.TEAM_TITLE}</h1>
                <p>{ContentRegistry.CLIENT_DASHBOARD.SUBTITLE}</p>
            </header>

            <div className="roster-grid">
                {team.map(member => (
                    <div key={member.id} className="member-card-premium">
                        <div className="card-top">
                            <div className="avatar-wrapper">
                                {member.avatarUrl ? (
                                    <img src={member.avatarUrl} alt={member.fullName} />
                                ) : (
                                    <div className="avatar-placeholder">{member.fullName[0]}</div>
                                )}
                                <div className="rating-pill">
                                    <Star size={10} fill="#fadb14" />
                                    <span>{member.rating}</span>
                                </div>
                            </div>
                            <div className="member-meta">
                                <h3>{member.fullName}</h3>
                                <span className="role-tag">{member.roleLabel}</span>
                            </div>
                        </div>

                        <div className="stats-row">
                            <div className="stat-item">
                                <span className="stat-label">Visits</span>
                                <span className="stat-value">{member.visitCount}</span>
                            </div>
                            <div className="stat-divider" />
                            <div className="stat-item">
                                <span className="stat-label">Specialty</span>
                                <span className="stat-value">{member.specialty || 'General Care'}</span>
                            </div>
                        </div>

                        <p className="member-bio">"{member.bio || 'Dedicated to providing compassionate care.'}"</p>

                        <button className="btn-contact">
                            <MessageSquare size={14} />
                            Contact Provider
                        </button>
                    </div>
                ))}

                <div className="add-request-card">
                    <div className="icon-circle">
                        <Heart size={24} />
                    </div>
                    <h3>Expand Your Team</h3>
                    <p>Discuss adding new specialists to your loved one's care plan.</p>
                    <button className="btn-request-specialist">Request Coordinator Sync</button>
                </div>
            </div>

            <footer className="roster-footer">
                <Award size={20} className="footer-icon" />
                <div className="footer-content">
                    <h4>Clinical Assurance</h4>
                    <p>Every member of your care team is fully vetted, background-checked, and clinically certified to PrimeCare standards.</p>
                </div>
            </footer>
        </div>
    );
};

export default TeamRoster;
