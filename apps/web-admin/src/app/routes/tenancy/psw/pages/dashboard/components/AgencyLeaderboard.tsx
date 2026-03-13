import React from 'react';
import { Trophy, Star, Clock, Heart } from 'lucide-react';

interface LeaderboardEntry {
    rank: number;
    name: string;
    avatarUrl: string;
    compositeScore: number;
    badges: string[];
}

export const AgencyLeaderboard: React.FC = () => {
 // leaders for the Toronto Branch
    const leaders: LeaderboardEntry[] = [
        { rank: 1, name: 'Sarah Jenkins', avatarUrl: 'https://i.pravatar.cc/150?u=sarah', compositeScore: 9.8, badges: ['Perfect Attendance', 'Family Favorite'] },
        { rank: 2, name: 'Michael Osei', avatarUrl: 'https://i.pravatar.cc/150?u=michael', compositeScore: 9.5, badges: ['Wound Care Pro'] },
        { rank: 3, name: 'Elena Rostova', avatarUrl: 'https://i.pravatar.cc/150?u=elena', compositeScore: 9.2, badges: ['Night Owl', 'Perfect Attendance'] },
        { rank: 4, name: 'You', avatarUrl: 'https://i.pravatar.cc/150?u=current', compositeScore: 8.9, badges: ['Dementia Certified'] }
    ];

    const getTrophyColor = (rank: number) => {
        if (rank === 1) return '#FCD34D'; // Gold
        if (rank === 2) return '#94A3B8'; // Silver
        if (rank === 3) return '#B45309'; // Bronze
        return 'transparent';
    };

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '20px', border: '1px solid #E2E8F0', marginTop: '16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                <Trophy size={20} color="#F59E0B" />
                <h3 data-cy="h3-psw.agency-leaderboard-0" style={{ margin: 0, fontSize: '1.1rem', color: '#0F172A', fontWeight: 800 }}>Toronto Branch Leaderboard</h3>
            </div>
            
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                {leaders.map(leader => (
                    <div 
                        key={leader.rank} 
                        style={{ 
                            display: 'flex', alignItems: 'center', padding: '12px', 
                            backgroundColor: leader.name === 'You' ? '#F0F9FF' : '#F8FAFC', 
                            border: leader.name === 'You' ? '1px solid #BAE6FD' : '1px solid #E2E8F0', 
                            borderRadius: '8px' 
                        }}
                    >
                        <div style={{ width: '30px', fontWeight: 800, color: '#64748B', display: 'flex', justifyContent: 'center' }}>
                            {leader.rank <= 3 ? <Trophy size={18} fill={getTrophyColor(leader.rank)} color={getTrophyColor(leader.rank)} /> : `#${leader.rank}`}
                        </div>
                        
                        <img src={leader.avatarUrl} alt={leader.name} style={{ width: '40px', height: '40px', borderRadius: '50%', margin: '0 12px', border: '2px solid white', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }} />
                        
                        <div style={{ flex: 1 }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <span style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.95rem' }}>{leader.name}</span>
                                {leader.name === 'You' && <span style={{ backgroundColor: '#0284C7', color: 'white', fontSize: '0.65rem', padding: '2px 6px', borderRadius: '4px', fontWeight: 800 }}>CURRENT</span>}
                            </div>
                            <div style={{ display: 'flex', gap: '6px', marginTop: '4px' }}>
                                {leader.badges.map((badge, idx) => (
                                    <span key={idx} style={{ backgroundColor: '#FEF3C7', color: '#B45309', fontSize: '0.7rem', padding: '2px 6px', borderRadius: '4px', fontWeight: 600 }}>
                                        {badge}
                                    </span>
                                ))}
                            </div>
                        </div>

                        <div style={{ textAlign: 'right' }}>
                            <div style={{ fontSize: '1.2rem', fontWeight: 900, color: '#0F172A' }}>{leader.compositeScore}</div>
                            <div style={{ fontSize: '0.7rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                <Star size={10} color="#F59E0B" fill="#F59E0B" /> Score
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            
            <p style={{ fontSize: '0.75rem', color: '#94A3B8', textAlign: 'center', marginTop: '16px', fontStyle: 'italic' }}>
                Scores are aggregated weekly based on on-time arrivals, zero dispute tickets, and patient 5-star ratings. Top 3 receive 500 Care Coins at month end.
            </p>
        </div>
    );
};
