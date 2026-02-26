import React from 'react';

interface SharedProps {
    disabled?: boolean;
}

interface SecondaryVisitFieldsProps extends SharedProps {
    priority: 'normal' | 'urgent';
    recurrence: 'none' | 'daily' | 'weekly' | 'monthly';
    clientNotes: string;
    onPriorityChange: (e: React.ChangeEvent<HTMLSelectElement>) => void;
    onRecurrenceChange: (e: React.ChangeEvent<HTMLSelectElement>) => void;
    onNotesChange: (e: React.ChangeEvent<HTMLTextAreaElement>) => void;
    isEdit?: boolean;
}

export const SecondaryVisitFields: React.FC<SecondaryVisitFieldsProps> = ({
    priority, recurrence, clientNotes, onPriorityChange, onRecurrenceChange, onNotesChange, isEdit, disabled
}) => {
    return (
        <>
            <div style={{ display: 'flex', gap: '1rem' }}>
                <div style={{ flex: 1 }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Priority</label>
                    <select
                        value={priority}
                        onChange={onPriorityChange}
                        disabled={disabled}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    >
                        <option value="normal">Normal</option>
                        <option value="urgent">Urgent (Crisis)</option>
                    </select>
                </div>
                <div style={{ flex: 1 }}>
                    <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Recurrence</label>
                    <select
                        value={recurrence}
                        onChange={onRecurrenceChange}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                        disabled={disabled || !!isEdit}
                    >
                        <option value="none">None</option>
                        <option value="daily">Daily</option>
                        <option value="weekly">Weekly</option>
                        <option value="monthly">Monthly</option>
                    </select>
                </div>
            </div>

            <div>
                <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Instruction/Notes</label>
                <textarea
                    data-cy="inp-notes"
                    value={clientNotes}
                    onChange={onNotesChange}
                    disabled={disabled}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px', resize: 'vertical' }}
                    placeholder="Optional visit instructions..."
                />
            </div>
        </>
    );
};
