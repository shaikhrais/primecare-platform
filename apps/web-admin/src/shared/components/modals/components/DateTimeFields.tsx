import React from 'react';

interface SharedProps {
    disabled?: boolean;
}

interface DateTimeFieldsProps extends SharedProps {
    requestedStartAt: string;
    durationMinutes: number;
    onStartChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    onDurationChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export const DateTimeFields: React.FC<DateTimeFieldsProps> = ({
    requestedStartAt, durationMinutes, onStartChange, onDurationChange, disabled
}) => {
    return (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Date & Time</label>
                <input
                    data-cy="inp-start-at"
                    type="datetime-local"
                    required
                    value={requestedStartAt}
                    onChange={onStartChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Duration (min)</label>
                <input
                    data-cy="inp-duration"
                    type="number"
                    required
                    min="30"
                    step="15"
                    value={durationMinutes}
                    onChange={onDurationChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
        </div>
    );
};
