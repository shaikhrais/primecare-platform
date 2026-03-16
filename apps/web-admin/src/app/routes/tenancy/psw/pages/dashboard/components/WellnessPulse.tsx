import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useToast as useNotification } from '@/shared/hooks/useToast';

const { ApiRegistry } = AdminRegistry;

export const WellnessPulse: React.FC = () => {
    const { showToast } = useNotification();
    const [note, setNote] = useState('');

    // TanStack Mutation: wellness pulse submission
    const pulseMutation = useApiMutation<{ status: string; note?: string }, any>(
        ApiRegistry.TENANCY.PSW.WELLNESS_PULSE,
        {
            onSuccess: (_data, variables) => {
                const { status } = variables;
                if (status === 'struggling' || status === 'burnout') {
                    const currentStreak = parseInt(localStorage.getItem('wellness_low_streak') || '0', 10);
                    const newStreak = currentStreak + 1;
                    localStorage.setItem('wellness_low_streak', newStreak.toString());

                    if (newStreak >= 3) {
                        showToast('HR Intervention Triggered: An advocate will reach out to support you today.', 'warning');
                    } else {
                        showToast('Thank you for checking in. We value your wellbeing.', 'success');
                    }
                } else {
                    localStorage.setItem('wellness_low_streak', '0');
                    showToast('Glad you are doing well! Thanks for checking in.', 'success');
                }
                setNote('');
            },
            onError: (error) => {
                console.error('Pulse failed', error);
                showToast('Failed to record pulse.', 'error');
            },
        }
    );

    const handlePulse = (status: string) => {
        pulseMutation.mutate({ status, note: note || undefined });
    };

    const options = [
        { status: 'great', label: 'Feeling Great', icon: '🌟' },
        { status: 'okay', label: 'Doing Okay', icon: '👍' },
        { status: 'struggling', label: 'Struggling', icon: '🔋' },
        { status: 'burnout', label: 'Feeling Burnout', icon: '🆘' },
    ];

    return (
        <div style={{
            backgroundColor: '#FFFFFF',
            padding: '1.5rem',
            borderRadius: '1rem',
            border: '1px solid #E5E7EB',
            marginTop: '1.5rem'
        }} data-cy="wellness-pulse">
            <h3 data-cy="h3-psw.wellness-pulse-0" style={{ margin: '0 0 0.5rem 0', fontSize: '1.1rem', fontWeight: 700 }}>Wellness Pulse</h3>
            <p style={{ margin: '0 0 1rem 0', fontSize: '0.85rem', color: '#6B7280' }}>
                How are you feeling today? Your feedback helps us support you better.
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '0.5rem' }}>
                {options.map((opt) => (
                    <button data-cy="btn-psw.wellness-pulse-0"
                        key={opt.status}
                        disabled={pulseMutation.isPending}
                        onClick={() => handlePulse(opt.status)}
                        style={{
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            gap: '0.25rem',
                            padding: '0.75rem 0.5rem',
                            border: '1px solid #F3F4F6',
                            borderRadius: '0.75rem',
                            backgroundColor: '#F9FAFB',
                            cursor: 'pointer',
                            transition: 'all 0.2s',
                            fontSize: '0.75rem',
                            fontWeight: 600
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.backgroundColor = '#F3F4F6';
                            e.currentTarget.style.borderColor = '#D1D5DB';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.backgroundColor = '#F9FAFB';
                            e.currentTarget.style.borderColor = '#F3F4F6';
                        }}
                    >
                        <span style={{ fontSize: '1.5rem' }}>{opt.icon}</span>
                        {opt.label}
                    </button>
                ))}
            </div>

            <textarea data-cy="textarea-psw.wellness-pulse"
                value={note}
                onChange={(e) => setNote(e.target.value)}
                placeholder="Any specific concerns? (Optional)"
                style={{
                    width: '100%',
                    marginTop: '1rem',
                    padding: '0.75rem',
                    borderRadius: '0.5rem',
                    border: '1px solid #E5E7EB',
                    fontSize: '0.85rem',
                    resize: 'none'
                }}
                rows={2}
            />
        </div>
    );
};
