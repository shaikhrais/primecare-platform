import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const ProposalBoard: React.FC = () => {
    const { t } = useTranslation();
    const [votes, setVotes] = useState<Record<string, number>>({ p1: 12, p2: 8, p3: 15 });

    const handleVote = (id: string) => {
        setVotes(prev => ({ ...prev, [id]: prev[id] + 1 }));
    };

    const proposals = [
        { id: 'p1', title: t(ContentRegistry.SCRUM_MASTER.PROPOSAL_BOARD.P1), tag: 'High ROI' },
        { id: 'p2', title: t(ContentRegistry.SCRUM_MASTER.PROPOSAL_BOARD.P2), tag: 'Infrastructure' },
        { id: 'p3', title: t(ContentRegistry.SCRUM_MASTER.PROPOSAL_BOARD.P3), tag: 'Security' },
    ];

    return (
        <div className="sm-card" style={{ padding: '2.5rem', background: '#ffffff', marginBottom: '3rem' }}>
            <h3 data-cy="h3-proposal-board-0" style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                💡 {t(ContentRegistry.SCRUM_MASTER.PROPOSAL_BOARD.TITLE)}
            </h3>
            <p style={{ margin: '0 0 2rem 0', color: 'var(--text-300)', fontSize: '0.9rem' }}>
                {t(ContentRegistry.SCRUM_MASTER.PROPOSAL_BOARD.SUBTITLE)}
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem' }}>
                {proposals.map(p => (
                    <div key={p.id} style={{ padding: '1.5rem', background: 'var(--bg-100)', borderRadius: '20px', border: '1px solid var(--border)', display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <span style={{ fontSize: '0.65rem', fontWeight: 800, padding: '4px 10px', background: 'var(--brand-50)', color: 'var(--brand-600)', borderRadius: '30px' }}>{p.tag}</span>
                            <div style={{ fontWeight: 900, fontSize: '1.2rem', color: 'var(--brand-500)' }}>{votes[p.id]}</div>
                        </div>
                        <div style={{ fontWeight: 800, fontSize: '1rem', color: 'var(--text-400)', minHeight: '3em' }}>{p.title}</div>
                        <button data-cy="btn-proposal-board-0"
                            onClick={() => handleVote(p.id)}
                            style={{
                                padding: '10px',
                                background: 'white',
                                border: '1px solid var(--border)',
                                borderRadius: '12px',
                                fontWeight: 800,
                                cursor: 'pointer',
                                transition: '0.2s'
                            }}
                            onMouseEnter={e => e.currentTarget.style.borderColor = 'var(--brand-300)'}
                            onMouseLeave={e => e.currentTarget.style.borderColor = 'var(--border)'}
                        >
                            +1 Vote
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
};
