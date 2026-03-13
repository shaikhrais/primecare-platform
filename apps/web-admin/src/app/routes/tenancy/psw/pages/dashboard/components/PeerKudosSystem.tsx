import React, { useState } from 'react';
import { Award, Star, ThumbsUp, Heart } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

export const PeerKudosSystem: React.FC = () => {
    const { showToast } = useNotification();
    const [selectedBadge, setSelectedBadge] = useState<string | null>(null);
    const [recipient, setRecipient] = useState<string>('');
    const [note, setNote] = useState<string>('');

    const badges = [
        { id: 'team_player', icon: <ThumbsUp />, label: 'Team Player', color: '#3B82F6' },
        { id: 'lifesaver', icon: <Heart />, label: 'Lifesaver', color: '#EF4444' },
        { id: 'superstar', icon: <Star />, label: 'Shift Superstar', color: '#F59E0B' },
        { id: 'mentor', icon: <Award />, label: 'Great Mentor', color: '#8B5CF6' }
    ];

    const handleSubmit = () => {
        if (!selectedBadge || !recipient) {
            showToast('Please select a badge and enter a colleague name.', 'error');
            return;
        }

        showToast(`Kudos sent to ${recipient}!`, 'success');
        if (window.navigator?.vibrate) window.navigator.vibrate(50);
        setSelectedBadge(null);
        setRecipient('');
        setNote('');
    };

    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', padding: '24px' }}>
            <h3 data-cy="h3-psw.peer-kudos-system-0" style={{ margin: '0 0 16px 0', fontSize: '1.2rem', fontWeight: 800, color: '#111827', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Award size={20} color="#F59E0B" /> Send Peer Kudos
            </h3>
            <p style={{ color: '#4B5563', fontSize: '0.9rem', marginBottom: '20px' }}>
                Recognize a colleague who went above and beyond during a recent shift cluster.
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '12px', marginBottom: '20px' }}>
                {badges.map(b => (
                    <button data-cy="btn-psw.peer-kudos-system-0"
                        key={b.id}
                        onClick={() => setSelectedBadge(b.id)}
                        style={{
                            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px', padding: '16px 8px',
                            backgroundColor: selectedBadge === b.id ? `${b.color}15` : '#F9FAFB',
                            border: `2px solid ${selectedBadge === b.id ? b.color : '#E5E7EB'}`,
                            borderRadius: '12px', cursor: 'pointer', transition: 'all 0.2s',
                            color: selectedBadge === b.id ? b.color : '#6B7280'
                        }}
                    >
                        <div style={{ color: b.color }}>{b.icon}</div>
                        <span style={{ fontWeight: 600, fontSize: '0.85rem' }}>{b.label}</span>
                    </button>
                ))}
            </div>

            <input data-cy="input-psw.peer-kudos-system-0"
                type="text"
                value={recipient}
                onChange={e => setRecipient(e.target.value)}
                placeholder="Colleague Name..."
                style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #D1D5DB', marginBottom: '12px', boxSizing: 'border-box' }}
            />

            <textarea data-cy="textarea-psw.peer-kudos-system"
                value={note}
                onChange={e => setNote(e.target.value)}
                placeholder="Optional shoutout note..."
                style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #D1D5DB', minHeight: '60px', marginBottom: '16px', boxSizing: 'border-box' }}
            />

            <button data-cy="btn-psw.peer-kudos-system-1"
                onClick={handleSubmit}
                style={{
                    width: '100%', padding: '14px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 700, cursor: 'pointer'
                }}
            >
                Send Badge
            </button>
        </div>
    );
};
